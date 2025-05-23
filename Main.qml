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

    function pickComponent(role) {
           switch(role) {
           case "work":      return workSlide;
           case "resources": return resourcesSlide;
           case "time":      return timeSlide;
           default:          return workSlide;
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
                    sourceComponent: pickComponent(
                                         slideManager.componentRoleAt(slideManager.currentIndex)
                                         )
                    onLoaded: {
                        item.title = slideManager.titleAt(slideManager.currentIndex);
                        item.notes =slideManager.notesAt(slideManager.currentIndex);
                        item.dueDate  = slideManager.dueDateAt(slideManager.currentIndex);
                        item.notes_changed.connect(text =>{slideManager.setNotes(slideManager.currentIndex, text);
                                                   console.log(slideManager.notesAt(slideManager.currentIndex))});
                        item.due_date_changed.connect(date => {slideManager.setDueDate(slideManager.currentIndex,date)});



                    }
        }

        // Rectangle 2
        Loader {
                    id: loaderB
                    Layout.preferredWidth: window.width*0.3
                    Layout.preferredHeight: window.height*0.5
                    sourceComponent: pickComponent(
                                         slideManager.componentRoleAt((slideManager.currentIndex + 1) % slideManager.count()))
                    onLoaded: {
                        var idx = (slideManager.currentIndex+1)%slideManager.count();
                        //load the data from c++
                        item.title = slideManager.titleAt(idx);
                        item.notes =slideManager.notesAt(idx);
                        item.dueDate  = slideManager.dueDateAt(idx);
                        item.notes_changed.connect(text =>{slideManager.setNotes(idx, text)});
                        item.due_date_changed.connect(date => {slideManager.setDueDate(idx,date)});

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
