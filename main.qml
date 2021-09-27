import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    readonly property string version: "v1.0"
    property string theme: 'normal' //  night ~ normal ~ red

    id: window
    visibility: "FullScreen"
    title: "BLE QT test" +version

    StackView {
        id: stackView
        initialItem: mainPage
        anchors.fill: parent
    }
    Component {
        id: mainPage
        MainPage {}
    }
    Component {
        id: testPage
        TestComponent {}
    }
}
