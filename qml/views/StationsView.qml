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
    
    
    ListModel { id: stations_model }
    
    Input {
        id: filterInput_
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right       
        anchors.margins: 12
        
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
        var station = Data.stations_filtered[idx];
        var name = station["namn"];
        if(!name) return;
        
        // {'namn':'Stockholm C','url':'http://xn--tg-yia.info/Stockholm C.xml','lat':'59.33','lon':'18.0573'}                
        Logic.selectStation(name);
        app_.setView("views/StationView");
    }
    
    function updateFilter()
    {
        // first get filtered input
        var str = filterInput_.getText();        
        if(!str) str = "";        
        var filtered = Filter.apply(Data.stations, "namn", str, false);
        
        // build list
        stations_model.clear();
        var cnt = 0;
        for(var i = 0; i < filtered.length; i++) {           
            var dat = filtered[i];
            stations_model.append( { 'name': dat["namn"] } );
        }   
        
        // save filtered list for later
        Data.stations_filtered = filtered        
    }
    // ----------------------------
    function callback_stations(succ, data)
    {
        if(succ && data && data["station"]) {
            Data.stations = data["station"];                        
        } else {
            console.log("no station data found: " + data);
        }
        updateFilter();        
    }
    
    onViewHidden:
    {
        filterInput_.hideKeyboard();
    }
    
    onViewShown: 
    {
        Data.stations = []        
        Data.stations_filtered = []        
        updateFilter();                
        
        Logic.getStations(callback_stations);        
    }    
}
