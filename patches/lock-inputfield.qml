pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.services
import qs.config

Item {
    id: root

    required property Pam pam
    readonly property alias placeholder: placeholder
    property string buffer

    Layout.fillWidth: true
    Layout.fillHeight: true

    clip: true

    Connections {
        function onBufferChanged(): void {
            if (root.pam.buffer.length > root.buffer.length) {
                charList.bindImWidth();
            } else if (root.pam.buffer.length === 0) {
                charList.implicitWidth = charList.implicitWidth;
                placeholder.animate = true;
            }

            root.buffer = root.pam.buffer;
        }

        target: root.pam
    }

    StyledText {
        id: placeholder

        anchors.centerIn: parent

        text: {
            if (root.pam.passwd.active)
                return qsTr("Loading...");
            if (root.pam.state === "max")
                return qsTr("You have reached the maximum number of tries");
            return qsTr("Enter your password");
        }

        animate: true
        color: root.pam.passwd.active ? Colours.palette.m3secondary : Colours.palette.m3outline
        font.pointSize: Appearance.font.size.normal
        font.family: Appearance.font.family.mono

        opacity: root.buffer ? 0 : 1

        Behavior on opacity {
            Anim {}
        }
    }

    Row {
        id: charRow

        anchors.centerIn: parent
        spacing: Appearance.spacing.small / 2

        Repeater {
            model: root.buffer.length

            delegate: StyledRect {
                implicitWidth: Appearance.font.size.normal
                implicitHeight: Appearance.font.size.normal

                color: Colours.palette.m3onSurface
                radius: Appearance.rounding.small / 2
            }
        }

        Rectangle {
            id: cursor

            width: 2
            height: Appearance.font.size.normal
            color: "#44def5"

            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { to: 1; duration: 500 }
                NumberAnimation { to: 0; duration: 500 }
            }
        }
    }
}
