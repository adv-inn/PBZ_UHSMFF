PBZ_UHSMFF v1.1.0 —— 不灭侠胆记忆修复 / Undying Heroic Spirit Memory Flower Fix
Author / 作者: M4kis3Kurisu (Nexus Mods)
License / 许可证: MIT (see LICENSE)
Source / 源码: https://github.com/adv-inn/PBZ_UHSMFF

【中文】
问题：
支线「不灭侠胆」中，NPC 与小怪战斗结束后会转为敌对，击杀后应在遭遇位置生成记忆之花。
击杀得太晚或 NPC 出现异常时，记忆之花不会生成。
任务需要交付 4 朵记忆之花，如果因此少于 4 朵，就无法交任务。
另外，有的存档即使已经收集了 4 朵以上，任务也会卡在“自由探索、没有目标”的状态，无法交付。

按键：
- F8 ：补发记忆。已击杀但没有生成记忆之花的 NPC，补发对应的记忆，记忆之花会在原遭遇位置重新出现。
- F10：完成任务。记忆达到 4 朵且任务尚未完成时，把任务推进到完成，并发放奖励「不灭侠胆」。
（不使用 F11：游戏中 F11 会切换窗口缩放。）

用法：
1. 先安装 UE4SS。
2. 把整个 PBZ_UHSMFF 文件夹放进 UE4SS 的 Mods 文件夹
   （Steam 版：PBZ\platform\steam\ue4ss\Mods\）。
3. 备份存档（ProjectPBZ\Saved\SaveGames\）。
4. 读档进入游戏：
   - 缺记忆时按 F8，然后到原遭遇位置拾取记忆之花；
   - 记忆达到 4 朵但无法交付时按 F10。
5. 确认结果后存档。修复完成后可以删除本 mod。
结果写在 ue4ss\UE4SS.log 中（搜索 PBZ_UHSMFF）。

说明：
- F8 只处理“已击杀且缺记忆”的 NPC；F10 只在记忆 ≥ 4 朵、任务已接取且未完成时生效。
- F10 只在本次由 mod 完成任务时发放「不灭侠胆」，背包里已有则不重复发放。
- 任务尚未向紫衣狼统领接取时，F10 不做任何改动。
- 修改前请备份存档。

更新记录：
- 1.1.0：新增 F10 完成任务并发放「不灭侠胆」；按键由 Ctrl+F11 改为 F8（补发记忆）。
- 1.0.0：Ctrl+F11 补发缺失的记忆。

【English】
Problem:
In the Undying Heroic Spirit side quest, NPCs turn hostile after fighting a group of enemies,
and killing them should spawn a Memory Flower at the encounter spot. If they are killed too late
or the NPC bugs out, the Memory Flower never spawns. The quest needs four Memory Flowers to turn in,
so with fewer than four you can't hand it in. Some saves also get stuck in "free exploration" with
no objective even after collecting four or more flowers.

Hotkeys:
- F8 : Restore memories. Every NPC that was killed but never dropped a Memory Flower gets it back;
       the flower reappears at the encounter spot.
- F10: Complete the quest. With 4+ memories and the quest not yet completed, the quest is completed
       and the reward "Undying Heroic Spirit" (不灭侠胆) is granted.
(F11 is not used: in game it toggles window scaling.)

Usage:
1. Install UE4SS first.
2. Put the whole PBZ_UHSMFF folder into UE4SS's Mods folder
   (Steam: PBZ\platform\steam\ue4ss\Mods\).
3. Back up your save (ProjectPBZ\Saved\SaveGames\).
4. Load your save:
   - Missing flowers: press F8, then pick up the Memory Flower at the encounter spot.
   - 4+ memories but can't hand in the quest: press F10.
5. Check the result, then save. You can remove this mod afterwards.
Results are written to ue4ss\UE4SS.log (search for PBZ_UHSMFF).

Notes:
- F8 only touches NPCs that were killed and are missing their memory. F10 only acts with 4+ memories
  and a quest that has been accepted but not completed.
- F10 grants the reward only when the mod itself completes the quest, and never if you already own it.
- If the quest has not been accepted from the Purple-Robed Wolf Leader yet, F10 changes nothing.
- Back up your save before using it.

Changelog:
- 1.1.0: Added F10 to complete the quest and grant the reward; restore hotkey changed from Ctrl+F11 to F8.
- 1.0.0: Ctrl+F11 restores missing memories.
