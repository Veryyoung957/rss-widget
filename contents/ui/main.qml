import QtQuick 2.0
import QtQuick.XmlListModel 2.0

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    Plasmoid.switchWidth: PlasmaCore.Units.gridUnit * 14
    Plasmoid.switchHeight: PlasmaCore.Units.gridUnit * 7

    // Desktop containment reads the root Item's implicit size
    implicitWidth: PlasmaCore.Units.gridUnit * 22
    implicitHeight: PlasmaCore.Units.gridUnit * 16

    readonly property string feedUrl: plasmoid.configuration ? (plasmoid.configuration.feedUrl || "") : ""
    readonly property int refreshInterval: plasmoid.configuration ? plasmoid.configuration.refreshInterval : 30
    readonly property int maxItems: plasmoid.configuration ? plasmoid.configuration.maxItems : 20
    readonly property string widgetTitle: plasmoid.configuration ? (plasmoid.configuration.widgetTitle || "RSS Reader") : "RSS Reader"
    readonly property int displayMode: plasmoid.configuration ? plasmoid.configuration.displayMode : 0
    readonly property int contentItemsCount: plasmoid.configuration ? plasmoid.configuration.contentItemsCount : 3
    readonly property string bgColor: plasmoid.configuration ? (plasmoid.configuration.bgColor || "#ffffff") : "#ffffff"
    readonly property string textColor: plasmoid.configuration ? (plasmoid.configuration.textColor || "") : ""

    property int feedStatus: 0 // 0=unconfigured, 1=loading, 2=loaded, 3=error
    property string errorText: ""

    function refresh() {
        if (feedUrl !== "") {
            rssModel.reload();
        }
    }

    XmlListModel {
        id: rssModel
        source: feedUrl !== "" ? feedUrl : ""
        query: "/rss/channel/item"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "description"; query: "description/string()" }
        XmlRole { name: "pubDate"; query: "pubDate/string()" }

        onStatusChanged: {
            if (feedUrl === "") {
                root.feedStatus = 0;
            } else if (status === XmlListModel.Loading) {
                root.feedStatus = 1;
            } else if (status === XmlListModel.Ready) {
                root.feedStatus = 2;
                root.errorText = "";
            } else if (status === XmlListModel.Error) {
                root.feedStatus = 3;
                root.errorText = errorString();
            }
        }
    }

    Timer {
        id: refreshTimer
        interval: refreshInterval * 60 * 1000
        repeat: true
        running: feedUrl !== ""
        onTriggered: root.refresh()
    }

    Plasmoid.compactRepresentation: CompactRepresentation {
        feedStatus: root.feedStatus
    }
    Plasmoid.fullRepresentation: FullRepresentation {
        feedModel: rssModel
        status: root.feedStatus
        errorMsg: root.errorText
        itemLimit: root.maxItems
        textSize: plasmoid.configuration ? plasmoid.configuration.fontSize : 13
        cardOpacity: plasmoid.configuration ? plasmoid.configuration.bgOpacity : 0.85
        widgetTitle: root.widgetTitle
        displayMode: root.displayMode
        contentItemsCount: root.contentItemsCount
        bgColor: root.bgColor
        textColor: root.textColor
        onDoRefresh: root.refresh()
    }
}
