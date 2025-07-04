import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#4A90E2"
    radius: 8
    anchors.fill: parent
    clip:false


    property var listModel

        ListView {
            anchors.fill: parent
            clip: false
            model: listModel
            delegate: Item {
                id : delegateItem
                width: parent.width; height: 40
                Text {
                    id : label
                    text: model.display
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                }

                MouseArea {
                    id : dragArea
                    anchors.fill: parent
                    drag.target: delegateItem
                    onPressAndHold : {
                        drag.startDrag(Qt.CopyAction)
                    }
                }
                Drag.active : dragArea.drag.active
                Drag.hotSpot.x: width/2; Drag.hotSpot.y: height/2
                Drag.mimeData: { "application/x-item-index":  index.toString()}

            }
        }
}
