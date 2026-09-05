---
name: ui-roblox-skill
description: Generates clean, flat, dark Roblox UI in Luau without UICorner, gradients, or neon styling.
---

# UI Roblox Skill

Правила генерации интерфейсов для Roblox Studio на Luau (`Instance.new`).

Цель: строгий минималистичный флэт-дизайн вместо типичных ошибок нейросетей (никаких огромных скруглений, градиентов и ядовитых цветов).

## Основные правила

1. **Без скруглений:** не добавлять `UICorner`. Все элементы имеют строгие прямоугольные углы.
2. **Без рамок:** всегда указывать `BorderSizePixel = 0` на всех инстансах (`Frame`, `TextButton`, `TextLabel`).
3. **Без градиентов:** не использовать `UIGradient`.
4. **Тени:** для глубины использовать `Instance.new("UIShadow", parent)`. Не делать псевдо-тени через полупрозрачные фреймы.
5. **Цвета:**
   - Основной фон панелей и кнопок: `Color3.fromRGB(44, 44, 44)`
   - Темный фон / подложка: `Color3.fromRGB(30, 30, 30)`
   - Основной текст: `Color3.fromRGB(228, 228, 228)`
   - Вторичный текст: `Color3.fromRGB(160, 160, 160)`
   - Заливка баров: `Color3.fromRGB(70, 70, 70)` или нейтральный акцент
6. **Шрифт:**
   - Основной: `Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)`
   - Для мелкого текста: `Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)`

## Паттерн кнопки (Hitbox)

Кнопка никогда не делается одиночным `TextButton`. Она всегда состоит из трех частей:
1. `Frame` — видимый корпус кнопки (размер, позиция, цвет `44, 44, 44`, нулевая рамка).
2. `TextLabel` — дочерний элемент фрейма с текстом.
3. `TextButton` с именем `hitbox` — дочерний элемент фрейма, перекрывающий его целиком (`Size = UDim2.new(1, 0, 1, 0)`), с `BackgroundTransparency = 1` и `TextTransparency = 1`. Логика клика вешается на `hitbox.MouseButton1Click`.

### Шаблон кнопки:
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

### Шаблон бара (Health/XP/Progress):
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

## Требования к коду
- Выдавать чистый рабочий Luau без лишней воды и без бесполезных комментариев к каждой строчке.
- Не выдумывать скруглений, если пользователь прямо об этом не попросил.
