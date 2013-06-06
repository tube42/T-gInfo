
/* network access cache functions:
  * returns a cached version of data if its not too old
  */


// returns number of minutes since epoc.
function getMinutesCounter()
{
    var date = new Date;
    return Math.floor(date.getTime() / (60 * 1000));
}

// ----------
function get(url, name, cache_age, callback, userdata)
{
    if(Constants.debug) cache_age *= 100 /* dont update too often during development */
                                           
    // see how old our database is
    var time_last = parseInt(Db.get(name + ".time.minutes", "0"))
    var time_now = getMinutesCounter();
    var age = time_now - time_last;
    
    var ret = Db.get(name + ".data");
    
    //    console.log("GET CACHED " + name + ": " + time_last + ", " + time_now + " -> " + age + "?" + cache_age + " => " + ret); // DEBUG
    if( (age > cache_age) || !ret) {
        var doc = Server.accessText(url, {},
                                    function(succ, data, udata) {
                                        if(succ) {
                                            Db.set(name + ".time.minutes", time_now);
                                            Db.set(name + ".data", data);
                                            console.log("Downloaded new version of " + name + ", age of cached: " + age); // DEBUG
                                            
                                            callback(true, Json.unserialize(data), udata);
                                            
                                        } else {                                  
                                            console.log("Could not get data for " + name + ": " + data)
                                            callback(false, data, udata);
                                        }
                                    }, userdata);        
    } else {
        console.log("Using cached version of " + name + ", age " + age); // DEBUG
        callback(true, Json.unserialize(ret), userdata);
        
    }
}


