import QtQuick 1.0

import "../js/constants.js" as Constants


Rectangle {
    id: id_
    
    property color bg: ma_.pressed ? Constants.color_item_fg : Constants.color_item_bg
    property color fg: ma_.pressed ? Constants.color_item_bg : Constants.color_item_fg
    
    signal clicked();
    
    color: bg
    border.width: 2
    border.color: Constants.color_item_bg
    
    height: 72
    width: parent.width
    
    // left side
    Text {
        id: nr_
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 12
        anchors.bottomMargin: 12 + 10
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        width: 72
        
        text: model.nr
        color: fg
        font.pixelSize: 24
    }
        
    Text {
        id: company_
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        width: nr_.width
        horizontalAlignment: Text.AlignHCenter
        text: "" + model["foretag"] 
        color: fg
        font.pixelSize: 10
    
    }        
    
    // middle  
    Text {
        id: tag_
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: nr_.right
        anchors.right: parent.right
        anchors.margins: 12        
        text: model["fran"] + " -- " + model["till"]
        color: fg
        font.pixelSize: 24
    }    
    
    
    MouseArea {
        id: ma_
        anchors.fill: parent
        onClicked: id_.clicked();
        visible: id_.enabled
    }
    
}
   
