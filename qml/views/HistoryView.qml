import QtQuick 1.0

import "../components"
import "../js/db.js" as Db
import "../js/logic.js" as Logic
import "../js/constants.js" as Constants
import "../js/server.js" as Server
import "../js/json.js" as Json
import "../js/data.js" as Data
import "../js/cache.js" as Cache
import "../js/filter.js" as Filter


View {
    id: historyView
    
    Title {
        id: title_
        anchors.top: parent.top
        text: "Dina senaste sökningar..."
    }
    
    ListModel { id: history_model }
        
    ListView {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: back_.top
        anchors.top: title_.bottom
        anchors.margins: 12
        
        spacing: 12
        clip: true
        model: history_model
        delegate: ItemDelegate {
            text: model.data
            onClicked: showItem(index, model)
            
            Image {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 12
                source: model.type === 0 ? "../images/ic_train2.png" : "../images/ic_city2.png"
            }            
            
        }
    }
    
    Button {
        id: back_
        anchors.bottom: parent.bottom
        text: "Tillbaka till menyn"
        onClicked: app_.setView("views/StartView");
    }
    
    // -----------------------------------------------
    function showItem(idx, model)
    {
        if(model.type === 1) {
            Logic.selectStation( model.data);
            app_.setView("views/StationView");            
            
        } else {
            Logic.selectTrain( parseInt(model.data));
            app_.setView("views/TrainView");            
        }
    }
    

    onViewShown: 
    {
        var h = Logic.getHistory();
        var h_t = h["train"];
        var h_s = h["station"];
        
        history_model.clear();
        
        for(var i = 0; i < h_s.length; i++) {            
            history_model.append( { 'type': 1, 'data': h_s[i] } );
        }
        
        for(var i = 0; i < h_t.length; i++) {            
            history_model.append( { 'type': 0, 'data': h_t[i] } );
        }
        
    }    
}
