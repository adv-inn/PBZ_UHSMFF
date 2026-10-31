-- PBZ_UHSMFF：修复“不灭侠胆”支线坏档
-- 击杀了不灭侠胆却没有拿到记忆（帮助正道解脱N）时，按 Ctrl+F11 补发对应的记忆标签。
-- 只处理“已击杀且缺记忆”的情况，其他状态不做任何改动。
-- Author: M4kis3Kurisu (Nexus Mods)
-- License: MIT (see LICENSE)

local VERSION = "1.0.0"
local TAG = "[PBZ_UHSMFF] "
local function log(fmt, ...)
    print(TAG .. string.format(fmt, ...) .. "\n")
end

-- 死亡标签 → 记忆标签。配对依据：存档中每位 NPC 的“杀完/表演/死亡”之后紧接着写入的就是对应的解脱N
local MEMORIES = {
    { name = "紫衣双刃", dead = "zddy.不灭侠胆.紫衣双刃死亡", memory = "pz.不灭侠胆.帮助正道解脱1" },
    { name = "双剑", dead = "pz.不灭侠胆.双剑怪死亡", memory = "pz.不灭侠胆.帮助正道解脱2" },
    { name = "紫衣剑客", dead = "zddy.不灭侠胆.紫衣剑客死亡", memory = "pz.不灭侠胆.帮助正道解脱3" },
    { name = "刀卫", dead = "pz.不灭侠胆.刀卫怪死亡", memory = "pz.不灭侠胆.帮助正道解脱4" },
    { name = "白山护法", dead = "zddy.不灭侠胆.白山护法死亡", memory = "pz.不灭侠胆.帮助正道解脱5" },
    { name = "护法", dead = "pz.不灭侠胆.护法怪死亡", memory = "pz.不灭侠胆.帮助正道解脱6" },
}

local function valid(obj)
    local ok, v = pcall(function() return obj:IsValid() end)
    return ok and v == true
end

local function hasTag(epm, t)
    local ok, r = pcall(function() return epm:HasTagWithOutSource({ TagName = FName(t) }) end)
    return ok and r == true
end

local function fix()
    local ok, epm = pcall(FindFirstOf, "EventPipelineManager")
    if not ok or not valid(epm) then return log("未找到 EventPipelineManager，请读档进入游戏后再按 / Load your save first, then press Ctrl+F11") end

    local fixed = 0
    for i, m in ipairs(MEMORIES) do
        local dead, has = hasTag(epm, m.dead), hasTag(epm, m.memory)
        if dead and not has then
            -- 游戏自己的加标签接口，会通知正在监听该标签的任务流程
            pcall(function() epm:AddTagsByString(m.memory) end)
            has = hasTag(epm, m.memory)
            if has then fixed = fixed + 1 end
        end
        log("#%d %s：已击杀 killed=%s 记忆 memory=%s", i, m.name, tostring(dead), tostring(has))
    end
    log("检查完成，补发 %d 个记忆，有补发时请存档 / Done, restored %d memories; save the game if any were restored", fixed, fixed)
end

RegisterKeyBind(Key.F11, { ModifierKey.CONTROL }, function() ExecuteInGameThread(fix) end)
log("v%s 已加载 loaded：Ctrl+F11 检查并补发不灭侠胆记忆 / check and restore Bumie Xiadan memories", VERSION)
