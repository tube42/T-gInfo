import QtQuick 1.0

import "../js/constants.js" as Constants


Item {
    id: bi_
    property color fg: Constants.color_button_fg
    property color bg: Constants.color_button_bg
    property int size: 32
    property alias text: t_.text
    property bool enabled: true
    
    signal clicked();
    
    height: 16 * 2 + size    
    // default positioning
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: 16
    
    scale: ma_.pressed ? 1.05 : 1.0
    Behavior on scale { NumberAnimation { duration: 50 } }
    
    BorderImage {
        anchors.fill: parent
        anchors.margins: -5
        visible: bi_.enabled
        source: "../images/border1.png"
        border { left: 12; top: 12; right: 12; bottom: 12 }        
    }
    
    
    Rectangle {
        id: b_        
        anchors.fill: parent            
        color: ma_.pressed ? bi_.fg : bi_.bg
        opacity: bi_.enabled ?  1 : 0.5
        
        
        Text {
            id: t_
            anchors.centerIn: parent
            color: ma_.pressed ? bi_.bg : bi_.fg
            font.pixelSize: bi_.size
        }
        
        MouseArea {
            id: ma_
            anchors.fill: parent
            onClicked: bi_.clicked();
            visible: bi_.enabled
        }
    }
}
