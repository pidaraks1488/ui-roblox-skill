# ui-roblox-skill

Скилл и база готовых компонентов для Roblox Studio (Luau).

Основная цель — отучить нейросети (Claude, ChatGPT, Cursor и др.) генерировать дефолтный мыльный UI со скруглениями (`UICorner`), радужными градиентами и кривой структурой. Вместо этого код пишется в едином строгом флэт-стиле: темная палитра, острые углы, аккуратные тени через `UIShadow` и разделение визуала с логикой.

[⭐ Star repo](https://github.com/pidaraks1488/ui-roblox-skill)

---

## Как тут устроена кнопка (Hitbox pattern)

В дефолтном коде от нейросетей обычно создается одиночный `TextButton`, на который накидывают цвет, текст и огромное скругление. Если потом нужно добавить тень, анимацию или поменять дизайн — все разваливается.

Здесь кнопки собираются нормально:
1. **Frame** — отвечает только за внешний вид (размер, позиция, цвет `Color3.fromRGB(44, 44, 44)`, нулевая рамка `BorderSizePixel = 0`).
2. **TextLabel** — текст внутри кнопки, шрифт GothamSSm Bold, цвет `Color3.fromRGB(228, 228, 228)`.
3. **hitbox (TextButton)** — невидимая кнопка поверх всего фрейма (`BackgroundTransparency = 1`, `TextTransparency = 1`), которая перехватывает клики.

За счет этого визуал полностью отвязан от скрипта клика: в коде всегда вешаемся на `hitbox.MouseButton1Click`, а сам Frame можно стилизовать как угодно.

### Пример обычной кнопки (`ui/basic/button.lua`)

```lua
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "CustomUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Корпус кнопки
local button = Instance.new("Frame", gui)
button.Name = "Button"
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
button.BorderSizePixel = 0

-- Текст
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

-- Хитбокс для кликов
local hitbox = Instance.new("TextButton", button)
hitbox.Name = "hitbox"
hitbox.Size = UDim2.new(1, 0, 1, 0)
hitbox.Position = UDim2.new(0, 0, 0, 0)
hitbox.BackgroundTransparency = 1
hitbox.TextTransparency = 1
hitbox.BorderSizePixel = 0

hitbox.MouseButton1Click:Connect(function()
    print("Click!")
end)
```

### Кнопка с тенью (`ui/basic/button-shadow.lua`)

Если нужна глубина, внутрь фрейма вешается `UIShadow`. Никаких костылей из полупрозрачных размытых рамок — нативная аккуратная тень.

---

## Что лежит в репозитории

Все базовые компоненты лежат в папке `ui/basic/`:

- `button.lua` — плоская кнопка с хитбоксом.
- `button-shadow.lua` — кнопка с тенью `UIShadow`.
- `frame.lua` и `frame2` — базовые панели и подложки.
- `frame2-shadow` — панель с тенью под окна, инвентарь или модалки.
- `bar.lua` и `bar-full.lua` — статус-бары (здоровье, стамина, опыт).
- `cube.lua` и `cube-shadow.lua` — квадратные слоты для инвентаря и панелей способностей.
- `label.lua` и `label-shadow.lua` — заголовки и текстовые блоки.

---

## Как использовать скилл

Файл скилла лежит прямо в корне — `SKILL.md` (и его копия в `skill/flatty.md`).

### Claude Code
```bash
git clone https://github.com/pidaraks1488/ui-roblox-skill.git ~/.claude/skills/ui-roblox-skill
```

### Antigravity / Gemini CLI
```bash
git clone https://github.com/pidaraks1488/ui-roblox-skill.git ~/.gemini/config/skills/ui-roblox-skill
```

### Cursor / ChatGPT / другие LLM
Скопируйте содержимое `SKILL.md` в правила проекта (`.cursorrules`) или системный промпт.
