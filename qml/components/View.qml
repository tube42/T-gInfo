/* stolen from Wordy */
import QtQuick 1.0

Item {
    id: view_
    
    property string viewName    
    
    signal viewHidden();
    signal viewShown();
    
    function animShow() { anim_show_.start(); }
    function animHide() { anim_hide_.start(); }
        
    SequentialAnimation {
        id: anim_hide_        
        ParallelAnimation {
            PropertyAnimation { target: view_; property: "opacity"; from: 1; to: 0; duration: 200 }        
            PropertyAnimation { target: view_; property: "scale"; from: 1; to: 0.2; duration: 200 }                    
        }
        ScriptAction { script: visible = false;  }
    }
    
    SequentialAnimation {
        id: anim_show_
        PauseAnimation { duration: 150 }        
        ScriptAction { script: visible = true;  }
        ParallelAnimation {        
            PropertyAnimation { target: view_; property: "opacity"; from: 0; to: 1; duration: 300 }                
            PropertyAnimation { target: view_; property: "scale"; from: 0.2; to: 1; duration: 250 }        
        }
        
    }
    
}
