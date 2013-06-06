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
    id: stationView
    
    property bool incoming: true
    
    ListModel { id: station_model }
    
    Title {
        id: title_
        anchors.top: parent.top
    }
    
    Button {
        id: type_
        anchors.top: title_.bottom
        onClicked: {
            incoming = !incoming;
            updatePage();
        }
    }
    
    ListView {
        id: list_
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: back_.top
        anchors.top: type_.bottom
        anchors.margins: 12
        
        spacing: 12
        clip: true
        model: station_model        
        delegate: TrainDelegate {        
//            onClicked: showStation(index, model.name);
            
        }
    }
    

    Button {
        id: back_
        anchors.bottom: parent.bottom
        text: "Till stationslistan"
        onClicked: app_.setView("views/StationsView");
    }
    
    // -----------------------------------------------
    function updatePage()
    {
        var s = Data.station;
        if(!s || !s["namn"]) {
            title_.text ="Waiting...";            
            return;
        }
        
        title_.text = s["namn"];        
        type_.text = incoming ? "Ankommande" : "Avgående"
        
        var data = incoming ? s["ankommande"] : s["avgaende"]
        data = data["tag"]
        
        station_model.clear();
        for(var i = 0; i < data.length; i++) {
            station_model.append( data[i]); 
        }
    }
    
    function callback_station(succ, data)
    {
        if(succ && data && data["namn"]) {
            Data.station = data;
            updatePage();
        } else {
            console.log("could not get station: " + data);
        }
    }   
    
    onViewShown: 
    {
        Data.station = { }
        updatePage();
        
        Logic.getCurrentStation(callback_station);

    }    
}
