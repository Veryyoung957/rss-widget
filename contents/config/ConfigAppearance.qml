import QtQuick 2.0
import QtQuick.Controls 2.0

import org.kde.kirigami 2.3 as Kirigami

Kirigami.FormLayout {
    property alias cfg_bgOpacity: bgOpacitySlider.value
    property alias cfg_fontSize: fontSizeSpin.value
    property alias cfg_bgColor: bgColorField.text
    property alias cfg_textColor: textColorField.text

    Slider {
        id: bgOpacitySlider
        from: 0.2
        to: 1.0
        stepSize: 0.05
        Kirigami.FormData.label: i18n("Background opacity: %1%", Math.round(bgOpacitySlider.value * 100))
    }

    TextField {
        id: bgColorField
        Kirigami.FormData.label: i18n("Background color:")
        placeholderText: "#ffffff"
    }

    TextField {
        id: textColorField
        Kirigami.FormData.label: i18n("Text color:")
        placeholderText: i18n("(system theme)")
    }

    SpinBox {
        id: fontSizeSpin
        from: 10
        to: 20
        Kirigami.FormData.label: i18n("Font size:")
    }
}
