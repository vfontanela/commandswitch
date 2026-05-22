import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page

    property alias cfg_label: labelField.text
    property alias cfg_useSlider: useSliderCheck.checked
    property alias cfg_onText: onTextField.text
    property alias cfg_offText: offTextField.text
    property alias cfg_onCommand: onCommandField.text
    property alias cfg_offCommand: offCommandField.text
    property alias cfg_onNotificationTitle: onNotificationTitleField.text
    property alias cfg_onNotificationMessage: onNotificationMessageField.text
    property alias cfg_offNotificationTitle: offNotificationTitleField.text
    property alias cfg_offNotificationMessage: offNotificationMessageField.text
    property alias cfg_onIcon: onIconField.text
    property alias cfg_offIcon: offIconField.text

    QQC2.TextField {
        id: labelField
        Kirigami.FormData.label: i18n("Label:")
        placeholderText: i18n("Command Switch")
    }

    QQC2.CheckBox {
        id: useSliderCheck
        Kirigami.FormData.label: i18n("Appearance:")
        text: i18n("Use sliding toggle")
    }

    QQC2.TextField {
        id: onTextField
        Kirigami.FormData.label: i18n("ON text:")
        placeholderText: i18n("ON")
    }

    QQC2.TextField {
        id: offTextField
        Kirigami.FormData.label: i18n("OFF text:")
        placeholderText: i18n("OFF")
    }

    QQC2.TextField {
        id: onIconField
        Kirigami.FormData.label: i18n("ON icon:")
        placeholderText: i18n("emblem-checked")
    }

    QQC2.TextField {
        id: offIconField
        Kirigami.FormData.label: i18n("OFF icon:")
        placeholderText: i18n("emblem-unchecked")
    }

    QQC2.TextArea {
        id: onCommandField
        Kirigami.FormData.label: i18n("ON command:")
        Layout.fillWidth: true
        placeholderText: i18n("/path/to/on-script")
        wrapMode: TextEdit.Wrap
    }

    QQC2.TextArea {
        id: offCommandField
        Kirigami.FormData.label: i18n("OFF command:")
        Layout.fillWidth: true
        placeholderText: i18n("/path/to/off-script")
        wrapMode: TextEdit.Wrap
    }

    QQC2.TextField {
        id: onNotificationTitleField
        Kirigami.FormData.label: i18n("ON notification title:")
        placeholderText: i18n("Command Switch")
    }

    QQC2.TextField {
        id: onNotificationMessageField
        Kirigami.FormData.label: i18n("ON notification message:")
        placeholderText: i18n("Switched on")
    }

    QQC2.TextField {
        id: offNotificationTitleField
        Kirigami.FormData.label: i18n("OFF notification title:")
        placeholderText: i18n("Command Switch")
    }

    QQC2.TextField {
        id: offNotificationMessageField
        Kirigami.FormData.label: i18n("OFF notification message:")
        placeholderText: i18n("Switched off")
    }
}
