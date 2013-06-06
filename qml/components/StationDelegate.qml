import QtQuick 1.0

import "../js/constants.js" as Constants


Rectangle {
    id: id_
    
    property color bg: ma_.pressed ? Constants.color_item_fg : Constants.color_item_bg
    property color fg: ma_.pressed ? Constants.color_item_bg : Constants.color_item_fg
    
    signal clicked(int idx, variant model);
    
    color: bg
    border.width: 2
    border.color: Constants.color_item_bg
    
    height: 72
    width: parent.width
    
    // middle  
    Text {
        anchors.centerIn: parent
        text: model["namn"]
        color: fg
        font.pixelSize: 24
    }    
    
    
    MouseArea {
        id: ma_
        anchors.fill: parent
        onClicked: id_.clicked(index, model);
        visible: id_.enabled
    }
    
}
   
