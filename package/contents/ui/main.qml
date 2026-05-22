import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support

PlasmoidItem {
    id: root

    preferredRepresentation: compactRepresentation

    property bool isOn: plasmoid.configuration.checked

    function shellQuote(s) {
        return "'" + String(s).replace(/'/g, "'\\''") + "'"
    }

    function runCommand(command) {
        if (!command || command.trim().length === 0) {
            return
        }
        executable.exec("bash -lc " + shellQuote(command))
    }

    function sendNotification(title, message) {
        if (!message || message.trim().length === 0) {
            return
        }

        var safeTitle = title && title.trim().length > 0 ? title : plasmoid.configuration.label
        executable.exec("notify-send " + shellQuote(safeTitle) + " " + shellQuote(message))
    }

    function applyState(newState) {
        if (root.isOn === newState) {
            return
        }

        root.isOn = newState
        plasmoid.configuration.checked = newState

        if (newState) {
            runCommand(plasmoid.configuration.onCommand)
            sendNotification(plasmoid.configuration.onNotificationTitle, plasmoid.configuration.onNotificationMessage)
        } else {
            runCommand(plasmoid.configuration.offCommand)
            sendNotification(plasmoid.configuration.offNotificationTitle, plasmoid.configuration.offNotificationMessage)
        }
    }

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"

        function exec(cmd) {
            connectSource(cmd)
        }

        onNewData: function(sourceName, data) {
            disconnectSource(sourceName)
        }
    }

    compactRepresentation: Item {
        id: compactRoot

        implicitWidth: plasmoid.configuration.useSlider ? Kirigami.Units.gridUnit * 4.5 : Kirigami.Units.gridUnit * 5.4
        implicitHeight: Kirigami.Units.gridUnit * 2.2

        Loader {
            anchors.fill: parent
            sourceComponent: plasmoid.configuration.useSlider ? sliderComponent : boxComponent
        }

        Component {
            id: boxComponent

            MouseArea {
                id: boxMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.applyState(!root.isOn)

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.smallSpacing
                    spacing: Kirigami.Units.smallSpacing

                    Kirigami.Icon {
                        source: root.isOn ? plasmoid.configuration.onIcon : plasmoid.configuration.offIcon
                        implicitWidth: Kirigami.Units.iconSizes.smallMedium
                        implicitHeight: Kirigami.Units.iconSizes.smallMedium
                    }

                    QQC2.Label {
                        text: root.isOn ? plasmoid.configuration.onText : plasmoid.configuration.offText
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                    }
                }

                QQC2.ToolTip.visible: boxMouse.containsMouse
                QQC2.ToolTip.text: plasmoid.configuration.label + ": " + (root.isOn ? plasmoid.configuration.onText : plasmoid.configuration.offText)
            }
        }

        Component {
            id: sliderComponent

            MouseArea {
                id: sliderMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.applyState(!root.isOn)

                Rectangle {
                    id: track
                    anchors.centerIn: parent
                    width: Math.max(Kirigami.Units.gridUnit * 3.6, 58)
                    height: Math.max(Kirigami.Units.gridUnit * 1.45, 24)
                    radius: height / 2
                    color: root.isOn ? "#3daee9" : "#6b7280"
                    border.width: 1
                    border.color: Qt.rgba(1, 1, 1, 0.35)

                    Rectangle {
                        id: thumb
                        width: track.height - 6
                        height: track.height - 6
                        radius: width / 2
                        y: 3
                        x: root.isOn ? track.width - width - 3 : 3
                        color: "#eff0f1"
                        border.width: 1
                        border.color: Qt.rgba(0, 0, 0, 0.25)

                        Behavior on x {
                            NumberAnimation {
                                duration: 140
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    QQC2.Label {
                        anchors.verticalCenter: parent.verticalCenter
                        x: root.isOn ? 7 : thumb.x + thumb.width + 4
                        width: root.isOn ? thumb.x - 10 : parent.width - x - 6
                        text: root.isOn ? plasmoid.configuration.onText : plasmoid.configuration.offText
                        font.pixelSize: 9
                        font.bold: true
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                    }
                }

                QQC2.ToolTip.visible: sliderMouse.containsMouse
                QQC2.ToolTip.text: plasmoid.configuration.label + ": " + (root.isOn ? plasmoid.configuration.onText : plasmoid.configuration.offText)
            }
        }
    }

    fullRepresentation: Item {
        implicitWidth: Kirigami.Units.gridUnit * 13
        implicitHeight: Kirigami.Units.gridUnit * 8

        ColumnLayout {
            anchors.centerIn: parent
            spacing: Kirigami.Units.largeSpacing

            Kirigami.Icon {
                source: "command-switch"
                implicitWidth: Kirigami.Units.iconSizes.large
                implicitHeight: Kirigami.Units.iconSizes.large
                Layout.alignment: Qt.AlignHCenter
            }

            QQC2.Label {
                text: plasmoid.configuration.label
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }

            QQC2.Switch {
                checked: root.isOn
                text: root.isOn ? plasmoid.configuration.onText : plasmoid.configuration.offText
                Layout.alignment: Qt.AlignHCenter
                onToggled: root.applyState(checked)
            }
        }
    }
}
