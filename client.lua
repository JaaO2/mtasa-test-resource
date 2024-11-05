BankRobbery = {
    GUIElements = {
        windows = {},
    },
}

function BankRobbery:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function BankRobbery:initialize ()
    addEvent("fserver_createGUI", true)
    addEventHandler("fserver_createGUI", localPlayer, function () self:guiInitialize() end)
end

function BankRobbery:guiInitialize () 
        setElementFrozen(localPlayer, true)
        self:guiCreateWindows()
        showCursor(true)
        -- addEventHandler("onClientRender", localPlayer, BankRobbery.renderGUI)
end

function BankRobbery:guiCreateWindows () 
    for i,window in ipairs (GUIElements.windows) do 
        self:guiCreateWindow(window)
    end
end

function BankRobbery:guiCreateWindow  (window)
    local createdWindow = guiCreateWindow(window.x, window.y, window.w, window.h, window.text)
    guiWindowSetMovable(createdWindow, false)
    guiWindowSetSizable(createdWindow, false)
    table.insert(BankRobbery.GUIElements.windows, {
        window = createdWindow,
        elements = {}
    })
    local windowIndex = #BankRobbery.GUIElements.windows
    self:guiCreateElements(window.elements, windowIndex, createdWindow)
end

function BankRobbery:guiCreateElements  (elements, index, window) 
    for countElement,element in ipairs(elements) do 
        self:guiCreateElement(element, index, window)
    end
end

function BankRobbery:guiCreateElement  (element, index, window) 
    local createdElement
    if element.type == "button" then 
        createdElement = GUITypeFunctions[element.type](element.x, element.y, element.w, element.h, element.text, false, window)
        addEventHandler("onClientGUIClick", createdElement,  element.action, false)
    elseif element.type == "gridlist" then 
        createdElement = GUITypeFunctions[element.type](element.x, element.y, element.w, element.h, false, window)
        self:guiCreateGridListColumns(element, createdElement)

        if element.name == "playerList" then 
            guiGridListAddRow(createdElement, "Ładowanie graczy...")
            self:getPlayersInColshape(createdElement)
        end

        if element.name == "selectedPlayers" then 
            guiGridListAddRow(createdElement, getPlayerName(localPlayer), "Szef")
        end
    end

    table.insert(BankRobbery.GUIElements.windows[index].elements, {element = createdElement, name = element.name})
end

function BankRobbery:guiCreateGridListColumns  (element, gridList)
    for countColumn, column in ipairs(element.columns) do 
        guiGridListAddColumn(gridList, column.name, column.width)
    end
end
--BankRobbery.renderGUI  () 
--end
function BankRobbery:getPlayersInColshape  (gridList) 
    local x,y,z = getElementPosition(localPlayer)
    local players = getElementsWithinRange(x,y,z, 20, "player")
    guiGridListClear(gridList)
    if #players < 2 then 
        guiGridListAddRow(gridList, "Brak wystarczającej liczby graczy w okolicy")
    return end
    for i, player in ipairs(players) do
        if player == localPlayer then return end
        guiGridListAddRow(gridList, getPlayerName(player))
    end
end

function BankRobbery.guiDestroy  ()
    for i,window in ipairs(BankRobbery.GUIElements.windows) do
        destroyElement(window.window)
        BankRobbery.GUIElements.windows[i] = nil
    end
    setElementFrozen(localPlayer, false)
    showCursor(false)
end

local bankRobbery = BankRobbery:new{}
bankRobbery:initialize()

-- TODO: REMOVE
addCommandHandler("dev",function()
	local boolean = not getDevelopmentMode() -- true/false
	setDevelopmentMode(boolean)
	outputChatBox("DevelopmentMode: "..tostring(boolean))
end)

