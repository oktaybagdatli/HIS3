import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: "HIS3"
    property int rect


    ListModel{
        id : slideModel
        ListElement{
            title : "Work"
        }
        ListElement{
            title : "Resources"

        }
        ListElement{
            title : "Time"
        }

    }
    property int currentIndex : 0





    RowLayout {
        anchors.centerIn: parent
        spacing: 40

        // left arrow
        Canvas {
            id: leftHead
            width: 15;       height: 50
            Layout.alignment: Qt.AlignVCenter

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                var y = height/2

                // draw just the head (pointing left)
                ctx.beginPath()
                ctx.moveTo(0, y)
                ctx.lineTo(width, y - 10)
                ctx.lineTo(width, y + 10)
                ctx.closePath()
                ctx.fillStyle = "black"
                ctx.fill()
            }
            Component.onCompleted: requestPaint()
            onWidthChanged:  requestPaint()
            onHeightChanged: requestPaint()

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: mouse => {
                               currentIndex = (currentIndex - 1 + slideModel.count) % slideModel.count;
                               //TODO
                               //save the progress of the user in the form of a timetable
                }
            }
        }

        // Rectangle 1
        Rectangle {
            id: rect1
            Layout.preferredWidth: window.width * 0.3 ; Layout.preferredHeight: window.height * 0.5
            color: "skyblue"
            Layout.alignment: Qt.AlignVCenter
            Text {
                id : rect1txt
                            text: slideModel.get(currentIndex).title
                            //TODO
                            //update the other components to the slide models components
                            anchors.top: parent.top; anchors.left: parent.left
                            anchors.margins: 8
                            font.bold: true
                            color: "black"
                        }
        }

        // Rectangle 2
        Rectangle {
            id: rect2
            Layout.preferredWidth: window.width * 0.3;   Layout.preferredHeight: window.height* 0.5
            color: "lightgreen"
            Layout.alignment: Qt.AlignVCenter
            Text {
                id : rect2txt
                            text: slideModel.get((currentIndex + 1) % slideModel.count).title
                            //TODO
                            //update the other components to the slide models components
                            anchors.top: parent.top; anchors.left: parent.left
                            anchors.margins: 8
                            font.bold: true
                            color: "black"
                        }
        }

        // right arrow
        Canvas {
            id: rightHead
            width: 15;       height: 50
            Layout.alignment: Qt.AlignVCenter

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                var y = height/2


                ctx.beginPath()
                ctx.moveTo(width, y)
                ctx.lineTo(0, y - 10)
                ctx.lineTo(0, y + 10)
                ctx.closePath()
                ctx.fillStyle = "black"
                ctx.fill()
            }
            Component.onCompleted: requestPaint()
            onWidthChanged:  requestPaint()
            onHeightChanged: requestPaint()

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: mouse => {
                               currentIndex = (currentIndex + 1) % slideModel.count;
                }
            }
        }
    }
}
