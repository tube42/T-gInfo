import QtQuick 1.0

import "../js/constants.js" as Constants


Rectangle {
    id: id_
    
    property alias text: t_.text
    
    signal clicked();
    
    color: ma_.pressed ? Constants.color_item_fg : Constants.color_item_bg
    border.width: 2
    border.color: Constants.color_item_bg
    opacity: enabled ? 1 : 0.7
    
    height: 54
    width: parent.width
    
    
    Text { 
        id: t_
        anchors.centerIn: parent
//        text: model.nr
        font.pixelSize: 26
        color: ma_.pressed ? Constants.color_item_bg : Constants.color_item_fg
    }
    
    MouseArea {
        id: ma_
        anchors.fill: parent
        onClicked: id_.clicked();
        visible: id_.enabled
    }
    
}
   
