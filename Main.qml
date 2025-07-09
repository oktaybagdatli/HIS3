import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "."

Window {


    id: window
    visible: true
    width: 640
    height: 480
    title: "HIS3"

    function pickComponent(nbRect, nbIndex){
        if (nbRect ===  1){
            switch(nbIndex){
            case 0:
                return workSlide
            case 1:
                return resourcesSlide
            case 2:
                return workSlide
            }

        }else if(nbRect === 2){
            switch(nbIndex){
            case 0:
                return timeSlide
            case 1:
                return timeSlide
            case 2:
                return resourcesSlide
            }
        }
    }










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
                               slideManager.previous();
                               //TODO
                               //save the progress of the user in the form of a timetable
                               //A tester
                               // correcte maj depuis les methodes de C++ avec un console.log()

                }
            }
        }
        // Rectangle 1
        Loader {
                    id: loaderA
                    Layout.preferredWidth: window.width*0.3
                    Layout.preferredHeight: window.height*0.5
                    sourceComponent: pickComponent(1, slideManager.currentIndex)
                    onLoaded: {
                        switch (slideManager.currentIndex) {
                                        case 0: // Work→Time
                                            item.listModel = slideManager.workItemsModel

                                            break
                                        case 2: // Work→Resources
                                            item.listModel = slideManager.workItemsModel

                                            break
                                        case 1: // Resources→Time
                                            item.listModel = slideManager.resourceItemsModel

                                            break
                        }




                    }
        }

        // Rectangle 2
        Loader {
                    id: loaderB
                    //ternary operation with slideManager.currentIndex
                    Layout.preferredWidth: window.width*0.3
                    Layout.preferredHeight: window.height*0.5
                    sourceComponent: pickComponent(2, slideManager.currentIndex)
                    onLoaded: {
                        switch (slideManager.currentIndex) {
                                        case 0: // Work→Time
                                            item.listModel  = slideManager.timeItemsModel
                                            item.acceptDrop = "workToTime"
                                            break
                                        case 1: // Resources→Time
                                            item.listModel  = slideManager.timeItemsModel
                                            item.acceptDrop = "resourceToTime"
                                            break
                                        case 2: // Work→Resources
                                            item.listModel  = slideManager.resourceItemsModel

                                            break
                        }


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
                    slideManager.next()
                }
            }
        }
    }//end of RowLayout




    Component {
            id: workSlide
            WorkSlide { }
        }
        Component {
            id: resourcesSlide
            ResourcesSlide { }
        }
        Component {
            id: timeSlide
            TimeSlide { }
        }


}
