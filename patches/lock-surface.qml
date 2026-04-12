pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components
import qs.services
import qs.config

WlSessionLockSurface {
    id: root

    required property WlSessionLock lock
    required property Pam pam

    readonly property alias unlocking: unlockAnim.running

    color: "#000000"

    Connections {
        function onUnlock(): void {
            unlockAnim.start();
        }

        target: root.lock
    }

    SequentialAnimation {
        id: unlockAnim

        Anim {
            target: inputArea
            property: "opacity"
            to: 0
            duration: 200
        }
        PropertyAction {
            target: root.lock
            property: "locked"
            value: false
        }
    }

    Item {
        id: inputArea

        anchors.centerIn: parent
        width: 300
        height: inputRow.height

        focus: true
        Component.onCompleted: forceActiveFocus()
        onActiveFocusChanged: {
            if (!activeFocus)
                forceActiveFocus();
        }

        Keys.onPressed: event => {
            if (root.unlocking)
                return;
            root.pam.handleKey(event);
        }

        Row {
            id: inputRow

            anchors.centerIn: parent
            spacing: 4

            Repeater {
                model: root.pam.buffer.length

                delegate: Text {
                    text: "*"
                    color: "#ffffff"
                    font.family: "monospace"
                    font.pixelSize: 48
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                id: cursor

                width: 8
                height: 48
                color: "#44def5"
                y: 1

                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 1; duration: 1200 }
                    NumberAnimation { to: 0; duration: 1200 }
                }
            }
        }
    }
}
