import QtQuick 1.0

import "../components"
import "../js/data.js" as Data
import "../js/db.js" as Db
import "../js/logic.js" as Logic

import "../js/constants.js" as Constants
import "../js/server.js" as Server
import "../js/json.js" as Json

View {
    id: av_
            
    Title {
        id: t_
        text: "Om appen"
    }
    
    Flickable {
        anchors.top: t_.bottom
        anchors.bottom:  d_.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12
        
        contentWidth: width
        contentHeight: at_.height
        clip: true
        
        Text {
            id: at_
            width: parent.width
            textFormat: Text.RichText        
            wrapMode: Text.Wrap
            
            font.family: "Helvetica"
            font.pointSize: 14
            color: Constants.color_page_fg             
            text: Constants.ABOUT_TEXT
            
            onLinkActivated: Qt.openUrlExternally(link)
            
        }
        
    }
    
    Button {
        id: d_
        anchors.bottom: parent.bottom
        width: parent.width
        text: "Tillbaka till menyn"
        onClicked: {
            app_.setView("views/StartView")
        }
    } 
    
    
    // ------------------------------------------------------    
    onViewShown:
    {
        // TODO
    }    
}
