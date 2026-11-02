-- PBZ_UHSMFF：修复“不灭侠胆”支线坏档
-- F8 ：已击杀但没拿到记忆的不灭侠胆 NPC，补发对应的记忆（帮助正道解脱N）
-- F10：记忆 ≥ 4 朵且任务尚未完成时，把任务推进到完成，并补发奖励“不灭侠胆”（TU_19006）
-- （不用 F11：游戏里 F11 会切换窗口缩放）
-- Author: M4kis3Kurisu (Nexus Mods)
-- License: MIT (see LICENSE)

local VERSION = "1.1.0"
local TAG = "[PBZ_UHSMFF] "
local function log(fmt, ...)
    print(TAG .. string.format(fmt, ...) .. "\n")
end

-- 死亡标签 → 记忆标签。配对依据：存档中每位 NPC 的“杀完/表演/死亡”之后紧接着写入的就是对应的解脱N；
-- 任务的 6 个子任务所在地图也与此对应
local MEMORIES = {
    { name = "紫衣双刃", dead = "zddy.不灭侠胆.紫衣双刃死亡", memory = "pz.不灭侠胆.帮助正道解脱1" },
    { name = "双剑", dead = "pz.不灭侠胆.双剑怪死亡", memory = "pz.不灭侠胆.帮助正道解脱2" },
    { name = "紫衣剑客", dead = "zddy.不灭侠胆.紫衣剑客死亡", memory = "pz.不灭侠胆.帮助正道解脱3" },
    { name = "刀卫", dead = "pz.不灭侠胆.刀卫怪死亡", memory = "pz.不灭侠胆.帮助正道解脱4" },
    { name = "白山护法", dead = "zddy.不灭侠胆.白山护法死亡", memory = "pz.不灭侠胆.帮助正道解脱5" },
    { name = "护法", dead = "pz.不灭侠胆.护法怪死亡", memory = "pz.不灭侠胆.帮助正道解脱6" },
}

-- 任务：分支 "1" 有 6 个子任务，分别检查 任务进度1~6，完成 4 个即可；任务失败 是它的失败标签。
-- 坏档时任务停在“没有阶段、没有分支”的状态，补标签不会再被检查，直接进入完成阶段 State_3
local QUEST_CLASS = "/Game/PBZstory/PBZQuest/Simple/BuMieXiaDan.BuMieXiaDan_C"
local QUEST_DONE_STATE = "BuMieXiaDan_PBZQuestState_3"
local PROGRESS_TAG = "pz.不灭侠胆.任务进度"
local FAIL_TAG = "pz.不灭侠胆.任务失败"
local REQUIRED = 4
-- 奖励：BPF_BuMieXiaDan_Memory_1~6 里凑够 4 朵时由 GetItems 发放
local REWARD_ID = "TU_19006"
-- 标签没有删除接口：把目标元素改写成容器里已有的无害标签，读档时游戏会自动去重
local FILLER_TAG = "GameMode.Normal"

local function valid(obj)
    local ok, v = pcall(function() return obj:IsValid() end)
    return ok and v == true
end

local function findFirst(name)
    local ok, o = pcall(FindFirstOf, name)
    return (ok and valid(o)) and o or nil
end

local function hasTag(epm, t)
    local ok, r = pcall(function() return epm:HasTagWithOutSource({ TagName = FName(t) }) end)
    return ok and r == true
end

local function addTag(epm, t)
    pcall(function() epm:AddTagsByString(t) end)
    return hasTag(epm, t)
end

local function removeTag(epm, t)
    for _, arr in ipairs({ epm.GlobalTags.GameplayTags, epm.CacheTags.Tags.GameplayTags }) do
        pcall(function()
            arr:ForEach(function(_, e)
                local tag = e:get()
                if tag.TagName:ToString() == t then tag.TagName = FName(FILLER_TAG) end
            end)
        end)
    end
    return not hasTag(epm, t)
end

