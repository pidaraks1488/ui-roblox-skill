# 🎮 ui-roblox-skill (Roblox Flat UI)

<div align="center">

[![Stars](https://img.shields.io/github/stars/pidaraks1488/ui-roblox-skill?style=for-the-badge&logo=github&color=FFD700)](https://github.com/pidaraks1488/ui-roblox-skill/stargazers)
[![Forks](https://img.shields.io/github/forks/pidaraks1488/ui-roblox-skill?style=for-the-badge&logo=github&color=58a6ff)](https://github.com/pidaraks1488/ui-roblox-skill/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Roblox](https://img.shields.io/badge/Roblox-Studio-red?style=for-the-badge&logo=roblox)](https://www.roblox.com)
[![Luau](https://img.shields.io/badge/Language-Luau-00A2FF?style=for-the-badge)](https://luau.org)

<br/>

<a href="https://github.com/pidaraks1488/ui-roblox-skill">
  <img src="https://img.shields.io/badge/⭐_Поставить_звезду_репозиторию-ui--roblox--skill-blue?style=for-the-badge" alt="Star repo button" />
</a>

<p><b>Скилл для AI-ассистентов (Claude, Antigravity, Cursor, ChatGPT), генерирующий чистый, строгий и практичный Flat UI для Roblox Studio без аляповатых градиентов и мыльных закруглений.</b></p>

</div>

---

## 💡 В чем проблема и как скилл её решает

Когда просишь нейросеть: *«напиши код кнопки для Роблокса»*, модель обычно выдумывает случайный аляповатый визуал:
- сует везде `UICorner` с огромным радиусом;
- лепит кислотные градиенты (`UIGradient`);
- мешает стили в одном и том же проекте;
- не заботится об удобстве архитектуры GUI.

**ui-roblox-skill** решает эту проблему раз и навсегда. Скилл заставляет AI использовать строгую минималистичную дизайн-систему:
- ⬛ **Строгие формы:** острые углы, `BorderSizePixel = 0`, никаких лишних скруглений.
- 🎨 **Сдержанная палитра:** глубокие темные тона (`Color3.fromRGB(44, 44, 44)`), выверенная контрастность текста (`Color3.fromRGB(228, 228, 228)`).
- 🌓 **Реалистичная глубина:** аккуратные тени через `UIShadow`, а не фейковые размытые фреймы.
- 🎯 **Архитектурный паттерн Hitbox:** отделение визуала от кликов (подробнее ниже).

---

## 🔘 Анатомия правильной кнопки (Hitbox Pattern)

Главная фишка этого дизайн-кода — создание кнопок через оверлей:

```
┌────────────────────────────────────────┐  ◄── Frame (Визуальный контейнер)
│                                        │       Цвет: Color3.fromRGB(44, 44, 44)
│         [ Кнопка / Action ]            │  ◄── TextLabel (Текст)
│                                        │       GothamSSm Bold, Color3.fromRGB(228, 228, 228)
├────────────────────────────────────────┤
│     ░░░░░ Hitbox (TextButton) ░░░░░    │  ◄── Невидимый TextButton поверх всего Frame
└────────────────────────────────────────┘       BackgroundTransparency = 1, TextTransparency = 1
```

### Почему так?
1. **Свобода кастомизации:** вы можете полностью перерисовать фон, добавить обводку, анимацию, тени или эффекты на `Frame`, не ломая логику кликов.
2. **Надежный клик:** невидимый `TextButton` с именем `hitbox` перекрывает всю площадь кнопки и перехватывает клики мыши, тапы на телефонах и консольные триггеры.
3. **Чистый код логики:** в скриптах вы подключаетесь к `button.hitbox.MouseButton1Click`, а верстка остается независимой.

---

## 💻 Готовый пример кнопки (Luau)

### 1. Стандартная Flat-кнопка (`button.lua`)
```lua
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "ButtonGui"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Визуальная основа кнопки (Frame)
local buttonFrame = Instance.new("Frame", screenGui)
buttonFrame.Name = "Button"
buttonFrame.Size = UDim2.new(0, 150, 0, 50)
buttonFrame.Position = UDim2.new(0.5, -75, 0.5, -25)
buttonFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
buttonFrame.BorderSizePixel = 0

-- Текст кнопки
local textLabel = Instance.new("TextLabel", buttonFrame)
textLabel.Name = "TextLabel"
textLabel.Size = UDim2.new(1, -20, 1, 0)
textLabel.Position = UDim2.new(0, 10, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.BorderSizePixel = 0
textLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
textLabel.TextColor3 = Color3.fromRGB(228, 228, 228)
textLabel.TextScaled = true
textLabel.Text = "НАЖМИ МЕНЯ"

-- Невидимый хитбокс для кликов
local hitbox = Instance.new("TextButton", buttonFrame)
hitbox.Name = "hitbox"
hitbox.Size = UDim2.new(1, 0, 1, 0)
hitbox.Position = UDim2.new(0, 0, 0, 0)
hitbox.BackgroundTransparency = 1
hitbox.TextTransparency = 1
hitbox.BorderSizePixel = 0

-- Обработка клика
hitbox.MouseButton1Click:Connect(function()
    print("Кнопка успешно нажата!")
end)
```

### 2. Кнопка с тенью (`button-shadow.lua`)
Добавляет экземпляр `UIShadow` под фрейм, создавая мягкую строгую глубину без размытия и грязи.

---

## 📂 Компоненты в репозитории (`ui/basic/`)

| Файл | Описание | Особенности |
|------|----------|-------------|
| [`button.lua`](ui/basic/button.lua) | Стандартная плоская кнопка | Frame + Label (Gotham) + Hitbox |
| [`button-shadow.lua`](ui/basic/button-shadow.lua) | Кнопка с глубиной | Frame + Label + Hitbox + UIShadow |
| [`frame.lua`](ui/basic/frame.lua) / [`frame2`](ui/basic/frame2) | Контейнеры и модальные панели | Строгие темные фоновые плашки |
| [`frame2-shadow`](ui/basic/frame2-shadow) | Панель с объемной тенью | Для меню, инвентарей и диалогов |
| [`bar.lua`](ui/basic/bar.lua) / [`bar-full.lua`](ui/basic/bar-full.lua) | Полосы прогресса (HP, XP, щиты) | Четкие прямоугольные бары со шкалой |
| [`cube.lua`](ui/basic/cube.lua) / [`cube-shadow.lua`](ui/basic/cube-shadow.lua) | Квадратные слоты | Для хотбаров, инвентарей, аватар-боксов |
| [`label.lua`](ui/basic/label.lua) / [`label-shadow.lua`](ui/basic/label-shadow.lua) | Заголовки и текст | GothamSSm, контрастная типографика |

---

## 🚀 Установка скилла

### Вариант 1. Claude Code
Клонируйте репозиторий или положите скилл в директорию скиллов:
```bash
git clone https://github.com/pidaraks1488/ui-roblox-skill.git ~/.claude/skills/ui-roblox-skill
```

### Вариант 2. Antigravity / Gemini CLI
Поместите папку скилла в глобальные скиллы:
```bash
git clone https://github.com/pidaraks1488/ui-roblox-skill.git ~/.gemini/config/skills/ui-roblox-skill
```

### Вариант 3. Ручной режим (любая LLM / ChatGPT / Cursor)
Просто откройте файл [`SKILL.md`](SKILL.md), скопируйте его содержимое в ваши Project Rules / Custom Instructions или просто отправьте в чат нейросети.

---

## 📄 Лицензия

Проект распространяется под свободной лицензией [MIT](LICENSE). Можно использовать в любых коммерческих и личных плейсах Roblox.
