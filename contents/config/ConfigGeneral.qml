import QtQuick 2.0
import QtQuick.Controls 2.5

import org.kde.kirigami 2.3 as Kirigami

Kirigami.FormLayout {
    property alias cfg_feedUrl: feedUrlField.text
    property alias cfg_refreshInterval: refreshIntervalSpin.value
    property alias cfg_maxItems: maxItemsSpin.value
    property alias cfg_widgetTitle: widgetTitleField.text
    property alias cfg_displayMode: displayModeCombo.currentIndex
    property alias cfg_contentItemsCount: contentItemsSpin.value

    TextField {
        id: feedUrlField
        Kirigami.FormData.label: i18n("RSS Feed URL:")
        placeholderText: "https://feeds.bbci.co.uk/news/rss.xml"
    }

    TextField {
        id: widgetTitleField
        Kirigami.FormData.label: i18n("Widget title:")
        placeholderText: i18n("RSS Reader")
    }

    ComboBox {
        id: displayModeCombo
        Kirigami.FormData.label: i18n("Content display:")
        model: [i18n("Title + Content"), i18n("Title Only"), i18n("First N items with content")]
    }

    SpinBox {
        id: contentItemsSpin
        from: 1
        to: 20
        enabled: displayModeCombo.currentIndex === 2
        Kirigami.FormData.label: i18n("Items with content:")
    }

    SpinBox {
        id: refreshIntervalSpin
        from: 5
        to: 1440
        Kirigami.FormData.label: i18n("Refresh interval (min):")
    }

    SpinBox {
        id: maxItemsSpin
        from: 5
        to: 100
        Kirigami.FormData.label: i18n("Max articles:")
    }
}
