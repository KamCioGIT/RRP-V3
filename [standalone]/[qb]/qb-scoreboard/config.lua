Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 'HOME' -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

Config.Toggle = false -- If this is false the scoreboard stays open only when you hold the OpenKey button, if this is true the scoreboard will be openned and closed with the OpenKey button

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- It returns 48 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["bankrobbery"] = {
        minimumPolice = 3,
        busy = false,
        label = "Bank Robbery"
    },
    ["jewellery"] = {
        minimumPolice = 2,
        busy = false,
        label = "Jewellery"
    },
    ["pacific"] = {
        minimumPolice = 5,
        busy = false,
        label = "Pacific Bank"
    },
    ["paleto"] = {
        minimumPolice = 4,
        busy = false,
        label = "Paleto Bay Bank"
    },
    ["playerrob"] = {
        minimumPolice = 2,
        busy = false,
        label = "Robbing/Kidknapping Players"
    },
    ["policerob"] = {
        minimumPolice = 3,
        busy = false,
        label = "Robbing/Kidknapping Police"
    }
}

-- Show ID's for all players or Opted in Staff
Config.ShowIDforALL = true
