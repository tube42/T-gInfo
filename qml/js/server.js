/* copied from Wordy */

var server_key = "apikey=myapikey" /* get your own API key, dude! */
var server_base = "http://xn--tg-yia.info/"
var server_stations = server_base + "stationer.json" + "?" + server_key
var server_trains = server_base + "tag.json" + "?" + server_key
function server_one_station(name) { return server_base + name + ".json" + "?" + server_key; }
function server_one_train(nr) { return server_base + nr + ".json" + "?" + server_key; }

// protos:
// void access_callback(true, object obj, object userdata) // success
// void access_callback(false, string msg, object userdata) // failure

function access_url(url, callback, userdata)
{
    
    try {
        var doc = new XMLHttpRequest();
        
        doc.open("GET", url);
        
        // get the results
        doc.onreadystatechange = function() {                        
            if(doc.readyState == 4) {
                var n = doc.status / 100;
                
                if(Constants.debug) console.log("access: status = ", doc.status);
                
                if(n == 2) {                    
                    callback(true, doc, userdata);
                } else {
                    callback(false, (doc.status == 0) ? "Network error" : "HTTP error " + doc.status, userdata);
                }
            }            
        }
        doc.send();
        return doc;
    } catch(error) {
        console.log("server error:", error);
        callback(false, "Internal error: " + error, userdata);   
    }    
}

function access(url, params, callback, userdata)
{
    // set together the parameter string
    var pstr = "";
    var first = url.indexOf('?') < 0 ? true : false
    
    for(var x in params) {
        pstr += (first ? '?' : '&')
        pstr = pstr + escape(x) + "=" + escape(params[x]);
        first = false
    }
    var url = url + pstr
    
    if(Constants.debug) console.log("accessing" , url); // DEBUG
    
    // connect the to server
    return access_url(url, callback, userdata)
}


// -----------------------------------------------------

function accessText(url, params, callback, userdata)
{
    return access(url, params, function(succ, data, user) { 
                  if(succ) data = data["responseText"]
                  callback(succ, data, user); 
              }, userdata);
}


function accessJson(url, params, callback, userdata)
{
    return access(url, params, function(succ, data,user) {
                  if(succ) data = Json.unserialize( doc.responseText );
                  callback(succ, data, user); 
              }, userdata);
}


function accessXml(url, params, on_success, on_failure, userdata)
{
    return access(url, params, function(succ, data,user) {
                  if(succ) data = doc.responseXML
                  callback(succ, data, user); 
              }, userdata);    
}
