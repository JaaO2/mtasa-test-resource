local thisResource = getThisResource()
local thisResourceElement = getResourceRootElement(thisResource)
BankRobbery = {
    startMarker,
    initialize,
    hitStartMarker,
}

BankRobbery.initialize  = function () 
    BankRobbery.startMarker = createMarker(-2633.04834, 408.69843, 4.33594-1.2, "cylinder", 2, 255,0,0)
    addEventHandler("onPlayerMarkerHit", root, BankRobbery.hitStartMarker)
end

BankRobbery.hitStartMarker = function (marker, dim)
    if not dim then return end
    if marker ~= BankRobbery.startMarker then return end
    triggerClientEvent(source, "fserver_createGUI", source)
end

BankRobbery.initialize()

