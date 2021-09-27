import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Item {
    property int defaultWidth: 100
    property int defaultHeight: 50
    property var orientation
    property var originaToRotate
    property bool clickBlock: true

    signal leftPress
    signal rightPress
    signal buttonReleased

    id: root
    width: defaultWidth
    height: defaultHeight
    Material.background: Material.Teal

    Component.onCompleted: checkOrientation(orientation)

    Rectangle{
        id:rootContainer
        anchors.fill: parent
        color: 'transparent'
        Rectangle {
            id: centerPart
            width:parent.width * 0.7
            height:parent.height * 0.7
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: sidesPartA
            width: parent.width * 0.5
            color: "#00000000"
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }
            Rectangle {
                width: parent.width * 0.8
                height: width
                radius: 100
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    margins: parent.height * 0.005
                }
                RoundButton {
                    id: leftArrow
                    text: "<"
                    anchors{
                        fill: parent
                        margins: width*0.1
                    }
                    onPressed: root.leftPress()
                    onReleased: root.buttonReleased()
                    visible: clickBlock
                }
            }
        }

        Rectangle {
            id: sidesPartB
            width: parent.width * 0.5
            color: "#00000000"
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }
            Rectangle {
                width: parent.width * 0.8
                height: width
                radius: 100
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    margins: parent.height * 0.1
                }


                RoundButton {
                    id: rightArrow
                    text: ">"
                    anchors{
                        fill: parent
                        margins: parent.height * 0.05
                    }
                    onPressed: root.rightPress()
                    onReleased: root.buttonReleased()
                    visible: clickBlock
                }
            }
        }}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
