import QtQuick 2.0
import QtQuick.Layouts 1.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

Item {
    id: delegateRoot

    property int displayMode: 0
    property int contentItemsCount: 3
    property int modelIndex: 0
    property string textColor: ""
    property string fontFamily: ""

    width: ListView.view.width
    implicitHeight: contentLayout.implicitHeight + PlasmaCore.Units.smallSpacing * 2

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (model.link) {
                Qt.openUrlExternally(model.link);
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: mouseArea.containsMouse
            ? Qt.rgba(PlasmaCore.Theme.textColor.r, PlasmaCore.Theme.textColor.g, PlasmaCore.Theme.textColor.b, 0.1)
            : "transparent"
    }

    RowLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: PlasmaCore.Units.smallSpacing
        spacing: PlasmaCore.Units.smallSpacing

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: PlasmaCore.Units.smallSpacing * 0.25

            PlasmaComponents3.Label {
                Layout.fillWidth: true
                text: model.title || i18n("(No title)")
                font.pointSize: PlasmaCore.Theme.defaultFont.pointSize
                font.bold: true
                font.family: fontFamily !== "" ? fontFamily : PlasmaCore.Theme.defaultFont.family
                elide: Text.ElideRight
                maximumLineCount: 2
                wrapMode: Text.WordWrap
                color: textColor !== "" ? textColor : PlasmaCore.Theme.textColor
            }

            PlasmaComponents3.Label {
                Layout.fillWidth: true
                visible: {
                    if (text === "") return false;
                    if (displayMode === 1) return false;
                    if (displayMode === 2) return modelIndex < contentItemsCount;
                    return true;
                }
                text: {
                    var desc = model.description || "";
                    var txt = desc.replace(/<[^>]*>/g, '');
                    txt = txt.replace(/&amp;/g, '&').replace(/&lt;/g, '<')
                           .replace(/&gt;/g, '>').replace(/&quot;/g, '"')
                           .replace(/&#39;/g, "'").replace(/&nbsp;/g, ' ');
                    return txt.trim();
                }
                font.pointSize: PlasmaCore.Theme.smallestFont.pointSize
                font.family: fontFamily !== "" ? fontFamily : PlasmaCore.Theme.defaultFont.family
                color: textColor !== "" ? textColor : PlasmaCore.Theme.disabledTextColor
                elide: Text.ElideRight
                maximumLineCount: 2
                wrapMode: Text.WordWrap
            }

            PlasmaComponents3.Label {
                visible: {
                    if (text === "") return false;
                    if (displayMode === 1) return false;
                    if (displayMode === 2) return modelIndex < contentItemsCount;
                    return true;
                }
                text: {
                    var d = model.pubDate || "";
                    if (d === "") return "";
                    try {
                        var date = new Date(d);
                        if (!isNaN(date.getTime())) {
                            return date.toLocaleString(Qt.locale(), Locale.ShortFormat);
                        }
                    } catch(e) {}
                    return d;
                }
                font.pointSize: PlasmaCore.Theme.smallestFont.pointSize
                font.family: fontFamily !== "" ? fontFamily : PlasmaCore.Theme.defaultFont.family
                color: textColor !== "" ? textColor : PlasmaCore.Theme.disabledTextColor
            }
        }
    }
}
