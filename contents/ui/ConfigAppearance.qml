import QtQuick 2.0
import QtQuick.Controls 2.0
import org.kde.kirigami 2.3 as Kirigami

Kirigami.FormLayout {
    property alias cfg_bgOpacity: bgOpacitySlider.value
    property alias cfg_fontSize: fontSizeSpin.value
    property alias cfg_bgColor: bgColorField.text
    property alias cfg_textColor: textColorField.text
    property alias cfg_fontFamily: fontFamilyField.text

    // ── Preset color schemes ──
    Item {
        Kirigami.FormData.label: i18n("Color presets:")
        implicitHeight: presetsColumn.implicitHeight
        Column {
            id: presetsColumn
            spacing: 8
            Grid {
                columns: 5
                spacing: 4
                Repeater {
                    model: [
                        { label: i18n("Light"), bg: "#ffffff", txt: "" },
                        { label: i18n("Dark"), bg: "#2d2d2d", txt: "#f0f0f0" },
                        { label: i18n("Sepia"), bg: "#f5f0e8", txt: "#5c4b3c" },
                        { label: i18n("Solarized Light"), bg: "#fdf6e3", txt: "#657b83" },
                        { label: i18n("Solarized Dark"), bg: "#002b36", txt: "#839496" },
                        { label: i18n("Nord"), bg: "#3b4252", txt: "#e5e9f0" },
                        { label: i18n("Gruvbox Light"), bg: "#fbf1c7", txt: "#3c3836" },
                        { label: i18n("Gruvbox Dark"), bg: "#282828", txt: "#ebdbb2" },
                        { label: i18n("Dracula"), bg: "#282a36", txt: "#f8f8f2" },
                        { label: i18n("Monokai"), bg: "#272822", txt: "#f8f8f2" },
                        { label: i18n("One Dark"), bg: "#282c34", txt: "#abb2bf" },
                        { label: i18n("Catppuccin Latte"), bg: "#eff1f5", txt: "#4c4f69" },
                        { label: i18n("Catppuccin Mocha"), bg: "#1e1e2e", txt: "#cdd6f4" },
                        { label: i18n("Everforest Light"), bg: "#fdf6e3", txt: "#5c6a72" },
                        { label: i18n("Everforest Dark"), bg: "#2b3339", txt: "#d3c6aa" }
                    ]
                    Rectangle {
                        width: 28
                        height: 28
                        radius: 4
                        color: modelData.bg
                        border.width: 1
                        border.color: "#888888"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                bgColorField.text = modelData.bg
                                textColorField.text = modelData.txt
                            }
                        }
                    }
                }
            }
            // Live preview chip
            Rectangle {
                width: 160
                height: 36
                radius: 4
                color: {
                    var c = parseColor(bgColorField.text, 1, 1, 1)
                    return Qt.rgba(c.r, c.g, c.b, bgOpacitySlider.value)
                }
                border.width: 1
                border.color: "#cccccc"
                Text {
                    anchors.centerIn: parent
                    text: i18n("Sample Text")
                    color: textColorField.text !== "" ? textColorField.text : "#333333"
                    font.pointSize: fontSizeSpin.value
                    font.family: fontFamilyField.text !== "" ? fontFamilyField.text : parent.font.family
                }
            }
        }
    }

    Slider {
        id: bgOpacitySlider
        from: 0.0
        to: 1.0
        stepSize: 0.05
        Kirigami.FormData.label: i18n("Background opacity:") + " " + Math.round(bgOpacitySlider.value * 100) + "%"
    }

    TextField {
        id: bgColorField
        Kirigami.FormData.label: i18n("Background color (hex):")
        placeholderText: "#ffffff"
    }

    TextField {
        id: textColorField
        Kirigami.FormData.label: i18n("Text color (empty=system):")
        placeholderText: ""
    }

    SpinBox {
        id: fontSizeSpin
        from: 10
        to: 20
        Kirigami.FormData.label: i18n("Font size:")
    }

    TextField {
        id: fontFamilyField
        Kirigami.FormData.label: i18n("Font family (empty=system):")
        placeholderText: i18n("System default")
    }

    function parseColor(hex, fallbackR, fallbackG, fallbackB) {
        var s = (hex || "").trim()
        if (/^#[0-9A-Fa-f]{6}$/.test(s)) {
            return {
                r: parseInt(s.substr(1, 2), 16) / 255,
                g: parseInt(s.substr(3, 2), 16) / 255,
                b: parseInt(s.substr(5, 2), 16) / 255
            }
        }
        return { r: fallbackR, g: fallbackG, b: fallbackB }
    }
}
