import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id : root
    color: "#4A90E2"
    radius: 8
    anchors.fill: parent
    clip:false


    property var listModel

        ListView {
            id: list
            anchors.fill: parent
            clip: false
            model: listModel
            delegate: Item {
                id : delegateItem
                property var initial_x
                property var initial_y
                width: 40; height: 40
                Text {
                    id : label
                    text: model.display
                    color: "black"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                }

                MouseArea {
                    id : dragArea
                    anchors.fill: parent
                    drag.target: delegateItem

                    onPressed: {
                        delegateItem.initial_x = delegateItem.x
                        delegateItem.initial_y = delegateItem.y

                    }

                    onPressAndHold : {
                        delegateItem.Drag.startDrag(Qt.CopyAction)
                        console.log("drag started")
                    }
                    onReleased: {
                        //returning to their old places
                        if(root.contains(delegateItem) || !loaderB.contains(Qt.point(delegateItem.Drag.x, delegateItem.Drag.y))){
                            console.log(root.contains(delegateItem))
                            console.log(!loaderB.contains(Qt.point(delegateItem.Drag.x, delegateItem.Drag.y)))
                            delegateItem.x = delegateItem.initial_x
                            delegateItem.y = delegateItem.initial_y
                            delegateItem.Drag.cancel()
                            return
                        }

                        delegateItem.Drag.drop()
                        console.log("released")

                    }
                }
                Drag.keys : ["application/x-item-index"]
                Drag.active : dragArea.drag.active
                Drag.hotSpot.x: width/2; Drag.hotSpot.y: height/2
                Drag.mimeData: { "application/x-item-index":  index.toString()}

            }
        }
}
