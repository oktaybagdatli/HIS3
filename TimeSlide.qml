import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Windows
Rectangle {

    color: "#F5A623"
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
            id :  header
            font.pixelSize: 24; color: "white"
            Layout.alignment: Qt.AlignHCenter
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

        // show a button with the current date
        //Button {
        //    id: dateButton
        //    text: dueDate
        //    onClicked: calendarPopup.open()
        //}

        //Popup {
        //    id: calendarPopup
        //    modal: true
        //    focus: true
        //    onClosed: dateButton.forceActiveFocus()
        //    //TODO : find a way to implement calendar
        //    //contentItem : CalendarModel{
        //    //    selectedDate: model.dueDate ? new Date(model.dueDate) : new Date()
        //    //    onSelectedDateChanged: {
        //    //        model.setData(model.index,
        //    //                      selectedDate.toString(Qt.ISODate),
        //    //                      /* DueDateRole */)
        //    //        dateButton.text = selectedDate.toString(Qt.ISODate)
        //    //        calendarPopup.close()
        //    //    }
        //    //}
        //}
    }
}
