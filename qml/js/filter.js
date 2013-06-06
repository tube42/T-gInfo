
/*
 * filter a list based on whether a string was found in one of its member
 */ 

function apply(src, element, str, startWith)
{
    
    str = str.toLowerCase();
    
    var cnt = 0;
    var ret = [];
    for(var i = 0; i < src.length; i++) {
        var tmp1 = src[i];
        if(!tmp1) continue;
        
        var tmp2 = tmp1[element];
        if(!tmp2) continue;
        
        tmp2 = tmp2.toLowerCase();
        
        var n = tmp2.indexOf(str);        
        if(n === -1) continue;
        if(n != 0 && startWith) continue;
        
        ret[cnt++] = tmp1;
    }
    return ret;
}
