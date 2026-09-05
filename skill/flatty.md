---
name: flatty
description: Use whenever generating Roblox UI (ScreenGui, Frame, TextButton, TextLabel, bars, panels, HUDs, menus) with Luau/Instance.new code. Pulls real reference examples from the ui-roblox-skill GitHub repo instead of guessing a design. Trigger this any time the user wants Roblox GUI code, even if they don't mention "design system" or "style" by name.
---

# Roblox Flat UI

The reference design lives in a real repo, not in this file:
https://github.com/pidaraks1488/ui-roblox-skill

Before writing any UI code, pull the actual files from that repo and copy their patterns. Do not rely on memory of what was in the repo from a previous turn — fetch fresh each time you start a new UI task, since the repo can be updated.

## How to get the examples

Fetch the raw files directly, for example:

```
https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/button.lua
https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/button-shadow.lua
https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/frame.lua
https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/label.lua
https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/bar.lua
https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/cube.lua
```

If the folder structure has changed, list the repo tree first (via the GitHub API or by browsing the repo) and pull whatever `.lua` files exist under `ui/`. Read a few of them before writing anything — the goal is to match what's actually there, not what you assume is there.

## What to copy from the examples

Look at the fetched files and extract:

- the exact colors used (`Color3.fromRGB(...)` values for panels, buttons, bars, text)
- corner/border style (in the examples: `BorderSizePixel = 0`, no `UICorner` — sharp rectangles, not rounded)
- how depth is done (`Instance.new("UIShadow", ...)`, not fake blur frames)
- the font (`Font.new(...)` calls, weight, style)
- the button structure — the examples build a button as a `Frame` (visual) plus a separate `TextButton` named `hitbox` on top with `BackgroundTransparency = 1` and `TextTransparency = 1`, so the clickable area is decoupled from the visual layer
- sizing conventions (mostly fixed offsets, e.g. `UDim2.new(0, 150, 0, 50)`)

Use these as the actual source of truth. If the user asks for something not covered by any example file (a new component shape, a different accent color), extend it by staying consistent with what you just fetched rather than inventing a new visual language — same neutral palette, same lack of rounding, same shadow approach, just applied to the new element.

## Output rules

- Write clean Luau: no comments in the generated code. Skip the `-- StarterGui.X.Y` path comments and any other inline comments the source examples have — those are there for the repo's own bookkeeping, not something to reproduce in output.
- No extra whitespace padding, no placeholder/example values left in — every property should be a real, intentional value.
- Match the instance-building style from the examples (`Instance.new("X", parent)` then set properties) but keep variable names short and only as long as needed — don't over-engineer with unnecessary abstraction layers unless the user's ask genuinely calls for reusable functions.
- Don't default to typical AI-UI patterns: no `UIGradient`, no bright/neon accent colors, no rounded pill buttons, no emoji as icons — unless the user explicitly asks for one of these.

## Workflow

1. Fetch the relevant example file(s) from the repo (raw URLs above, or browse if the structure moved).
2. Identify which existing component is closest to what's being asked for.
3. Write new Luau based on that component's actual values and structure, adapted to the request.
4. Keep the output free of comments and repo-bookkeeping artifacts.
5. If nothing in the repo covers the request, stay consistent with the tokens you just pulled (colors, no rounding, shadow style, font) instead of falling back to generic defaults.
