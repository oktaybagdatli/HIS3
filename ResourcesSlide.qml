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
                property int myIndex: index

                property real initial_x
                property real initial_y
                width: loaderA.width; height: 40
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

                    onPressed : {
                        console.log("index of the resource is ", index)
                        delegateItem.initial_x = delegateItem.x
                        delegateItem.initial_y = delegateItem.y
                    }

                    onPressAndHold:{
                        delegateItem.Drag.startDrag(Qt.CopyAction)
                        console.log("drag start")

                    }

                    onReleased : {
                        console.log("Released")
                        let result  = delegateItem.Drag.drop()
                        if(result === Qt.IgnoreAction){
                            delegateItem.x = delegateItem.initial_x
                            delegateItem.y = delegateItem.initial_y
                        }
                    }
                }
                Drag.keys: ["RESOURCE"]
                Drag.active: dragArea.drag.active
                Drag.hotSpot.x: width/2
                Drag.hotSpot.y: height/2


            }

        }




}
