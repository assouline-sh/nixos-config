import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services
import qs.config

RowLayout {
    id: root

    required property var lock

    spacing: Appearance.spacing.large * 2

    Item {
        Layout.fillWidth: true
    }

    Center {
        lock: root.lock
    }

    Item {
        Layout.fillWidth: true
    }
}
