<div align="center">

# 🧩 Roblox Flat UI — Claude Skill

**Тёмный, плоский, без "нейрослопа".**
Скилл для Claude (и других LLM, поддерживающих skills/инструкции), который заставляет модель
генерировать Roblox UI в едином фирменном стиле — вместо случайных градиентов,
скруглённых кнопок и неоновых цветов, которые ИИ обычно выдумывает "из головы".

[![Star this repo](https://img.shields.io/github/stars/pidaraks1488/ui-roblox-skill?style=for-the-badge&logo=github&color=FFD21E&labelColor=1a1a1a)](https://github.com/pidaraks1488/ui-roblox-skill)
[![License](https://img.shields.io/badge/license-MIT-44444C?style=for-the-badge&labelColor=1a1a1a)](#лицензия)
[![Made for Claude](https://img.shields.io/badge/made%20for-Claude%20Skills-D97757?style=for-the-badge&labelColor=1a1a1a)](https://docs.claude.com)

<a href="https://github.com/pidaraks1488/ui-roblox-skill">
  <img src="https://img.shields.io/badge/⭐_Поставь_звезду_репозиторию-1a1a1a?style=for-the-badge" alt="Support — star the repo" />
</a>

</div>

---

## 📦 Что это

`roblox-flat-ui` — это **skill** (папка `SKILL.md` + референсы), который подключается к Claude
и другим ИИ с поддержкой skills. После подключения модель **перестаёт придумывать дизайн сама**
и вместо этого использует фиксированную дизайн-систему:

- плоские тёмные поверхности, **без скруглений** (`BorderSizePixel = 0`, без `UICorner`, если не попросили явно);
- глубина только через `UIShadow`, без самодельных "блюр"-теней;
- фиксированная палитра (тёмно-серые панели `rgb(49,49,49)`, кнопки `rgb(44,44,44)`, текст `rgb(228,228,228)`);
- шрифт `GothamSSm Bold`, без Comic Sans-эффектов;
- кнопки строятся из **двух слоёв**: визуальный `Frame` + невидимый `hitbox` (`TextButton` для кликов) — это паттерн из оригинального `ui-roblox-skill`;
- готовые компоненты: `frame`, `frame2`, `cube`, `button`, `button-shadow`, `label`, `label-shadow`, `bar`, `bar-full`.

Прямая цель — как в оригинальном репозитории [`ui-roblox-skill`](https://github.com/pidaraks1488/ui-roblox-skill):
дать ИИ конкретный, воспроизводимый образец Roblox-интерфейса, а не позволять ему "фантазировать".

## 📁 Структура

```
roblox-flat-ui/
├── SKILL.md                     # правила дизайн-системы + инструкции для модели
└── references/
    └── components.lua           # готовые Luau-шаблоны компонентов (G2L-паттерн)
```

## 🚀 Установка

### Claude.ai / Claude Desktop / Claude Code (skills)

1. Скачай папку `roblox-flat-ui/` целиком (содержит `SKILL.md` и `references/`).
2. Помести её в директорию скиллов:
   - **Claude Code**: `~/.claude/skills/roblox-flat-ui/` (или в каталог скиллов проекта, если используешь project-level skills).
   - **Claude.ai / Claude Cowork**: в настройках подключи папку как кастомный skill через раздел добавления скиллов (Settings → Capabilities → Skills → Add skill), указав путь к `roblox-flat-ui/`.
3. Убедись, что `SKILL.md` лежит прямо в корне папки скилла (не глубже), а `references/components.lua` — рядом, в подпапке `references/`.
4. Перезапусти чат/сессию, чтобы Claude просканировал новый скилл.

### Быстрая проверка

Напиши в чат что-то вроде:

> Сделай Roblox UI кнопку "Играть" с тенью

Если скилл подключён правильно, Claude сгенерирует Luau-скрипт в стиле `button-shadow.lua`
(тёмный флет, `UIShadow`, hitbox-кнопка) — а не случайную скруглённую кнопку с градиентом.

### Ручная установка (git)

```bash
git clone https://github.com/pidaraks1488/ui-roblox-skill.git
cp -r ui-roblox-skill/skill/roblox-flat-ui ~/.claude/skills/roblox-flat-ui
```

## 🎨 Дизайн-токены (кратко)

| Элемент              | Значение                                   |
|----------------------|---------------------------------------------|
| Фон панели           | `Color3.fromRGB(49, 49, 49)`               |
| Поверхность кнопки   | `Color3.fromRGB(44, 44, 44)`               |
| Трек прогресс-бара   | `Color3.fromRGB(68, 68, 68)`               |
| Заливка прогресс-бара| `Color3.fromRGB(203, 203, 203)`            |
| Основной текст       | `Color3.fromRGB(228, 228, 228)`            |
| Скругления           | нет (`BorderSizePixel = 0`, без `UICorner`)|
| Тень                 | `Instance.new("UIShadow", …)`              |
| Шрифт                | `GothamSSm`, `Bold`                        |

Полное описание правил — в [`SKILL.md`](./roblox-flat-ui/SKILL.md).

## ⭐ Поддержать проект

Если скилл оказался полезным — поставь звезду оригинальному репозиторию,
это лучший способ поддержать автора и дизайн-систему:

<div align="center">

[![⭐ Star on GitHub](https://img.shields.io/badge/⭐_Star_on_GitHub-1a1a1a?style=for-the-badge&logo=github)](https://github.com/pidaraks1488/ui-roblox-skill)

</div>

## Лицензия

MIT — используй, форкай, адаптируй под свой стиль.
