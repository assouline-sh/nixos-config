pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs.components
import qs.components.controls
import qs.services
import qs.config
import qs.utils

ColumnLayout {
    id: root

    required property PopoutState popouts

    width: 180
    spacing: Appearance.spacing.small

    RowLayout {
        Layout.fillWidth: true
        spacing: Appearance.spacing.small

        StyledText {
            Layout.fillWidth: true
            text: qsTr("Bluetooth")
            font.weight: 500
        }

        StyledSwitch {
            id: btToggle
            checked: Bluetooth.defaultAdapter?.enabled ?? false
            onToggled: {
                const adapter = Bluetooth.defaultAdapter;
                if (adapter)
                    adapter.enabled = checked;
            }
        }
    }

    Repeater {
        model: ScriptModel {
            values: [...Bluetooth.devices.values].filter(d => d.connected).slice(0, 3)
        }

        RowLayout {
            id: device

            required property BluetoothDevice modelData

            Layout.fillWidth: true
            spacing: Appearance.spacing.small

            MaterialIcon {
                text: Icons.getBluetoothIcon(device.modelData.icon)
                font.pointSize: Appearance.font.size.small
            }

            StyledText {
                Layout.fillWidth: true
                text: device.modelData.name
                elide: Text.ElideRight
                font.pointSize: Appearance.font.size.small
            }
        }
    }

    StyledText {
        visible: !Bluetooth.devices.values.some(d => d.connected)
        text: qsTr("No devices")
        font.pointSize: Appearance.font.size.small
        color: Colours.palette.m3onSurfaceVariant
    }
}
