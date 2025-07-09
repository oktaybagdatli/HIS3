import QtQuick 2.15
import QtQuick.Controls 2.15


Rectangle {
    id: root
    anchors.fill: parent
    color: "#F5A623"
    radius: 8

    property var   listModel
    property string acceptDrop   // "workToTime" or "resourceToTime" arranged in the Main.qml in OnLoaded:

    DropArea {
        id: dropArea
        anchors.fill: parent
       // keys : ["WORK"]




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

            var dst = Math.floor(drag.x / 3/* a changer apres */);
            console.log("dst", dst)
            console.log("drop recieved")
            if (drag.keys.includes("WORK"))
                slideManager.moveWorkToTime(src);
            else if (acceptDrop === "resourceToTime")
                slideManager.moveResourceToTimeAt(src, dst);

            drag.acceptProposedAction()
        }
    }
}
