local url = "https://raw.githubusercontent.com/Bazsi0513/Fivem-Scripts-Versions/main/horizon_speedometer"
local version = GetResourceMetadata(GetCurrentResourceName(), "version")

PerformHttpRequest(url, function(err, text, headers)
	print("^4Checking for available updates...^0") 
     if (tonumber(text) ~= nil) then
         if tonumber(version) == tonumber(text) then
             print("^2No update available.^0")
         else
             print("^3New update available. Download the latest version from https://keymaster.fivem.net/.^0")
         end
     else
         print("^1Unable to check for updates. If this problem persists, please contact us on Discord.^0")
     end
end, "GET", "", "")