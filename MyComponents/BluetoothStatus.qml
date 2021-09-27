import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    property bool bleStatus
    property string mainTheme //  night ~ normal ~ red

    property int itemHeight: 200
    property int itemWidth: 200


    id: root
    width: itemHeight
    height: itemWidth

    Component.onCompleted: setOrientation()

    function setLevel(input){
        switch(input){
        case false:
            return "roundBluetooth.svg"
        case true:
            return "roundBluetoothConnected.svg"
        default:
            return "roundBluetooth.svg"
        }
    }

    function themeSelection(selection){
        switch(selection){
        case 'normal':
            return 'black'
        case 'night':
            return 'white'
        case 'red':
            return 'red'
        default: return 'black'
        }
    }

    Image {
        id: bleIcon
        anchors.fill: parent
        horizontalAlignment: Image.AlignRight
        source: "qrc:/Images/Bluetooth/"+setLevel(bleStatus)
        mipmap: true
        autoTransform: true
        fillMode: Image.PreserveAspectFit
    }

    ColorOverlay {
        anchors.fill: bleIcon
        source: bleIcon
        color: themeSelection(mainTheme)
    }

}
