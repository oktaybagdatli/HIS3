import QtQuick 2.15
import QtQuick.Controls 2.15


Rectangle {
    id: root
    anchors.fill: parent
    color: "#F5A623"
    radius: 8

    property var   listModel
    property string acceptDrop   // "workToTime" or "resourceToTime"

    DropArea {
        id: dropArea
        anchors.fill: parent
        keys : ["application/x-item-index"]




        onDropped: function(drag) {
            var src = parseInt(drag.getDataAsString("application/x-item-index"));

            var dst = Math.floor(drag.x / slideManager.count());
            if (acceptDrop === "workToTime")
                slideManager.moveWorkToTimeAt(src, dst);
            else if (acceptDrop === "resourceToTime")
                slideManager.moveResourceToTimeAt(src, dst);

            drag.acceptProposedAction()
        }
    }
}
