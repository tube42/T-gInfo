

// -----------------------------------------------

function getStations(callback)
{
    Cache.get(Server.server_stations, "stations", 60 * 24 * 7, callback)
}

function getTrains(callback)
{
    Cache.get(Server.server_trains, "trains", 60 * 24 * 7, callback)
}


function getCurrentStation(callback)
{
    var name = Db.get("current.station", undefined);
    if(!name) {
        callback(false, "INTERNAL: current station was not set");
    } else {
        Cache.get(Server.server_one_station(name), "station." + name, 3, callback);
    }
}

function getCurrentTrain(callback)
{
    var nr = Db.get("current.train", undefined);
    if(!nr) {
        callback(false, "INTERNAL: current train was not set");
    } else {
        nr  = parseInt(nr);
        Cache.get(Server.server_one_train(nr), "train." + nr, 3, callback);
    }    
    return null; // TODO
}

// -----------------------------------------------
function addToHistory(db_name, data)
{
    var hist = Json.unserialize( Db.get(db_name, "[]") );
    var hist_new = new Array();
    
    hist_new[0] = data;
    
    var i2 = 1;
    for(var i = 0; i < Math.min(5, hist.length); i++)  {
        if(hist[i] != data) hist_new[i2++] = hist[i];
    }
    
    var txt = Json.serialize(hist_new);    
    Db.set(db_name, txt);
    
}

function getHistory()
{
    return {
        'train': Json.unserialize( Db.get("history.train", "[]") ),
        'station': Json.unserialize( Db.get("history.station", "[]"))
        };
}

function selectStation(name)
{
    Db.set("current.station", name);
    addToHistory("history.station", name);    
}

function selectTrain(nr)
{
    // this code could be some much simple if push/popo worked here
    Db.set("current.train", nr);
    addToHistory("history.train", "" + nr);
}

// -------------------------------------
function initApp()
{    
    // empty for now    
}

