import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#F5A623"
    radius: 8

    property var   listModel
    property string acceptDrop   // "workToTime" or "resourceToTime"
    property int    slotCount: 8

    // 1) Permanent grid lines
    Canvas {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d"),
                cols = slotCount,
                cellW = width/cols;
            ctx.clearRect(0,0,width,height);
            ctx.strokeStyle = "rgba(255,255,255,0.3)";
            ctx.lineWidth = 1;
            for (var i = 1; i < cols; ++i) {
                var x = cellW * i;
                ctx.beginPath();
                ctx.moveTo(x, 0);
                ctx.lineTo(x, height);
                ctx.stroke();
            }
        }
        Component.onCompleted: requestPaint()
        onWidthChanged:  requestPaint()
        onHeightChanged: requestPaint()
    }

    // 2) Single-row GridView of items
    GridView {
        id: grid
        anchors.fill: parent
        model: listModel
        flow: GridView.LeftToRight
        cellHeight: parent.height
        cellWidth: parent.width / slotCount

        delegate: Rectangle {
            width: grid.cellWidth
            height: grid.cellHeight
            color: "#F2994A"
            radius: 4

            Text {
                text: model.display
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 16
                wrapMode: Text.WordWrap
            }
        }
    }

    // 3) DropArea: compute target cell & call C++ at-index
    DropArea {
        id: dropArea
        anchors.fill: parent

        onEntered: root.cursorShape = Qt.DragCopyCursor
        onExited:  root.cursorShape = Qt.ArrowCursor

        onDropped: function(drag) {
            var src = drag.mimeData.fromIndex;
            var dst = Math.floor(drag.x / grid.cellWidth);
            if (acceptDrop === "workToTime")
                slideManager.moveWorkToTimeAt(src, dst);
            else if (acceptDrop === "resourceToTime")
                slideManager.moveResourceToTimeAt(src, dst);
        }
    }
}
