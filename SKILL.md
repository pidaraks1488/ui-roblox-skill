---
name: ui-roblox-skill
description: Use whenever generating Roblox UI (ScreenGui, Frame, TextButton, TextLabel, bars, panels, HUDs, menus) with Luau / Instance.new code. Enforces a clean, flat, dark design system: sharp corners (no UICorner), zero border, dark neutral palette (#2C2C2C), GothamSSm typography, UIShadow depth, and decoupled Hitbox buttons.
---

# UI Roblox Skill (Flat Design System)

This skill enforces a consistent, modern flat design system for Roblox Studio UI code. It completely eliminates generic AI-generated UI mistakes (unwanted UICorner rounding, glowing neon accents, random UIGradients, and fragile button architectures).

Reference repository: https://github.com/pidaraks1488/ui-roblox-skill

---

## 📐 Core Design Rules & Tokens

Every generated Luau UI component must strictly adhere to these design principles:

### 1. Geometry & Borders
- **Sharp Rectangles Only:** Do NOT add `UICorner`. Sharp, crisp edges are mandatory.
- **Zero Borders:** Always set `BorderSizePixel = 0` on every GUI element (`Frame`, `TextButton`, `TextLabel`, `ImageLabel`).
- **Clean Depth:** Use `Instance.new("UIShadow", parent)` instead of blurry stacked frames or glowing outlines.

### 2. Color Palette Tokens
- **Surface / Background:** `Color3.fromRGB(44, 44, 44)` (Hex `#2C2C2C`)
- **Dark Surface / Wells:** `Color3.fromRGB(30, 30, 30)` (Hex `#1E1E1E`)
- **Primary Text:** `Color3.fromRGB(228, 228, 228)` (Hex `#E4E4E4`)
- **Secondary / Muted Text:** `Color3.fromRGB(160, 160, 160)` (Hex `#A0A0A0`)
- **Bar Fill Accent:** `Color3.fromRGB(70, 70, 70)` or contextual muted tones
- **Pure Black (Accents/Borders):** `Color3.fromRGB(0, 0, 0)`

### 3. Typography
- **Primary Font:** `Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)`
- **Fallback / Body Font:** `Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)`
- **Text Styling:** Keep `BackgroundTransparency = 1`. Use `TextScaled = true` or explicit `TextSize` with proper padding.

### 4. Hitbox Pattern for Buttons (Mandatory)
Never rely on a single `TextButton` for both styling and clicking. Always decouple:
1. **Container:** `Frame` (visual background, color, size, position, and optional `UIShadow`).
2. **Text:** `TextLabel` inside the Frame for the button caption.
3. **Hitbox:** Transparent `TextButton` named `hitbox` (`BackgroundTransparency = 1`, `TextTransparency = 1`, `Size = UDim2.new(1, 0, 1, 0)`) placed on top to capture all input events (`MouseButton1Click`, `TouchTap`, etc.).

---

## 🛠️ Built-in Reference Templates

### 1. Button Template (`ui/basic/button.lua`)
```lua
local function createButton(parent, text, size, position)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "Button"
    buttonFrame.Size = size or UDim2.new(0, 150, 0, 50)
    buttonFrame.Position = position or UDim2.new(0, 0, 0, 0)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = parent

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "TextLabel"
    textLabel.Size = UDim2.new(1, -20, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.BorderSizePixel = 0
    textLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    textLabel.TextColor3 = Color3.fromRGB(228, 228, 228)
    textLabel.TextScaled = true
    textLabel.Text = text or "BUTTON"
    textLabel.Parent = buttonFrame

    local hitbox = Instance.new("TextButton")
    hitbox.Name = "hitbox"
    hitbox.Size = UDim2.new(1, 0, 1, 0)
    hitbox.Position = UDim2.new(0, 0, 0, 0)
    hitbox.BackgroundTransparency = 1
    hitbox.TextTransparency = 1
    hitbox.BorderSizePixel = 0
    hitbox.Parent = buttonFrame

    return buttonFrame, hitbox
end
```

### 2. Button with Shadow (`ui/basic/button-shadow.lua`)
```lua
local function createButtonWithShadow(parent, text, size, position)
    local buttonFrame, hitbox = createButton(parent, text, size, position)
    
    local shadow = Instance.new("UIShadow")
    shadow.Name = "Shadow"
    shadow.Parent = buttonFrame

    return buttonFrame, hitbox
end
```

### 3. Container Frame / Modal (`ui/basic/frame.lua`)
```lua
local function createFrame(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Name = "Container"
    frame.Size = size or UDim2.new(0, 400, 0, 300)
    frame.Position = position or UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    return frame
end
```

### 4. Progress / Status Bar (`ui/basic/bar.lua`)
```lua
local function createProgressBar(parent, size, position)
    local barBackground = Instance.new("Frame")
    barBackground.Name = "ProgressBarBackground"
    barBackground.Size = size or UDim2.new(0, 250, 0, 20)
    barBackground.Position = position or UDim2.new(0, 0, 0, 0)
    barBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    barBackground.BorderSizePixel = 0
    barBackground.Parent = parent

    local barFill = Instance.new("Frame")
    barFill.Name = "Fill"
    barFill.Size = UDim2.new(1, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBackground

    return barBackground, barFill
end
```

---

## ⚡ Output Requirements for LLM

When asked to generate any Roblox UI code:
1. **Never use `UICorner`** unless the user explicitly commands: *"добавь скругление"* / *"round corners"*.
2. **Never use `UIGradient`** or neon rainbow schemes unless explicitly commanded.
3. **Always use the Hitbox pattern** for buttons.
4. **Produce clean, runnable Luau code.** Set explicit properties, omit boilerplate/noisy comments.
5. If fetching raw remote files is supported, additional source files can be inspected at:
   - `https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/button.lua`
   - `https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/button-shadow.lua`
   - `https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/frame.lua`
   - `https://raw.githubusercontent.com/pidaraks1488/ui-roblox-skill/main/ui/basic/bar.lua`
