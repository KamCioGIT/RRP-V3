Config = {}

Config.Framework = "QB" -- ESX / QB

Config.SpeedType = "mph" -- mph / kmh

Config.AlternativePlayer = true -- if you want to use alternative player system
-- This feature is currently in testing. 
-- It allows you to listen to some copyrighted music that cannot be played.
-- Also age restricted videos. Turning this feature on is entirely at your own risk!
-- We are not responsible for sanctions against you for listening to copyrighted content! 
Config.DefaultVolume = 0.5

Config.EnableVolumeControl = true

Config.VolumeUpKey = "ADD" -- (numpad plus)

Config.VolumeDownKey = "SUBTRACT" -- (numpad minus)

Config.TemperatureType = "C" -- F / C

Config.OpenKey = "o" 

Config.OpenKeyMini = "n" 

Config.RadarBlip = 40

Config.Icon = "https://docs.fivem.net/blips/radar_centre.png"

Config.ForceAddNeonModKit = true

Config.DisableDefaultGameSeatSwitchSystem = true

Config.DisableDefaultGameRadioSystem = true

Config.SportModeMultiplier = 0.0 --- 0.0 is disable sport mode 

Config.LatencyToleranceForSeek = 1.0 -- you can set for server latency

Config.EnableNotifications = true

Config.UsePlateNumberForMusicPlayer = false --- this setting changes to save netid or plate number for errors that may occur 

Config.Lang = "en"

Config.Langs = {
    ["en"] = {
        ["sportmode_on"] = "Sport Mode Enabled!",
        ["sportmode_off"] = "Sport Mode Disabled!",
        ["neon_on"] = "Neon Lights Enabled!",
        ["neon_off"] = "Neon Lights Disabled!",
        ["ambient_on"] = "Ambient Lights Enabled!",
        ["ambient_off"] = "Ambient Lights Disabled!",
        ["door_open"] = "A door opened!",
        ["door_close"] = "A door closed!",
        ["window_open"] = "A Window opened!",
        ["window_close"] = "A Window closed!",
        ["seatchange"] = "A Seat changed!",
        ["albumlist"] = "Added to your album list!",
        ["albumcreate"] = "Album created!",
        ["addnewtrack"] = "New song added to the album!",
        ["delAlbum"] = "Album deleted!",
    }
}


if GetResourceState('qb-core') ~= 'missing' then
    Config.Framework = 'QBCore'
    QBCore = exports['qb-core']:GetCoreObject()
 else
    Config.Framework = 'ESX'
    ESX = exports["es_extended"]:getSharedObject()
 end
 