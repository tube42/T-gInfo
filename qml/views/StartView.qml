import QtQuick 1.0

import "../components"
import "../js/db.js" as Db
import "../js/logic.js" as Logic
import "../js/constants.js" as Constants
import "../js/server.js" as Server
import "../js/json.js" as Json

View {
    id: startView
    
    
    ButtonStack {
        anchors.centerIn: parent
        width: parent.width
        
        Button {
            text: "Stationer"
            onClicked: app_.setView("views/StationsView");
            
            Image {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 12
                source: "../images/ic_city.png"
            }
        }
        Button {
            text: "Tåg" // T�g
            onClicked: app_.setView("views/TrainsView");                  
            Image {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 12
                source: "../images/ic_train.png"
            }            
        }
        Button {
            text: "Nära dig" // "N�ra dig"
            onClicked: app_.setView("views/NearView");                                          
            Image {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 12
                source: "../images/ic_near.png"
            }            
            
        }
        Button {
            text: "Historik"
            onClicked: app_.setView("views/HistoryView");                              
            Image {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 12
                source: "../images/ic_history.png"
            }                        
        }
        
        Button {
            text: "Om"
            onClicked: app_.setView("views/AboutView");
            Image {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 12
                source: "../images/ic_about.png"
            }                        
        }
        
    }
    
    Text {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
//        width: parent.width
        
        color: Constants.color_page_fg
        font.pixelSize: 16
        text: "<a href='http://xn--tg-yia.info'>Tåginformation från Tåg.Info</a>"
        onLinkActivated: Qt.openUrlExternally(link);  
        
    }
    
}
