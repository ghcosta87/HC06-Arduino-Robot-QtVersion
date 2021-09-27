import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import "qrc:/MyComponents/"

Item {
    anchors.fill: parent
    property var defaultMargin: parent.width * 0.02

    Component.onCompleted: {
        themeSet(false)
        waitingDevice()
    }

    Timer{
        id: tmp
        interval: 5000
        repeat: false
        onTriggered: run.connectToDevice()
    }

    Timer {
        id: startLoop
        interval: 500
        repeat: true
        onTriggered: {
            if (run.connectionStatus()) {
                startLoop.stop()
                readLoop.start()
                busyIndicator.running = false
                busyContainer.visible=false
                themeSelector.checkable=true
                connectButton.clickBlock=true
                readButton.clickBlock=true
                directionJoystick.clickBlock=true
                senseJoystick.clickBlock=true
                bleIcon.bleStatus=true
            }
        }
    }

    Timer {
        id: readLoop
        interval: 500
        repeat: true
        onTriggered: {
            if(!run.connectionStatus())waitingDevice()
            batteryLevel.battLevel=run.readData('batt')
            bleIcon.bleStatus=run.readData('ble')
        }
    }

    function waitingDevice(){
        busyIndicator.running = true
        busyContainer.visible=true
        startLoop.start()
        readLoop.stop()
        tmp.start()
        themeSelector.checkable=false
        connectButton.clickBlock=false
        readButton.clickBlock=false
        directionJoystick.clickBlock=false
        senseJoystick.clickBlock=false
    }

    function themeSet(status) {
        if (status) {
            Material.theme = Material.Light
            Material.accent = Material.Indigo
            theme='normal'
        } else {
            Material.theme = Material.Dark
            Material.accent = Material.Purple
            theme='night'
        }
    }

    Pane{
        id:topToolBar
        height: parent.height*0.1
        anchors{
            top: parent.top
            left:parent.left
            right: parent.right
        }

        BatteryLevel{
            id:batteryLevel
            itemWidth: parent.width*0.1
            width: parent.width*0.1
            mainTheme:theme
            imagePath: "qrc:/Images/BaterryPngSet/"
            anchors{
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                topMargin: -8
                bottomMargin: -8
                rightMargin: -8
            }
        }

        BluetoothStatus{
            id:bleIcon
            width: batteryLevel.width/2
            mainTheme:theme
            anchors{
                top: parent.top
                bottom: parent.bottom
                right: batteryLevel.left
                topMargin: -8
                bottomMargin: -8
                rightMargin: -8
            }
        }

        Switch {
            id: themeSelector
            anchors{
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }
            onCheckedChanged: themeSet(checked)
            //            text: "Tema"
        }
    }

    Pane {
        anchors.fill: parent
        anchors.topMargin: topToolBar.height

        Rectangle {
            id: buttonsPanel
            width: parent.width*0.5//338
            height: parent.height*0.45//234
            radius: 20
            anchors{
                top: parent.top
                left: parent.left
            }
            Material.elevation: 6
            color: paneTheme(theme)

            function paneTheme(input){
                switch(input){
                case 'normal':return '#607D8B'
                case 'night':return '#9E9E9E'
                    //                case 'red':return Material.Red
                }
            }


            Column {
                id: column_1
                anchors.fill: parent
                anchors.rightMargin: parent.width/2
                MyButton {
                    id: connectButton
                    title: "CONECTAR"
                    rootHeight: parent.height*0.3
                    //                    rootWidth: parent.width*0.45
                    mainTheme:theme
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: defaultMargin*1.2
                    }
                    onPressed: run.connectToDevice()
                }
            }

            Column {
                id: column_2
                anchors{
                    left: column_1.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }

                MyButton {
                    id: readButton
                    title: "READ"
                    rootHeight: connectButton.height
                    //                    rootWidth: connectButton.width
                    mainTheme:theme
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: defaultMargin
                    }
                    //                                        onPressed: run.setConnectionStatus()//batteryLevel.battLevel=run.readData('batt')
                }
            }

        }
        //        Slider {
        //            id: slider
        //            to:100
        //            stepSize: 5
        //            value:10
        //            width: directionJoystick.width
        //            anchors{
        //                bottom: directionJoystick.top
        //                left: parent.left
        //                bottomMargin: defaultMargin*3
        //                leftMargin: defaultMargin
        //            }
        //            onValueChanged: {run.writeToDevice(slider.value)}
        //        }

        JoystickTwoButtonContainer {
            id: directionJoystick
            defaultHeight: connectButton.height * 2
            defaultWidth: connectButton.width * 2
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            onLeftPress: run.writeToDevice('L')
            onRightPress: run.writeToDevice('R')
            onButtonReleased: run.writeToDevice('N')
        }

        JoystickTwoButtonContainer {
            id: senseJoystick
            rotation: 90
            transformOrigin: Item.BottomRight
            defaultHeight: connectButton.height * 2
            defaultWidth: connectButton.width * 2
            anchors {
                right: parent.right
                bottom: parent.bottom
                rightMargin: 110
                //145 (defaultMargin * 12)
                //9 ( parent.height * 0.01 )
            }
            onLeftPress: run.writeToDevice('F')
            onRightPress: run.writeToDevice('B')
            onButtonReleased: run.writeToDevice('n')
        }
    }

    Rectangle{
        id:busyContainer
        anchors.fill: parent
        color: "black"
        opacity: 0.6
        BusyIndicator {
            id: busyIndicator
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.8999999761581421;height:480;width:640}
}
##^##*/
