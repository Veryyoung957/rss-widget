import QtQuick 2.0
import QtQuick.Controls 2.0

import org.kde.kirigami 2.3 as Kirigami

Kirigami.FormLayout {
    property alias cfg_feedUrl: feedUrlField.text
    property alias cfg_refreshInterval: refreshIntervalSpin.value
    property alias cfg_maxItems: maxItemsSpin.value
    property alias cfg_widgetTitle: widgetTitleField.text
    property alias cfg_displayMode: displayModeSpin.value
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

    SpinBox {
        id: displayModeSpin
        from: 0
        to: 2
        Kirigami.FormData.label: i18n("Content display: 0=Title+Content 1=Title Only 2=First N")
    }

    SpinBox {
        id: contentItemsSpin
        from: 1
        to: 20
        enabled: displayModeSpin.value === 2
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
