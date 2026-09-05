# ui-roblox-skill

A Luau component reference and LLM skill for Roblox Studio.

Stops models (Claude, Cursor, ChatGPT) from generating generic AI-looking UI: oversized `UICorner` roundings, rainbow gradients, and messy button structures. Instead, it enforces a clean, flat, dark design system with sharp corners, native `UIShadow` depth, and decoupled click hitboxes.

[⭐ Star repo](https://github.com/pidaraks1488/ui-roblox-skill)

---

## The Button Pattern (Hitbox Overlay)

When you ask an AI for a Roblox button, it almost always creates a single `TextButton`, slaps colors and rounding on it, and calls it a day. The moment you want to animate it, restyle the container, or tweak shadows, everything breaks.

Buttons here decouple the visual container from the click handler:
1. **Frame** — Handles visuals only (size, position, dark background `Color3.fromRGB(44, 44, 44)`, sharp borders `BorderSizePixel = 0`).
2. **TextLabel** — Sits inside the Frame. Uses `GothamSSm` Bold, colored `Color3.fromRGB(228, 228, 228)`.
3. **hitbox (TextButton)** — An invisible overlay covering the entire Frame (`BackgroundTransparency = 1`, `TextTransparency = 1`). All click events (`MouseButton1Click`) attach here.

This leaves you free to restyle, animate, or swap the visual Frame without touching the interaction logic.

### Button Example (`ui/basic/button.lua`)

```lua
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "CustomUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Visual container
local button = Instance.new("Frame", gui)
button.Name = "Button"
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
button.BorderSizePixel = 0

-- Label
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

-- Click hitbox
local hitbox = Instance.new("TextButton", button)
hitbox.Name = "hitbox"
hitbox.Size = UDim2.new(1, 0, 1, 0)
hitbox.Position = UDim2.new(0, 0, 0, 0)
hitbox.BackgroundTransparency = 1
hitbox.TextTransparency = 1
hitbox.BorderSizePixel = 0

hitbox.MouseButton1Click:Connect(function()
    print("Clicked!")
end)
```

### Button with Shadow (`ui/basic/button-shadow.lua`)

For depth, drop a native `UIShadow` inside the Frame. No bloated multi-layer blur hacks.

---

## Included Components

Reference implementations live under `ui/basic/`:

- `button.lua` — Flat button with hitbox overlay.
- `button-shadow.lua` — Flat button with native `UIShadow`.
- `frame.lua` & `frame2` — Base panel containers and backdrops.
- `frame2-shadow` — Panel with shadow for dialogs, windows, and inventory menus.
- `bar.lua` & `bar-full.lua` — Progress bars (HP, stamina, experience).
- `cube.lua` & `cube-shadow.lua` — Square inventory slots and hotbar tiles.
- `label.lua` & `label-shadow.lua` — Typography and header blocks.

---

## Installation & Usage

The skill prompt is located in `SKILL.md` (mirrored in `skill/flatty.md`).

### Claude Code
```bash
git clone https://github.com/pidaraks1488/ui-roblox-skill.git ~/.claude/skills/ui-roblox-skill
```

### Antigravity / Gemini CLI
```bash
git clone https://github.com/pidaraks1488/ui-roblox-skill.git ~/.gemini/config/skills/ui-roblox-skill
```

### Cursor, ChatGPT, or Other LLMs
Copy the contents of `SKILL.md` into your `.cursorrules`, system instructions, or active chat.
