PBZ_UHSMFF v1.0.0 —— 不灭侠胆记忆修复 / Undying Heroic Spirit Memory Flower Fix
Author / 作者: M4kis3Kurisu (Nexus Mods)
License / 许可证: MIT (see LICENSE)
Source / 源码: https://github.com/adv-inn/PBZ_UHSMFF

【中文】
问题：
支线「不灭侠胆」中，NPC 与小怪战斗结束后会转为敌对，击杀后应在遭遇位置生成记忆之花。
击杀得太晚或 NPC 出现异常时，记忆之花不会生成，支线因此卡住。

用法：
1. 先安装 UE4SS。
2. 把整个 PBZ_UHSMFF 文件夹放进 UE4SS 的 Mods 文件夹
   （Steam 版：PBZ\platform\steam\ue4ss\Mods\）。
3. 读档进入游戏，按 Ctrl+F11。
4. 已击杀但缺少记忆之花的 NPC 会被补发；其余状态不做任何改动。
   结果写在 ue4ss\UE4SS.log 中（搜索 PBZ_UHSMFF）。
5. 到原遭遇位置拾取记忆之花，确认支线推进后存档。修复完成后可以删除本 mod。

说明：
- 已在第六位（后街「护法」）的坏档上验证；其余五位使用同一套机制。
- 修改前请备份存档。

【English】
Problem:
In the Undying Heroic Spirit side quest, NPCs turn hostile after fighting a group of enemies,
and killing them should spawn a Memory Flower at the encounter spot. If they are killed too late
or the NPC bugs out, the Memory Flower never spawns and the quest is soft-locked.

Usage:
1. Install UE4SS first.
2. Put the whole PBZ_UHSMFF folder into UE4SS's Mods folder
   (Steam: PBZ\platform\steam\ue4ss\Mods\).
3. Load your save and press Ctrl+F11.
4. Every NPC that was killed but has no Memory Flower gets it restored; nothing else is changed.
   Results are written to ue4ss\UE4SS.log (search for PBZ_UHSMFF).
5. Pick up the Memory Flower at the encounter spot, confirm the quest progresses, then save.
   You can remove this mod afterwards.

Notes:
- Verified on a broken save for the sixth NPC (Houjie). The other five use the same mechanism.
- Back up your save before using it.
