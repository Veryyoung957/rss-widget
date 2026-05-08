import QtQuick 2.0
import QtQuick.Layouts 1.0

import org.kde.plasma.core 2.0 as PlasmaCore

MouseArea {
    id: compactRoot
    onClicked: plasmoid.expanded = !plasmoid.expanded

    property int feedStatus: 0

    Layout.preferredWidth: PlasmaCore.Units.iconSizes.medium
    Layout.preferredHeight: PlasmaCore.Units.iconSizes.medium

    readonly property int minSize: Math.min(width, height)

    PlasmaCore.IconItem {
        anchors.centerIn: parent
        width: minSize
        height: minSize
        source: plasmoid.icon
        opacity: compactRoot.feedStatus === 2 ? 1.0 : 0.5

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }
}
