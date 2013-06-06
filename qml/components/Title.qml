import QtQuick 1.0

import "../js/constants.js" as Constants


Rectangle {
    id: id_
    
    property alias text: t_.text
        
    height: 48
    width: parent.width
    color: Constants.color_title_bg    
    
    
    Text { 
        id: t_
        anchors.centerIn: parent
        font.pixelSize: 28
        color: Constants.color_title_fg
    }        
}
   
