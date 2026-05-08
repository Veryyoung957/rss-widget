import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.3 as Kirigami

Kirigami.FormLayout {
    property alias cfg_bgOpacity: bgOpacitySlider.value
    property alias cfg_fontSize: fontSizeSpin.value
    property alias cfg_bgColor: bgColorField.text
    property alias cfg_textColor: textColorField.text

    function previewColor(hexStr, fallback) {
        var s = hexStr.trim();
        if (/^#[0-9A-Fa-f]{6}$/.test(s)) return s;
        return fallback;
    }

    Slider {
        id: bgOpacitySlider
        from: 0.2
        to: 1.0
        stepSize: 0.05
        Kirigami.FormData.label: i18n("Background opacity: %1%", Math.round(bgOpacitySlider.value * 100))
    }

    RowLayout {
        Kirigami.FormData.label: i18n("Background color:")
        spacing: 4

        TextField {
            id: bgColorField
            Layout.fillWidth: true
            placeholderText: "#ffffff"
        }

        Rectangle {
            width: 24
            height: 24
            radius: 3
            color: previewColor(bgColorField.text, "#ffffff")
            border.color: Qt.rgba(0, 0, 0, 0.2)
        }
    }

    RowLayout {
        Kirigami.FormData.label: i18n("Text color:")
        spacing: 4

        TextField {
            id: textColorField
            Layout.fillWidth: true
            placeholderText: i18n("(system default)")
        }

        Rectangle {
            width: 24
            height: 24
            radius: 3
            color: textColorField.text.trim() !== "" ? previewColor(textColorField.text, "#000000") : PlasmaCore.Theme.textColor
            border.color: Qt.rgba(0, 0, 0, 0.2)
        }
    }

    SpinBox {
        id: fontSizeSpin
        from: 10
        to: 20
        Kirigami.FormData.label: i18n("Font size:")
    }
}
