pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.UPower
import qs.components
import qs.services
import qs.config

Column {
    id: root

    spacing: Appearance.spacing.small
    width: 80

    StyledText {
        anchors.horizontalCenter: parent.horizontalCenter
        text: Math.round(UPower.displayDevice.percentage * 100) + "%"
        font.pointSize: Appearance.font.size.normal
        font.family: Appearance.font.family.mono
    }
}
