import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

Item {
    id: full

    property var feedModel: null
    property int status: 0
    property string errorMsg: ""
    property int itemLimit: 20
    property int textSize: 13
    property real cardOpacity: 0.85
    property string widgetTitle: "RSS Reader"
    property int displayMode: 0
    property int contentItemsCount: 3
    property string bgColor: "#ffffff"
    property string textColor: ""
    property string fontFamily: ""

    signal doRefresh()

    function parseColor(hex, fallbackR, fallbackG, fallbackB) {
        var s = (hex || "").trim();
        if (/^#[0-9A-Fa-f]{6}$/.test(s)) {
            return {
                r: parseInt(s.substr(1, 2), 16) / 255,
                g: parseInt(s.substr(3, 2), 16) / 255,
                b: parseInt(s.substr(5, 2), 16) / 255
            };
        }
        return { r: fallbackR, g: fallbackG, b: fallbackB };
    }

    Layout.preferredWidth: PlasmaCore.Units.gridUnit * 22
    Layout.preferredHeight: PlasmaCore.Units.gridUnit * 16
    implicitWidth: PlasmaCore.Units.gridUnit * 22
    implicitHeight: PlasmaCore.Units.gridUnit * 16

    // White semi-transparent card
    Rectangle {
        id: card
        anchors.fill: parent
        anchors.margins: PlasmaCore.Units.smallSpacing
        color: {
            var c = parseColor(bgColor, 1, 1, 1);
            return Qt.rgba(c.r, c.g, c.b, cardOpacity);
        }
        radius: PlasmaCore.Units.smallSpacing * 2

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: PlasmaCore.Units.smallSpacing
            spacing: 0

            // Header row
            RowLayout {
                Layout.fillWidth: true
                spacing: PlasmaCore.Units.smallSpacing

                PlasmaCore.IconItem {
                    source: "rss"
                    Layout.preferredWidth: PlasmaCore.Units.iconSizes.smallMedium
                    Layout.preferredHeight: PlasmaCore.Units.iconSizes.smallMedium
                }

                PlasmaComponents3.Label {
                    text: widgetTitle
                    font.pointSize: textSize + 2
                    font.bold: true
                    font.family: fontFamily !== "" ? fontFamily : PlasmaCore.Theme.defaultFont.family
                    Layout.fillWidth: true
                    color: textColor !== "" ? textColor : PlasmaCore.Theme.textColor
                }

                PlasmaComponents3.ToolButton {
                    id: refreshBtn
                    icon.name: "view-refresh"
                    Layout.preferredWidth: PlasmaCore.Units.iconSizes.smallMedium
                    Layout.preferredHeight: PlasmaCore.Units.iconSizes.smallMedium
                    onClicked: full.doRefresh()
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: Qt.rgba(0, 0, 0, 0.1)
            }

            // Body area
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                // Unconfigured state
                PlasmaComponents3.Label {
                    anchors.centerIn: parent
                    visible: full.status === 0
                    text: i18n("Configure an RSS feed URL\nin widget settings")
                    font.pointSize: textSize
                    font.family: fontFamily !== "" ? fontFamily : PlasmaCore.Theme.defaultFont.family
                    horizontalAlignment: Text.AlignHCenter
                    color: textColor !== "" ? textColor : PlasmaCore.Theme.disabledTextColor
                    wrapMode: Text.WordWrap
                    width: parent.width - PlasmaCore.Units.gridUnit * 2
                }

                // Loading state
                BusyIndicator {
                    anchors.centerIn: parent
                    visible: full.status === 1
                    running: true
                }

                // Error state
                Column {
                    anchors.centerIn: parent
                    visible: full.status === 3
                    spacing: PlasmaCore.Units.smallSpacing
                    width: parent.width - PlasmaCore.Units.gridUnit * 2

                    PlasmaCore.IconItem {
                        source: "dialog-error"
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: PlasmaCore.Units.iconSizes.medium
                        height: PlasmaCore.Units.iconSizes.medium
                    }

                    PlasmaComponents3.Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: full.errorMsg || i18n("Failed to load feed")
                        font.pointSize: textSize
                        font.bold: true
                        font.family: fontFamily !== "" ? fontFamily : PlasmaCore.Theme.defaultFont.family
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        width: parent.width
                        color: textColor !== "" ? textColor : PlasmaCore.Theme.textColor
                    }
                }

                // Article list
                ListView {
                    id: articleList
                    anchors.fill: parent
                    visible: full.status === 2 && model && model.count > 0
                    clip: true
                    model: full.feedModel
                    spacing: 0
                    boundsBehavior: Flickable.StopAtBounds

                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AsNeeded
                    }

                    delegate: ArticleDelegate {
                        width: articleList.width
                        displayMode: full.displayMode
                        contentItemsCount: full.contentItemsCount
                        modelIndex: index
                        textColor: full.textColor
                        fontFamily: full.fontFamily
                    }
                }
            }
        }
    }
}
