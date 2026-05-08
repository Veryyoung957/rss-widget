# RSS Reader — KDE Plasma 桌面小部件

KDE Plasma 5 桌面 RSS 订阅阅读器。

[English](README.md)

## 功能

- **RSS/XML 订阅** — 输入 URL 即可获取实时文章
- **自定义标题** — 可重命名小部件标题（如"知乎热点"、"Hacker News"）
- **内容密度控制** — 仅标题 / 标题+内容 / 前 N 条有内容，三种模式可切换
- **外观调节** — 可配置背景色、字体色、背景透明度、字体大小
- **自动刷新** — 可配置刷新间隔（5 分钟到 24 小时）
- **浏览器打开** — 点击文章即可用默认浏览器打开
- **托盘图标** — 支持收纳到系统托盘，显示简洁 RSS 图标

## 安装

```bash
cd rss-widge
./install.sh
```

然后右键桌面 → **添加小部件** → 搜索 **"RSS Reader"**。

## 更新

```bash
cd rss-widge
./install.sh
```

## 卸载

```bash
plasmapkg2 -r org.kde.plasma.rssreader
```

## 调试

```bash
cd rss-widge
plasmawindowed org.kde.plasma.rssreader

# 查看日志
journalctl --user -f | grep -i rss
```

## 配置说明

右键小部件 → **设置**:

| 标签页 | 设置项 | 说明 |
|--------|--------|------|
| 常规 | RSS Feed URL | RSS/XML 订阅源地址 |
| 常规 | Widget title | 小部件标题（默认 "RSS Reader"） |
| 常规 | Content display | 内容显示模式：标题+内容 / 仅标题 / 前N条有内容 |
| 常规 | Items with content | 模式为"前N条"时，显示内容的条数 |
| 常规 | Refresh interval | 刷新间隔（分钟） |
| 常规 | Max articles | 最大文章数 |
| 外观 | Background opacity | 背景透明度（20%–100%） |
| 外观 | Background color | 背景色，十六进制（默认 `#ffffff`） |
| 外观 | Text color | 字体色，留空则跟随系统主题 |
| 外观 | Font size | 基础字体大小（磅） |

## 环境要求

- KDE Plasma 5（已在 5.27 测试）
- Qt 5.15+
- KDE Frameworks 5.115+

## 许可证

GPL-2.0+
