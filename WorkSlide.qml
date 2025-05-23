import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#4A90E2"
    radius: 8
    anchors.fill: parent


    property alias title : header.text
    property string notes
    property string dueDate

    signal notes_changed(string notes)
    signal due_date_changed(string dueDate)

    ColumnLayout {
        anchors.fill: parent; anchors.margins: 12; spacing: 8

        Text {
            id : header
            font.pixelSize: 24; color: "white"
        }
        TextArea {
            Layout.fillWidth: true; Layout.fillHeight: true
            placeholderText: "Your notes…"
            text: notes
            onTextChanged: {
                notes = text;
                notes_changed(text)
            }
        }
        TextInput{
            Layout.fillWidth: true
            text: dueDate
            onTextChanged: {
                dueDate = text; due_date_changed(text)
                }
        }
    }
}
