---
name: ui-roblox-skill
description: Generates clean, flat, dark Roblox UI in Luau without UICorner, gradients, or neon styling.
---

# UI Roblox Skill

Guidelines for generating Luau UI code (`Instance.new`) for Roblox Studio.

The goal is to maintain a strict, minimal, flat dark design instead of typical AI errors (no massive corner roundings, no random gradients, no neon palettes).

## Rules

1. **No UICorner:** Do not add `UICorner`. All elements must have sharp 90-degree corners.
2. **Zero borders:** Set `BorderSizePixel = 0` on every UI instance (`Frame`, `TextButton`, `TextLabel`, etc.).
3. **No UIGradient:** Do not use `UIGradient`.
4. **Depth:** For drop shadows, use native `Instance.new("UIShadow", parent)`. Never create fake blurred background frames.
5. **Color Palette:**
   - Panel & button surface: `Color3.fromRGB(44, 44, 44)`
   - Dark well / background: `Color3.fromRGB(30, 30, 30)`
   - Primary text: `Color3.fromRGB(228, 228, 228)`
   - Muted text: `Color3.fromRGB(160, 160, 160)`
   - Bar fill: `Color3.fromRGB(70, 70, 70)` or neutral accent
6. **Fonts:**
   - Primary: `Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)`
   - Small / body text: `Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)`

## Button Pattern (Hitbox)

Never use a bare `TextButton` for styled buttons. A button always consists of three parts:
1. `Frame` — The visible button body (size, position, color `44, 44, 44`, `BorderSizePixel = 0`).
2. `TextLabel` — Child of the Frame for text content.
3. `TextButton` named `hitbox` — Child of the Frame covering it entirely (`Size = UDim2.new(1, 0, 1, 0)`), with `BackgroundTransparency = 1` and `TextTransparency = 1`. Click events bind to `hitbox.MouseButton1Click`.

### Button Recipe:
```lua
local button = Instance.new("Frame")
button.Name = "Button"
button.Size = UDim2.new(0, 150, 0, 50)
button.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
button.BorderSizePixel = 0

local label = Instance.new("TextLabel", button)
label.Name = "TextLabel"
label.Size = UDim2.new(1, -20, 1, 0)
label.Position = UDim2.new(0, 10, 0, 0)
label.BackgroundTransparency = 1
label.BorderSizePixel = 0
label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
label.TextColor3 = Color3.fromRGB(228, 228, 228)
label.TextScaled = true
label.Text = "BUTTON"

local hitbox = Instance.new("TextButton", button)
hitbox.Name = "hitbox"
hitbox.Size = UDim2.new(1, 0, 1, 0)
hitbox.BackgroundTransparency = 1
hitbox.TextTransparency = 1
hitbox.BorderSizePixel = 0
```

### Progress Bar Recipe:
```lua
local barBg = Instance.new("Frame")
barBg.Name = "BarBackground"
barBg.Size = UDim2.new(0, 200, 0, 20)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barBg.BorderSizePixel = 0

local barFill = Instance.new("Frame", barBg)
barFill.Name = "Fill"
barFill.Size = UDim2.new(1, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
barFill.BorderSizePixel = 0
```

## Output Expectations
- Return clean, executable Luau code without conversational filler or redundant line-by-line comments.
- Do not introduce rounded corners unless specifically asked by the user.
