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
    id: trainView
    
    ListModel { id: train_model }
    
    Title {
        id: title_
        anchors.top: parent.top
    }
        
    ListView {
        id: list_
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: back_.top
        anchors.top: title_.bottom
        anchors.margins: 12
        
        spacing: 12
        clip: true
        model: train_model        
        delegate: StationDelegate { 
            onClicked: console.log("Clicked on ", idx, model);
        }
        
    }
    

    Button {
        id: back_
        anchors.bottom: parent.bottom
        text: "Till tåglistan"
        onClicked: app_.setView("views/TrainsView");
    }
    
    // -----------------------------------------------
    function updatePage()
    {
        
        var s = Data.train
        if(!s || !s["nr"]) {
            title_.text ="Waiting...";            
            return;
        }
        
        title_.text = s["nr"] + " mot " + s["till"];
        
        var stations = s["stationer"]["station"]
        
        train_model.clear();
        for(var i = 0; i < stations.length; i++) {
            train_model.append( stations[i]);
        }                
    }
    
    function callback_train(succ, data)
    {
//        console.log("CALLBACK:", succ, Json.serialize(data));
        
        if(succ && data && data["nr"]) {
            Data.train = data;
            updatePage();
        } else {
            console.log("could not get train: " + data);
        }
    }   
    
    onViewShown: 
    {
        Data.train = { }
        updatePage();
        
        Logic.getCurrentTrain(callback_train);

    }    
}
