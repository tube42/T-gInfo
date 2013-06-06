import QtQuick 1.0

import "../js/constants.js" as Constants



Rectangle {
    id: i_
    
    property color fg: Constants.color_input_fg
    property color bg: Constants.color_input_bg
    property int size: 24
    property alias hints: t_.inputMethodHints
    
    signal accepted();
    signal changed();
    
    height: 12 * 2 + t_.height
    radius: 10    
    border.width: 2
    border.color: fg
    color: bg
    
    
    TextInput {
        id: t_
        anchors.centerIn: parent
        color: i_.fg
        width: parent.width * 0.9
        font.pixelSize: i_.size
        
        // XXX: turn off the damn auto correction!!
        inputMethodHints: Qt.ImhNoPredictiveText
        validator: null

        onAccepted: i_.accepted()
        onTextChanged: i_.changed();
        
        activeFocusOnPress: false
        
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!t_.activeFocus) {
                    t_.forceActiveFocus();
                    t_.openSoftwareInputPanel();
                } else {
                    t_.focus = false;
                }
            }
            onPressAndHold: t_.closeSoftwareInputPanel();
        }
    }
    
    onActiveFocusChanged: {
        if (!t_.activeFocus) {
            t_.closeSoftwareInputPanel()
            t_.closeSoftwareInputPanel();
        }
        console.log("Focus changed", t_.activeFocus, t_.focus) // DEBUG
    }


    // -------------------------
    function hideKeyboard()
    {
        t_.closeSoftwareInputPanel();
        
        t_.openSoftwareInputPanel();
        t_.closeSoftwareInputPanel();
        
    }
    
    function getText() 
    { 
        return t_.displayText;
    }
    
    function setText(text) 
    { 
        t_.text = text;
    }
    
    
}
