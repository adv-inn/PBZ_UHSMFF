# PBZ_UHSMFF — Undying Heroic Spirit Memory Flower Fix

A [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) Lua mod for **Phantom Blade Zero** that fixes the *Undying Heroic Spirit* (不灭侠胆) side quest soft-lock.

[中文说明](#中文)

![Restored Memory Flower](screenshot.png)

## The problem

In *Undying Heroic Spirit* you find NPCs fighting a group of enemies. After the fight they turn hostile, and killing them should spawn their **Memory Flower** at the encounter spot. If you kill them too late, or the NPC bugs out, the flower never spawns. The quest needs four Memory Flowers to turn in; if a bug leaves you with fewer than four, you can't hand in the quest.

## What it does

Press **Ctrl+F11** in game. For each of the six NPCs:

- Killed **and** Memory Flower missing → the flower is restored.
- Anything else (not met, still alive, flower already obtained) → nothing is changed.

The mod calls the game's own `EventPipelineManager:AddTagsByString` to add the missing memory tag, so the quest continues the normal way.

| # | NPC | Death tag | Memory tag |
|---|---|---|---|
| 1 | 紫衣双刃 | `zddy.不灭侠胆.紫衣双刃死亡` | `pz.不灭侠胆.帮助正道解脱1` |
| 2 | 双剑 | `pz.不灭侠胆.双剑怪死亡` | `pz.不灭侠胆.帮助正道解脱2` |
| 3 | 紫衣剑客 | `zddy.不灭侠胆.紫衣剑客死亡` | `pz.不灭侠胆.帮助正道解脱3` |
| 4 | 刀卫 | `pz.不灭侠胆.刀卫怪死亡` | `pz.不灭侠胆.帮助正道解脱4` |
| 5 | 白山护法 | `zddy.不灭侠胆.白山护法死亡` | `pz.不灭侠胆.帮助正道解脱5` |
| 6 | 护法 | `pz.不灭侠胆.护法怪死亡` | `pz.不灭侠胆.帮助正道解脱6` |

Verified on a broken save for #6; the other five use the same mechanism.

## Installation

1. Install UE4SS.
2. Copy this folder into UE4SS's `Mods` folder as `PBZ_UHSMFF` (Steam: `PBZ\platform\steam\ue4ss\Mods\PBZ_UHSMFF`).
   It must contain `Scripts\main.lua` and `enabled.txt`.
3. Back up your save (`ProjectPBZ\Saved\SaveGames\`).
4. Load your save and press **Ctrl+F11**.
5. Pick up the Memory Flower at the encounter spot, confirm the quest progresses, then save.

Results are written to `ue4ss\UE4SS.log` (search for `PBZ_UHSMFF`).

## License

[MIT](LICENSE) © 2026 M4kis3Kurisu

This is an unofficial fan-made mod and is not affiliated with or endorsed by the developers of Phantom Blade Zero.

---

## 中文

适用于《影之刃零》的 UE4SS Lua mod，修复支线「不灭侠胆」卡任务的问题。

**问题**：支线中的 NPC 与小怪战斗结束后会转为敌对，击杀后应在遭遇位置生成记忆之花。击杀得太晚或 NPC 出现异常时，记忆之花不会生成。任务需要交付 4 朵记忆之花，如果因此少于 4 朵，就无法交任务。

**功能**：游戏中按 **Ctrl+F11**，逐个检查六位 NPC。只给“已击杀但缺少记忆之花”的 NPC 补发记忆，其余状态不做任何改动。补发使用游戏自带的任务标签接口，支线照常推进。已在第六位（后街「护法」）的坏档上验证。

**安装**：

1. 安装 UE4SS。
2. 把本文件夹以 `PBZ_UHSMFF` 为名放入 UE4SS 的 `Mods` 文件夹（Steam 版：`PBZ\platform\steam\ue4ss\Mods\PBZ_UHSMFF`），确保包含 `Scripts\main.lua` 和 `enabled.txt`。
3. 备份存档（`ProjectPBZ\Saved\SaveGames\`）。
4. 读档进入游戏，按 **Ctrl+F11**。
5. 到遭遇位置拾取记忆之花，确认支线推进后存档。

结果写在 `ue4ss\UE4SS.log` 中（搜索 `PBZ_UHSMFF`）。

**许可证**：[MIT](LICENSE) © 2026 M4kis3Kurisu。本 mod 为非官方玩家作品，与《影之刃零》开发商无关。
