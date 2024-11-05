GUIElements = {
    windows = {
        {
            x = 460,
            y = 240,
            w = 1000, 
            h = 600, 
            text = "NAPAD NA BANK",

            elements = {
                {
                    name = "closeButton",
                    type = "button", 
                    x = 910,
                    y = 515,
                    w = 100,
                    h = 50, 
                    text = "Zamknij", 
                    action = BankRobbery.guiDestroy
                },
                {
                    name = "playerList",
                    type = "gridlist",
                    x = 20,
                    y = 50, 
                    w = 400, 
                    h = 400,

                    columns = {
                        {name = "Nazwa użytkownika", width = 0.95},
                    },
                },
                {
                    name = "selectedPlayers",
                    type = "gridlist",
                    x = 600,
                    y = 50, 
                    w = 400, 
                    h = 400,

                    columns = {
                        {name = "Nazwa użytkownika", width = 0.7},
                        {name = "Rola", width = 0.25},
                    },
                },

            },

        },
    },
}

GUITypeFunctions = {
    button = guiCreateButton,
    gridlist = guiCreateGridList,
}
