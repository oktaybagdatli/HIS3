import QtQuick 2.15
import QtQuick.Controls 2.15


Rectangle {
    id: root
    color: "transparent"
    anchors.fill: parent
    radius: 8
    border.color: "black"

    property var   listModel
    property string acceptDrop   // "workToTime" or "resourceToTime" arranged in the Main.qml in OnLoaded:

    ListView  {
        id : list
        clip: false
        model : listModel
        delegate : Item {
            id : delegateItem
            property int myIndex : index
            width : loaderB.width;  height : loaderB.height /5
            Text {
                id : label
                text : model.display
                color : "black"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 8
            }

        }


    }
    DropArea {
        id: dropArea
        anchors.fill: parent







        onDropped: function(drag) {
            //TODO : how to recieve the data

            if (!drag.source)
            {
                drag.accept = false;
                return;
              }

            // ------------------------------------------------
            var src = drag.source.myIndex;
            //var src = Drag.mimeData["application/x-item-index"]
            //-------------------------------------------------

            console.log("src ",src)
/*
            var dst = delegateItem.myIndex;
            console.log("dst", dst)
            */
            console.log("drop recieved")
            if (drag.keys.includes("WORK"))
                slideManager.moveWorkToTime(src);
            else if (drag.keys.includes("RESOURCE"))
                slideManager.moveResourceToTime(src);

            drag.acceptProposedAction()
        }
    }


}
