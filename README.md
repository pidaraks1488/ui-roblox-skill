# roblox-flat-ui (Claude skill)

A skill that stops Claude (or any LLM with skill support) from making up its own Roblox UI style. Instead of guessing at rounded buttons and gradients, it pulls real examples straight from [ui-roblox-skill](https://github.com/pidaraks1488/ui-roblox-skill) and copies that look: flat, dark, sharp corners, no nonsense.

[⭐ Star the original repo](https://github.com/pidaraks1488/ui-roblox-skill)

## What it actually does

Normally, if you ask an LLM to "make a Roblox button," it'll invent something — usually rounded corners, some gradient, maybe a random accent color. It doesn't look like it belongs in the same game as the last thing it made you.

This skill tells the model to go fetch the actual `.lua` files from the repo before writing anything, and copy the patterns it finds there: colors, corner style, how shadows are done, the font, how buttons are structured. So instead of "here's a UI I made up," you get "here's a UI in your existing style."

The reference repo builds buttons in an interesting way worth knowing about: the visible part is a plain `Frame`, and on top of it sits an invisible `TextButton` called `hitbox` that actually catches the click. That way you can change how a button looks without touching the click logic at all.

## Installing it

**Claude Code:** drop the `roblox-flat-ui` folder into `~/.claude/skills/`.

```bash
git clone https://github.com/pidaraks1488/ui-roblox-skill.git
cp -r ui-roblox-skill/skill/roblox-flat-ui ~/.claude/skills/roblox-flat-ui
```

**Claude.ai / Cowork:** open Settings → Capabilities → Skills → Add skill, and point it at the `roblox-flat-ui` folder.

Either way, just make sure `SKILL.md` sits at the top level of the folder — that's all Claude needs to pick it up.

## Checking it worked

Ask something like "make me a Roblox button with a shadow." If the skill is active, Claude will go pull `button-shadow.lua` (or similar) from the repo first, then write something that actually matches it — dark flat button, sharp corners, `UIShadow` for depth, a separate hitbox. If it comes back with a rounded neon button, something's off with the install.

## Why it fetches from GitHub instead of baking in a copy

The repo can change — new components get added, existing ones get tweaked. Rather than freezing a snapshot in the skill and having it go stale, the skill just tells Claude to look at the repo directly each time. That also means if you fork the repo and change your own style, you can point the skill at your fork and it'll follow whatever you put there.

## License

MIT.
