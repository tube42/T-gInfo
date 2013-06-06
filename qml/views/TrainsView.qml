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
    id: startView
    
    ListModel { id: trains_model }
    
    Input {
        id: filterInput_
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right       
        anchors.margins: 12
        
        hints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
        onChanged: updateFilter();
    }
    
    ListView {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: back_.top
        anchors.top: filterInput_.bottom
        anchors.margins: 12
        
        spacing: 12
        clip: true
        model: trains_model
        delegate: ItemDelegate {        
            text: model.nr
            onClicked: showTrain(index, model.nr);
        }
    }
    
    Button {
        id: back_
        anchors.bottom: parent.bottom
        text: "Tillbaka till menyn"
        onClicked: app_.setView("views/StartView");
    }
    
    // -----------------------------------------------
    function showTrain(idx, nr)
    {
        
        var train = Data.trains_filtered[idx];        
        var nr = train["nr"];
        if(!nr) return;
        
        // {'nr':'72','datum':'20120601','url':'http://xn--tg-yia.info/72,20120601.xml'}
        Logic.selectTrain( parseInt(nr));
        app_.setView("views/TrainView");
    }
    
    function updateFilter()
    {
        // get filtered list
        var str = filterInput_.getText();        
        if(!str) str = "";
        var filtered = Filter.apply(Data.trains, "nr", str, true);
        
        trains_model.clear();
        for(var i = 0; i < filtered.length; i++) {            
            var dat = filtered[i];
            trains_model.append( dat );
        }
        Data.trains_filtered = filtered;
    }
    // -----------------------------------------------
    function callback_trains(succ, data)
    {
        if(succ && data && data["tag"]) {
            Data.trains = data["tag"];                        
        } else {
            console.log("no train data found: " + data);
        }
        updateFilter();                
    }
    onViewHidden:
    {
        filterInput_.hideKeyboard();
    }
        
    onViewShown: 
    {
        Data.trains = []
        Data.trains_filtered = []
        updateFilter();       
        
        Logic.getTrains(callback_trains);

    }    
}
