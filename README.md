# RSS Reader — KDE Plasma Plasmoid

A clean, elegant RSS feed reader widget for KDE Plasma 5 desktop.

[中文说明](README_zh.md)

![](screenshot.png)

## Features

- **Subscribe to any RSS/XML feed** — enter a URL and get live articles
- **Customizable title** — rename the widget to match your feed (e.g. "Zhihu Hot", "Hacker News")
- **Content density control** — show title only, title + content, or content for the first N items
- **Appearance tuning** — adjustable background color, text color, background opacity, and font size
- **Auto-refresh** — configurable interval from 5 minutes to 24 hours
- **Open in browser** — click any article to open in your default web browser
- **Compact tray icon** — fits in the system tray with a subtle RSS icon

## Install

```bash
cd rss-widge
./install.sh
```

Then right-click the desktop → **Add Widget** → search **"RSS Reader"**.

## Update

```bash
cd rss-widge
./install.sh
```

## Remove

```bash
plasmapkg2 -r org.kde.plasma.rssreader
```

## Debug

```bash
cd rss-widge
plasmawindowed org.kde.plasma.rssreader

# Watch logs
journalctl --user -f | grep -i rss
```

## Configuration

Right-click the widget → **Settings**:

| Tab | Setting | Description |
|-----|---------|-------------|
| General | RSS Feed URL | The RSS/XML feed address |
| General | Widget title | Custom title displayed in the widget header |
| General | Content display | Title + Content, Title Only, or First N with content |
| General | Items with content | Number of items showing content (when "First N" mode) |
| General | Refresh interval | How often to fetch new articles (minutes) |
| General | Max articles | Maximum articles displayed |
| Appearance | Background opacity | Card transparency (20%–100%) |
| Appearance | Background color | Hex color for the card background (default: `#ffffff`) |
| Appearance | Text color | Hex color for text, empty = follow system theme |
| Appearance | Font size | Base font size in points |

## Requirements

- KDE Plasma 5 (tested on 5.27)
- Qt 5.15+
- KDE Frameworks 5.115+

## License

GPL-2.0+
