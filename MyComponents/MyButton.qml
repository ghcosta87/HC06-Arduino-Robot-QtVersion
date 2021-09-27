import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Item {
    property var widthMultiplier: 1
    property int rootWidth: 200
    property int rootHeight: 80
    property var alignment
    property string title
    property string mainTheme
    property bool clickBlock: true
    signal pressed
    signal released

    property bool localPress: false
    property string noColor: '#00000000'

    function themeSelection(selection,isPressed){
        //        console.log('BUTTON > '+selection,isPressed)
        switch(selection){
        case 'normal':
            return isPressed ? 'black':'white'
        case 'night':
            return isPressed ? 'white':'black'
        case 'red':
            return isPressed ? '#EF9A9A':'red'
        default: return 'black'
        }
    }

    id:root
    width: rootWidth * widthMultiplier
    height: rootHeight * widthMultiplier
    anchors.horizontalCenter: alignment
    Rectangle {
        id: buttonItemContainer
        radius: 40
        anchors.fill: parent
        //        border.width: 1
        //        border.color: theme
        color: themeSelection(mainTheme,localPress)
        Text {
            id: buttonText
            text: title
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.capitalization: Font.AllUppercase
            color: themeSelection(mainTheme,!localPress)
            //            color: 'white'
        }
        MouseArea {
            id: clickArea
            anchors.fill: parent
            visible:clickBlock
            onPressed: {
                //                buttonItemContainer.color = noColor
                //                buttonText.color=theme
                localPress=true
                root.pressed()
            }
            onReleased: {
                //                buttonItemContainer.color = theme
                localPress=false
                releasedSignalDelay.start()
                //                buttonText.color='white'
            }
        }
        Timer{
            id: releasedSignalDelay
            interval: 100
            repeat: false
            onTriggered: {
                root.released()
            }
        }
    }
}
