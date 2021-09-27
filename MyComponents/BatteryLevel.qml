import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    property int battLevel
    property string imagePath

    property int itemHeight: 600
    property int itemWidth: 200
    property string mainTheme //  night ~ normal ~ red
    property string orientation:'rightToLeft' // 'leftToRight' and 'rightToLeft' [default rightToLeft]

    property int componentSpacing: parseInt(root.width*0.007)
    property int bordersWidth:parseInt(root.width*0.016)
    property int defaultRadius:parseInt(root.width*0.016)

    id: root
    width: itemHeight
    height: itemWidth

    Component.onCompleted: setOrientation()

    function setLevel(input){
        switch(input){
        case 0:
            return "batt_0.png"
        case 1:
            return "batt_1.png"
        case 2:
            return "batt_2.png"
        case 3:
            return "batt_3.png"
        case 4:
            return "batt_4.png"
        default:
            return "batt_0.png"
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
        id: battIcon
        anchors.fill: parent
        horizontalAlignment: Image.AlignRight
        source: imagePath+setLevel(battLevel)
        mipmap: true
        autoTransform: true
        fillMode: Image.PreserveAspectFit
    }

    ColorOverlay {
        anchors.fill: battIcon
        source: battIcon
        color: themeSelection(mainTheme)
    }

}
