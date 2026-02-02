import QtQuick 2.7

Rectangle {
    width: 800
    height: 480
    color: "#1a1a1a"

    Text {
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Qt5 Media Player"
        color: "#00ff00"
        font.pixelSize: 48
        font.bold: true
    }

    Rectangle {
        anchors.centerIn: parent
        width: 180
        height: 180
        color: "#003366"
        border.color: "#00ff00"
        border.width: 2
        radius: 8

        Text {
            anchors.centerIn: parent
            text: "♫"
            color: "#00ff00"
            font.pixelSize: 60
        }
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Summer Breeze"
        color: "#ffff00"
        font.pixelSize: 20
        font.bold: true
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20

        Rectangle {
            width: 48
            height: 48
            color: "#003366"
            border.color: "#00ff00"
            border.width: 1
            radius: 4

            Text {
                anchors.centerIn: parent
                text: "⏮"
                color: "#00ff00"
                font.pixelSize: 20
            }
        }

        Rectangle {
            width: 60
            height: 60
            color: "#00ff00"
            border.color: "#00ff00"
            border.width: 1
            radius: 4

            Text {
                anchors.centerIn: parent
                text: "▶"
                color: "#1a1a1a"
                font.pixelSize: 28
            }
        }

        Rectangle {
            width: 48
            height: 48
            color: "#003366"
            border.color: "#00ff00"
            border.width: 1
            radius: 4

            Text {
                anchors.centerIn: parent
                text: "⏭"
                color: "#00ff00"
                font.pixelSize: 20
            }
        }
    }
}
