import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4

Item {    
    //    anchors.fill: parent
    property int defaultWidth: 50
    property int defaultHeight: 200
    property bool themeSelection

    function itemTheme(selection){
        if (status) {//light theme

        } else {//dark theme

        }
    }

    Component.onCompleted: itemTheme(themeSelection)
    //adicionar um sinal para trocar o tema

    id: root
    width: defaultWidth
    height: defaultHeight

    Rectangle {
        id: acelaratorContainer
        //        width: parent.width * 0.5 * 0.5
        anchors.fill: parent
        color: "#00000000"


        //            OldQuick.Slider{
        Slider {
            id: acelarator
            //            to: 100
            maximumValue: 100
            stepSize: 1.0
            orientation: Qt.Vertical
            value: 1
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                fill: parent
            }
            style: SliderStyle {
                groove: Rectangle {
                    implicitWidth: root.height
                    implicitHeight: root.width*0.07
                    //                    color: "gray"
                    radius: 10
                }
                handle: Rectangle {
                    anchors.centerIn: parent
                    color: control.pressed ? {}:{}
                //                    border.color: "gray"
                border.width: 2
                implicitWidth: root.height*0.1//34
                implicitHeight: root.width*0.7  //34
                radius: 12
            }
            tickmarks: Repeater{
                model: 5
                x:0
                Text {
                    color: 'white'
                    text: qsTr("text")
                }
            }
        }
    }
}
}
