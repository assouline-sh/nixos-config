pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.components
import qs.services
import qs.config
import qs.utils

Column {
    id: root

    required property DrawerVisibilities visibilities

    padding: Appearance.padding.large
    spacing: Appearance.spacing.large

    SessionButton {
        id: hibernate

        icon: Config.session.icons.hibernate
        command: Config.session.commands.hibernate

        KeyNavigation.down: logout

        Component.onCompleted: forceActiveFocus()

        Connections {
            function onLauncherChanged(): void {
                if (!root.visibilities.launcher)
                    hibernate.forceActiveFocus();
            }

            target: root.visibilities
        }
    }

    SessionButton {
        id: logout

        icon: Config.session.icons.logout
        command: Config.session.commands.logout

        KeyNavigation.up: hibernate
        KeyNavigation.down: reboot
    }

    AnimatedImage {
        width: Config.session.sizes.button
        height: Config.session.sizes.button
        sourceSize.width: width
        sourceSize.height: height

        playing: visible
        asynchronous: true
        speed: Appearance.anim.sessionGifSpeed
        source: Paths.absolutePath(Config.paths.sessionGif)
    }

    SessionButton {
        id: reboot

        icon: Config.session.icons.reboot
        command: Config.session.commands.reboot

        KeyNavigation.up: logout
        KeyNavigation.down: shutdown
    }

    SessionButton {
        id: shutdown

        icon: Config.session.icons.shutdown
        command: Config.session.commands.shutdown

        KeyNavigation.up: reboot
    }

    component SessionButton: StyledRect {
        id: button

        required property string icon
        required property list<string> command

        implicitWidth: Config.session.sizes.button
        implicitHeight: Config.session.sizes.button

        radius: Appearance.rounding.large
        color: button.activeFocus ? Colours.palette.m3secondaryContainer : Colours.tPalette.m3surfaceContainer

        Keys.onEnterPressed: Quickshell.execDetached(button.command)
        Keys.onReturnPressed: Quickshell.execDetached(button.command)
        Keys.onEscapePressed: root.visibilities.session = false
        Keys.onPressed: event => {
            if (!Config.session.vimKeybinds)
                return;

            if (event.modifiers & Qt.ControlModifier) {
                if ((event.key === Qt.Key_J || event.key === Qt.Key_N) && KeyNavigation.down) {
                    KeyNavigation.down.focus = true;
                    event.accepted = true;
                } else if ((event.key === Qt.Key_K || event.key === Qt.Key_P) && KeyNavigation.up) {
                    KeyNavigation.up.focus = true;
                    event.accepted = true;
                }
            } else if (event.key === Qt.Key_Tab && KeyNavigation.down) {
                KeyNavigation.down.focus = true;
                event.accepted = true;
            } else if (event.key === Qt.Key_Backtab || (event.key === Qt.Key_Tab && (event.modifiers & Qt.ShiftModifier))) {
                if (KeyNavigation.up) {
                    KeyNavigation.up.focus = true;
                    event.accepted = true;
                }
            }
        }

        StateLayer {
            function onClicked(): void {
                Quickshell.execDetached(button.command);
            }

            radius: parent.radius
            color: button.activeFocus ? Colours.palette.m3onSecondaryContainer : Colours.palette.m3onSurface
        }

        MaterialIcon {
            anchors.centerIn: parent

            text: button.icon
            color: button.activeFocus ? Colours.palette.m3onSecondaryContainer : Colours.palette.m3onSurface
            font.pointSize: Appearance.font.size.extraLarge
            font.weight: 500
        }
    }
}
