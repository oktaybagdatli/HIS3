import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#50E3C2"
    radius: 8
    anchors.fill: parent

    property alias title : header.text
    property string notes
    property string dueDate

    signal notes_changed(string notes)
    signal due_date_changed(string dueDate)


    //TODO
    //Change it to the proper layout and items
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
                    notes_changed(text);
                }
            }
            TextInput{
                Layout.fillWidth: true
                text: dueDate
                onTextChanged: {
                    dueDate = text;
                    due_date_changed(text);
                    }
            }
        }


    //ListView {
    //    anchors.fill: parent; anchors.margins: 12
    //    model: ListModel {
    //        // demo data; in real use you might load from C++ too
    //        ListElement { url: "https://qt.io"; desc: "Qt Homepage" }
    //    }
    //    delegate: RowLayout {
    //        spacing: 6; Layout.alignment: Qt.AlignVCenter
    //        Text { text: desc; color: "white" }
    //        Button {
    //            text: "Open"
    //            onClicked: Qt.openUrlExternally(url)
    //        }
    //    }
    //}
}
