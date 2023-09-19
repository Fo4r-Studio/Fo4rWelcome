Config = {}

Config.Webhook = 'https://discord.com/api/webhooks/1153646268166451301/TjQFOqNq785q-wJ-Mr9NTkokfzoHdwxx2Hj1eS3lDnkrg6Toj1oPlNjIW38z5KiOcJIN'

Config.Labels = {
    ServerName = "Fo4r",
    Press = 'Press ~g~[E]~w~ to open menu',
    WelcomeMessage = 'Welcome to Fo4r',
    Webhook1 = 'Has claimed the welcome package',
    Webhook2 = 'Has redeemed the code: ',
}

Config.Coords = {x = -1036.0082, y = -2734.3013, z = 20.1693, h = 138.3146}

Config.Ped = { --else change to false
    model = "cs_milton",
    animation = {anim = "mini@strip_club@idles@bouncer@base", dict = "base"},
}

Config.FirstReward = {
    items = { --else change to false
        {item = "water", count = 2},
        {item = "bread", count = 2},
        {item = "phone", count = 1},
    },
    money = { --else change to false
        {account = "money", count = 5000},
        {account = "bank", count = 1000},
    },
    Carname = "akuma", --else change to false
    CarCoordsSpawn = {x = -1029.14, y = -2732.87, z = 20.075, h = 240.1851},
}

Config.EnableCreatorCode = true

Config.CreatorCodes = {
    "apex",
    "zenotic",
    "lion",
}

Config.CreatorRewards = {
    items = { --else change to false
        {item = "water", count = 2},
        {item = "bread", count = 2},
        {item = "phone", count = 1},
    },
    money = { --else change to false
        {account = "money", count = 5000},
        {account = "bank", count = 1000},
    },
    Carname = "akuma", --else change to false
}

function plategenerator()
    return exports['esx_vehicleshop']:GeneratePlate()
end