import QtQuick 1.0

import "../js/constants.js" as Constants


Column {
    spacing: 48
    
    move: Transition { NumberAnimation { properties: "x,y"; duration: 750;  easing.type: Easing.OutBounce } }
    add: Transition { NumberAnimation { properties: "x,y"; duration: 750;  easing.type: Easing.OutBounce } }
    
}