-- 当前拥有记忆的编号列表
local function ownedMemories(epm)
    local owned = {}
    for i, m in ipairs(MEMORIES) do
        if hasTag(epm, m.memory) then owned[#owned + 1] = i end
    end
    return owned
end

-- F8：已击杀但缺记忆的，补发记忆
local function restoreMemories(epm)
    local owned, fixed = {}, 0
    for i, m in ipairs(MEMORIES) do
        local dead, has = hasTag(epm, m.dead), hasTag(epm, m.memory)
        if dead and not has then
            has = addTag(epm, m.memory)
            if has then fixed = fixed + 1 end
        end
        if has then owned[#owned + 1] = i end
        log("#%d %s：已击杀 killed=%s 记忆 memory=%s", i, m.name, tostring(dead), tostring(has))
    end
    log("补发记忆 %d 个，当前共有 %d 朵 / restored %d, now %d memories", fixed, #owned, fixed, #owned)
    return owned
end

local function questSucceeded(comp, cls)
    local ok, r = pcall(function() return comp:IsQuestSucceeded(cls) end)
    return ok and r == true
end

-- F10：记忆 ≥ 4 时把任务推进到完成；返回 true 表示这次由本 mod 完成了任务
local function completeQuest(epm, owned)
    if #owned < REQUIRED then
        log("记忆只有 %d 朵，不足 %d 朵，任务保持原样（缺记忆可先按 F8）/ only %d memories (need %d), quest unchanged; press F8 first if memories are missing", #owned, REQUIRED, #owned, REQUIRED)
        return false
    end
    local comp = findFirst("NarrativeComponent")
    local okC, cls = pcall(StaticFindObject, QUEST_CLASS)
    if not comp or not okC or not valid(cls) then
        log("找不到任务系统 / quest system not found")
        return false
    end
    if questSucceeded(comp, cls) then
        log("任务已完成，无需处理 / quest already completed")
        return false
    end
    local okQ, quest = pcall(function() return comp:GetQuest(cls) end)
    if not okQ or not valid(quest) then
        log("尚未接取任务，请先与紫衣狼统领对话 / quest not started, talk to the Purple-Robed Wolf Leader first")
        return false
    end

    for _, n in ipairs(owned) do
        if not hasTag(epm, PROGRESS_TAG .. n) then addTag(epm, PROGRESS_TAG .. n) end
    end
    if hasTag(epm, FAIL_TAG) then
        log("清除 任务失败 标记 / clear quest-failed flag：%s", tostring(removeTag(epm, FAIL_TAG)))
    end

    local okS, st = pcall(function() return quest:GetState(FName(QUEST_DONE_STATE)) end)
    if not okS or not valid(st) then
        log("找不到任务完成阶段 / completion state not found")
        return false
    end
    pcall(function() quest:EnterState(st) end)
    local done = questSucceeded(comp, cls)
    log("任务完成 / quest completed：%s", tostring(done))
    return done
end

-- 仅在本 mod 完成任务时补发奖励，背包里已有则不发，避免重复
local function grantReward()
    local bp = findFirst("PBZBackPackSubsystem")
    if not bp then return log("找不到背包系统，奖励未发放 / backpack not found, reward not granted") end
    local ok, n = pcall(function() return bp:GetUsablePropNum(FName(REWARD_ID)) end)
    if not ok or n == nil then return log("无法查询背包，奖励未发放 / cannot query backpack, reward not granted") end
    if n > 0 then return log("背包里已有不灭侠胆，不重复发放 / reward already owned") end
    pcall(function() bp:AddPropsToBackPack(1, FName(REWARD_ID), true) end)
    local _, after = pcall(function() return bp:GetUsablePropNum(FName(REWARD_ID)) end)
    log("发放不灭侠胆 / granted reward %s：%s", REWARD_ID, tostring(after))
end

local function epmOrWarn(key)
    local epm = findFirst("EventPipelineManager")
    if not epm then log("未找到 EventPipelineManager，请读档进入游戏后再按 %s / Load your save first, then press %s", key, key) end
    return epm
end

local function onRestore()
    local epm = epmOrWarn("F8")
    if not epm then return end
    restoreMemories(epm)
    log("完成，请存档 / Done, please save the game")
end

local function onComplete()
    local epm = epmOrWarn("F10")
    if not epm then return end
    if completeQuest(epm, ownedMemories(epm)) then grantReward() end
    log("完成，请存档 / Done, please save the game")
end

RegisterKeyBind(Key.F8, function() ExecuteInGameThread(onRestore) end)
RegisterKeyBind(Key.F10, function() ExecuteInGameThread(onComplete) end)
log("v%s 已加载 loaded：F8 补发记忆 / restore memories，F10 记忆≥4 时完成任务并发放奖励 / complete quest when 4+ memories", VERSION)
