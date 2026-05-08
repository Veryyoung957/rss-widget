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
        visible: false
        from: 0
        to: 2
    }

    Item {
        Kirigami.FormData.label: i18n("Content display:")
        implicitHeight: radioColumn.implicitHeight
        Column {
            id: radioColumn
            spacing: 4
            RadioButton {
                text: i18n("Full - Show title, description and date for all articles")
                checked: displayModeSpin.value === 0
                onClicked: displayModeSpin.value = 0
            }
            RadioButton {
                text: i18n("Title Only - Show only article titles")
                checked: displayModeSpin.value === 1
                onClicked: displayModeSpin.value = 1
            }
            RadioButton {
                text: i18n("Mixed - Show title for all, full content for first N items")
                checked: displayModeSpin.value === 2
                onClicked: displayModeSpin.value = 2
            }
        }
    }

    SpinBox {
        id: contentItemsSpin
        from: 1
        to: 20
        Kirigami.FormData.label: i18n("Items with content (Mixed mode):")
    }

    SpinBox {
        id: refreshIntervalSpin
        from: 5
        to: 1440
        Kirigami.FormData.label: i18n("Refresh interval (minutes):")
    }

    SpinBox {
        id: maxItemsSpin
        from: 5
        to: 100
        Kirigami.FormData.label: i18n("Max articles:")
    }
}
