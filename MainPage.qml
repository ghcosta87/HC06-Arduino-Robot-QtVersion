import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import "qrc:/MyComponents/"

Item {
    id: mainPageRoot
    anchors.fill: parent
    property var defaultMargin: parent.width * 0.02

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

    Component.onCompleted: {
        themeSet(false)
        waitingDevice()
    }

    Rectangle{
        id:timers
        visible: false
        Timer{
            id: tmp
            interval: 2000
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
                let bleData=run.getReceivedData();
                try{
                    if(bleData.length>4){
                        console.log('MYDATA >> '+bleData)
                        batteryLevel.battLevel=bleData[5]
                        bleIcon.bleStatus=0
                        myTextDebug.text=bleData[1]+' cm '+bleData[3]
                    }
                }catch(e){
                    console.log('MY ERROR >>> '+e)
                }
            }
        }

    }

    Pane{
        id:backgroundPanel
        anchors.fill: parent
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
        visible: false
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

        //        JoystickTwoButtonContainer {
        //            id: directionJoystick
        //            defaultHeight: connectButton.height * 2
        //            defaultWidth: connectButton.width * 2
        //            anchors {
        //                left: parent.left
        //                bottom: parent.bottom
        //            }
        //            onLeftPress: run.writeToDevice('L')
        //            onRightPress: run.writeToDevice('R')
        //            onButtonReleased: run.writeToDevice('N')
        //        }


    }


    Pane {
        id: rightPanel
        width: height
        height: 10
        anchors.top: configPanel.bottom
        anchors.topMargin: 0
        anchors{
            right: parent.right
            bottom: parent.bottom
            leftMargin: 0
            bottomMargin: 0
        }
        JoystickTwoButtonContainer {
            id: senseJoystick
            width: parent.width
            height: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: -45
            transformOrigin: Item.Center
            defaultHeight: connectButton.height * 2
            defaultWidth: connectButton.width * 2
            onLeftPress: run.writeToDevice('B')
            onRightPress: run.writeToDevice('F')
            onButtonReleased: run.writeToDevice('n')
        }
    }

    Pane {
        id: leftPanel
        width: height
        anchors.top: configPanel.bottom
        anchors.topMargin: 0
        anchors{
            left: parent.left
            bottom: parent.bottom
            leftMargin: 0
            bottomMargin: 0
        }
        MyJoystick{
            id:directionJoystick
            width: parent.width*0.4
            height: width
            anchors.fill: parent
            onLeftPressed: run.writeToDevice('L')
            onLeftPressReleased: run.writeToDevice('C')
            onRightPressed:run.writeToDevice('R')
            onRightPressReleased: run.writeToDevice('C')
            onBottomPressed:run.writeToDevice('S')
            onBottomPressReleased: run.writeToDevice('s')
        }
    }

    Pane {
        id: configPanel
        height: parent.height*0.2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topToolBar.bottom
        anchors.topMargin: 0
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

    Button{
        id:test
        width: 150
        height: 50
        onPressed:run.writeToDevice('S')
        onReleased: run.writeToDevice('s')
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: myTextDebug
        x: 231
        y: 54
        width: 200
        height: 100
        font.pointSize: 30
        color: 'white'
    }
}
