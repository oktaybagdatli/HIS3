import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#50E3C2"
    radius: 8
    anchors.fill: parent

    property var listModel

        ListView {
            anchors.fill: parent
            clip: false
            model: listModel
            delegate: Item {
                width: parent.width; height: 40
                Text {
                    text: model.display
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                }

                // enable drag always
                MouseArea {
                    anchors.fill: parent
                    drag.target: parent
                    onPressAndHold: drag.startDrag()
                }
                Drag.active: parent.Drag.active
                Drag.hotSpot.x: width/2
                Drag.hotSpot.y: height/2
                Drag.mimeData: { "fromIndex": index }

            }

        }




}
