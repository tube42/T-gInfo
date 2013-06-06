import QtQuick 1.0

import "components"

import "js/data.js" as Data
import "js/server.js" as Server
import "js/constants.js" as Constants
import "js/json.js" as Json
import "js/db.js" as Db
import "js/logic.js" as Logic
import "js/cache.js" as Cache


// TODO
// use google static map api
// http://maps.googleapis.com/maps/api/staticmap?center=60.6031,15.6424&zoom=12&size=640x360&sensor=false&language=sv

Rectangle {
    id: app_
    color: Constants.color_page_bg
    
    // Debug warning
    Text {
        color: "red"
        text: "DEBUG IS ON!"
        visible: Constants.debug
    }
    
    // ----------------------------------------
    function loadView(name)
    {
        var component = Qt.createComponent(name + ".qml");
        if (component.status == Component.Ready) {
            var obj = component.createObject(app_, {"anchors.fill" : app_, "visible" : false, "viewName": name } );
            if(obj != null) {
                return obj;
            } else console.log("Could not create object " + name + " from " + component);
        } else console.log("Unable to load " + name + ": " + component.status, ":\n", component.errorString() );
        return null;
    }
    
    function findView(name)
    {
        for(var i = 0; i < Data.views.length; i++) {
            var item = Data.views[i];
            if(item["viewName"] === name) return item;
        }        
        return null;
    }
    function setView(name)
    {
        var item = findView(name);
        
        if(!item) {
            item = loadView(name);            
            if(!item) return;
            Data.views.push(item);
        }
        
        if(item === Data.currentView) return; // no change
        
        if(Data.currentView) {            
            Data.currentView.animHide();
            Data.currentView.viewHidden();            
        }
        Data.currentView = item;
        if(Data.currentView) {
            Data.currentView.animShow();
            Data.currentView.viewShown();            
        }
    }
    
    // ------------------------------------
    Component.onCompleted:
    {
        // init
        Data.views = new Array();
        Data.currentView = null;
        
        Logic.initApp();
        setView("views/StartView");
    }
    
    
}
