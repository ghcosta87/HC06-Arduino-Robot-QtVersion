import QtQml.Models 2.2
import QtQuick.Window 2.2
import QtQml 2.2
import QtQuick 2.0
import QtQuick.Shapes 1.15
import QtGraphicalEffects 1.15
import QtQuick.Particles 2.0

Item {
    signal topPressed; signal topPressReleased
    signal bottomPressed; signal bottomPressReleased
    signal leftPressed; signal leftPressReleased
    signal rightPressed; signal rightPressReleased

    id: root
    width: 500
    height: 500

    Rectangle{
        id:horizontalBackground
        height: parent.height/3
        color: '#DDDDDD'
        radius: 20
        anchors{
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }

    Rectangle{
        id:verticalBackground
        color: '#DDDDDD'
        radius: 20
        width: parent.width/3
        anchors{
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle{
        id:centerBackground
        width: verticalContainer.width*1.5
        height: horizontalContainer.height
        color: '#444444'
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter:parent.verticalCenter
        }
    }

    Rectangle{
        id:centerBackground2
        width: verticalContainer.width
        height: horizontalContainer.height*1.5
        color: '#444444'
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter:parent.verticalCenter
        }
    }

    Rectangle{
        id:horizontalContainer
        height: parent.height/3 - (horizontalBackground.height*0.1)
        color: 'transparent'
        radius: 20
        anchors{
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: horizontalBackground.height*0.1/2
            rightMargin: horizontalBackground.height*0.1/2
        }

        Rectangle{
            id:leftArrowShadowContainerRoot
            anchors.fill: parent
            color: 'transparent'
            clip: true
            Shape {
                id:leftArrowShadowContainer
                anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                ShapePath {
                    id:leftArrowShadow
                    strokeColor: 'transparent'
                    fillColor: '#444444'
                    startX:horizontalContainer.width*0.045
                    PathLine { x: horizontalContainer.width*0.045; y:horizontalContainer.height}
                    PathLine { x: horizontalContainer.width/3; y:horizontalContainer.height}
                    PathLine { x: horizontalContainer.width/2; y:horizontalContainer.height/2}
                    PathLine { x: horizontalContainer.width/3; y: 0}
                }
            }
            MouseArea{
                id:joyLeft
                width: parent.width/3
                anchors{
                 top:parent.top
                 bottom: parent.bottom
                 left:parent.left
                }
                onPressed: {
                    root.leftPressed()
                    pressed ? leftArrow.fillColor='#777777' : leftArrow.fillColor='#333333'
                    pressed ? leftArrowShadow.fillColor='#BBBBBB' : leftArrowShadow.fillColor='#444444'
                    pressed ? verticalBackgroundMask.color='#BBBBBB' : verticalBackgroundMask.color='#444444'
                }
                onReleased: {
                    root.leftPressReleased()
                    released ? (leftArrow.fillColor='#333333') : (leftArrow.fillColor='#777777')
                    pressed ? leftArrowShadow.fillColor='#BBBBBB' : leftArrowShadow.fillColor='#444444'
                    pressed ? verticalBackgroundMask.color='#BBBBBB' : verticalBackgroundMask.color='#444444'
                }
            }
        }

        Rectangle{
            id:verticalBackgroundMask
            color: '#444444'
            radius: 20
            width: verticalBackground.width/2
            anchors{
                top: parent.top
                bottom: parent.bottom
                left: parent.left

            }
        }

        Rectangle{
            id:leftIconContainer
            width: height
            radius: 20
            height: parent.height*0.5*0.8
            color: 'transparent'
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.03
            rotation: 180
            clip: true
            Shape {
                anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                ShapePath {
                    id:leftArrow
                    strokeColor: 'transparent'
                    fillColor: '#333333'
                    PathLine { x: 0; y:leftIconContainer.height}
                    PathLine { x: leftIconContainer.width; y: leftIconContainer.height/2}
                    PathLine { x: 0; y: 0}
                }
            }
        }

        Rectangle{
            id:rightArrowShadowContainerRoot
            anchors.fill: parent
            color: 'transparent'
            clip: true
            Shape {
                id:rightArrowShadowContainer
                anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                ShapePath {
                    id:rightArrowShadow
                    strokeColor: 'transparent'
                    fillColor: '#444444'
                    startX:horizontalContainer.width*0.5
                    startY:horizontalContainer.height*0.5
                    PathLine { x: horizontalContainer.width*(1-1/3); y:horizontalContainer.height}
                    PathLine { x: horizontalContainer.width-horizontalContainer.width*0.045; y:horizontalContainer.height}
                    PathLine { x: horizontalContainer.width-horizontalContainer.width*0.045; y:0}
                    PathLine { x: horizontalContainer.width*(1-1/3); y:  0}
                }
                MouseArea{
                    id:joyRight
                    width: parent.width/3
                    anchors{
                     top:parent.top
                     bottom: parent.bottom
                     right:parent.right
                    }
                    onPressed: {
                        root.rightPressed()
                        pressed ? rightArrow.fillColor='#777777' : rightArrow.fillColor='#333333'
                        pressed ? rightArrowShadow.fillColor='#BBBBBB' : rightArrowShadow.fillColor='#444444'
                        pressed ? verticalBackgroundRightMask.color='#BBBBBB' : verticalBackgroundRightMask.color='#444444'
                    }
                    onReleased: {
                        root.rightPressReleased()
                        released ? (rightArrow.fillColor='#333333') : (rightArrow.fillColor='#777777')
                        pressed ? rightArrowShadow.fillColor='#BBBBBB' : rightArrowShadow.fillColor='#444444'
                        pressed ? verticalBackgroundRightMask.color='#BBBBBB' : verticalBackgroundRightMask.color='#444444'
                    }
                }
            }
        }

        Rectangle{
            id:verticalBackgroundRightMask
            color: '#444444'
            radius: 20
            width: verticalBackground.width/2
            anchors{
                top: parent.top
                bottom: parent.bottom
                right: parent.right

            }
        }

        Rectangle{
            id:rightIconContainer
            width: height
            height: parent.height*0.5*0.8
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.03
            clip: true
            color: 'transparent'
            Shape {
                anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                ShapePath {
                    id:rightArrow
                    strokeColor: 'transparent'
                    fillColor: '#333333'
                    PathLine { x: 0; y:rightIconContainer.height  }
                    PathLine { x: rightIconContainer.width; y: rightIconContainer.height/2}
                    PathLine { x: 0; y: 0}
                }
            }
        }
    }

    Rectangle{
        id:verticalContainer
        width: parent.width/3 - (verticalBackground.width*0.1)
        color: 'transparent'
        radius: 20
        anchors{
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin:  verticalBackground.width*0.1/2
            bottomMargin:  verticalBackground.width*0.1/2
        }

        Rectangle{
            id:topArrowShadowContainerRoot
            anchors.fill: parent
            color: 'transparent'
            clip: true
            Shape {
                id:topArrowShadowContainer
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.fill: parent
                ShapePath {
                    id:topArrowShadow
                    fillColor: '#444444'
                    startY:verticalContainer.height*0.045
                    PathLine { y: verticalContainer.height*0.045; x:verticalContainer.width}
                    PathLine { y: verticalContainer.height/3; x:verticalContainer.width}
                    PathLine { y: verticalContainer.height/2; x:verticalContainer.width/2}
                    PathLine { y: verticalContainer.height/3; x: 0}
                }
            }
            MouseArea{
                id:joyTop
                height: parent.height/3
                anchors{
                 top:parent.top
                 left: parent.left
                 right:parent.right
                }
                onPressed: {
                    root.topPressed()
                    pressed ? topArrow.fillColor='#777777' : topArrow.fillColor='#333333'
                    pressed ? topArrowShadow.fillColor='#BBBBBB' : topArrowShadow.fillColor='#444444'
                    pressed ? horizontalBackgroundTopMask.color='#BBBBBB' : horizontalBackgroundTopMask.color='#444444'
                }
                onReleased: {
                    root.topPressReleased()
                    released ? (topArrow.fillColor='#333333') : (topArrow.fillColor='#777777')
                    pressed ? topArrowShadow.fillColor='#BBBBBB' : topArrowShadow.fillColor='#444444'
                    pressed ? horizontalBackgroundTopMask.color='#BBBBBB' : horizontalBackgroundTopMask.color='#444444'
                }
            }
        }

        Rectangle{
            id:horizontalBackgroundTopMask
            color: '#444444'
            radius: 20
            height: horizontalBackgroundTopMask.width/2
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
            }
        }

        Rectangle{
            id:topIconContainer
            height: width
            radius: 20
            width: parent.width*0.5*0.8
            color: 'transparent'
            clip: true
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: parent.height*0.03
            }
            Shape {
                anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                ShapePath {
                    id:topArrow
                    strokeColor: 'transparent'
                    fillColor: '#333333'
                    startY:topIconContainer.height
                    PathLine { x: topIconContainer.width; y:topIconContainer.height}
                    PathLine { x: topIconContainer.width/2; y: 0}
                }
            }
        }

        Rectangle{
            id:bottomArrowShadowContainerRoot
            anchors.fill: parent
            color: 'transparent'
            clip: true
            Shape {
                id:bottomArrowShadowContainer
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.fill: parent
                ShapePath {
                    id:bottomArrowShadow
                    fillColor: '#444444'
                    startY:verticalContainer.height-(verticalContainer.height*0.045)
                    PathLine { y: verticalContainer.height-(verticalContainer.height*0.045); x:verticalContainer.width}
                    PathLine { y: verticalContainer.height*(1-1/3); x: verticalContainer.width}
                    PathLine { y: verticalContainer.height/2; x:verticalContainer.width/2}
                    PathLine { y: verticalContainer.height*(1-1/3); x: 0}
                }
            }
            MouseArea{
                id:joyBottom
                height: parent.height/3
                anchors{
                 bottom:parent.bottom
                 left: parent.left
                 right:parent.right
                }
                onPressed: {
                    root.bottomPressed()
                    pressed ? bottomArrow.fillColor='#777777' : bottomArrow.fillColor='#333333'
                    pressed ? bottomArrowShadow.fillColor='#BBBBBB' : bottomArrowShadow.fillColor='#444444'
                    pressed ? horizontalBackgroundBottomMask.color='#BBBBBB' : horizontalBackgroundBottomMask.color='#444444'
                }
                onReleased: {
                    root.bottomPressReleased()
                    released ? (bottomArrow.fillColor='#333333') : (bottomArrow.fillColor='#777777')
                    pressed ? bottomArrowShadow.fillColor='#BBBBBB' : bottomArrowShadow.fillColor='#444444'
                    pressed ? horizontalBackgroundBottomMask.color='#BBBBBB' : horizontalBackgroundBottomMask.color='#444444'
                }
            }
        }

        Rectangle{
            id:horizontalBackgroundBottomMask
            color: '#444444'
            radius: 20
            height: horizontalBackgroundBottomMask.width/2
            anchors{
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
        }

        Rectangle{
            id:bottomIconContainer
            height: width
            radius: 20
            rotation: 180
            width: parent.width*0.5*0.8
            color: 'transparent'
            clip: true
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height*0.03
            }
            Shape {
                anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                ShapePath {
                    id:bottomArrow
                    strokeColor: 'transparent'
                    fillColor: '#333333'
                    startY:bottomIconContainer.height
                    PathLine { x: bottomIconContainer.width; y:bottomIconContainer.height}
                    PathLine { x: bottomIconContainer.width/2; y: 0}
                    //                    PathLine { x: 0; y: 0}
                }
            }
        }

    }

    Rectangle{
        id:joyHelp
        anchors.fill: parent
        color: 'transparent'
        visible: false
        Text {
            id: helpText; x:0 ;y:0
            font.pixelSize: 20
        }
        Rectangle{
            anchors.verticalCenter: parent.verticalCenter
            color: 'black'
            height: 5
            anchors.left: parent.left
            anchors.right: parent.right
        }
        Rectangle{
            anchors.horizontalCenter: parent.horizontalCenter
            color: 'black'
            width: 5
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
    }

}
