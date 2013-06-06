import QtQuick 1.0

import "../components"
import "../js/db.js" as Db
import "../js/logic.js" as Logic
import "../js/constants.js" as Constants
import "../js/server.js" as Server
import "../js/json.js" as Json
import "../js/data.js" as Data
import "../js/cache.js" as Cache


View {
    id: closeView
        
    Title {
        id: title_
        anchors.top: parent.top        
        text: "Nära dig"
    }
    
    
    ListModel { id: stations_model }
    
    ListView {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: back_.top
        anchors.top: title_.bottom
        anchors.margins: 12
        
        spacing: 12
        clip: true
        model: stations_model        
        delegate: ItemDelegate {        
            text: model.name
            onClicked: showStation(index, model.name);            
        }
    }
    
    Button {
        id: back_
        anchors.bottom: parent.bottom
        text: "Tillbaka till menyn"
        onClicked: app_.setView("views/StartView");
    }
    
    // -----------------------------------------------
    function showStation(idx, name)
    {        
        var station = Data.stations[idx];
        var name = station["namn"];
        if(!name) return;
        
        // {'namn':'Stockholm C','url':'http://xn--tg-yia.info/Stockholm C.xml','lat':'59.33','lon':'18.0573'}                
        Logic.selectStation(name);
        app_.setView("views/StationView");
    }
    
    function update()
    {
        var stations = []; // TODO: get this from GPS
        
        // build list
        stations_model.clear();
        var cnt = 0;
        for(var i = 0; i < stations.length; i++) {           
            var dat = stations[i];
            stations_model.append( { 'name': dat["namn"] } );
        }   
       Data.stations = stations; // save it for later use 
    }
    
    // ----------------------------
    
    
    onViewShown: 
    {
        update();
    }
}
