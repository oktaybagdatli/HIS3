import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id : root
    color: "#50E3C2"
    radius: 8
    anchors.fill: parent
    clip:false

    property var listModel


        ListView {
            id:list
            anchors.fill: parent
            clip: false
            model: listModel
            delegate: Item {
                id : delegateItem
                width: parent.width; height: 40
                Text {
                    id : label
                    text: model.display
                    color: "black"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                }

                // enable drag always
                MouseArea {
                    id : dragArea
                    anchors.fill: parent
                    drag.target : delegateItem



                    onPressAndHold:{
                        drag.startDrag(Qt.CopyAction)
                        console.log("drag start")

                    }

                    onReleased : {
                        console.log("Released")
                        delegateItem.Drag.drop()
                    }
                }
                Drag.keys: ["application/x-item-index"]
                Drag.active: dragArea.drag.active
                Drag.hotSpot.x: width/2
                Drag.hotSpot.y: height/2
                Drag.mimeData: { "application/x-item-index": delegateItem.index }

            }

        }




}
