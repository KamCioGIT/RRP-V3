CodeStudio = {}


CodeStudio.useTaxi = false          --Use AI Taxi or Not?
CodeStudio.SpawnPedLoc = vector3(800.29, -3006.02, -69.00)    --If not using AI Taxi then set player spawn location 

CodeStudio.Taxi = `dynasty`                                     --Taxi Model
CodeStudio.TaxiPlate = 'CS5M'                              --Taxi Number Plate
CodeStudio.TaxiModded = true
CodeStudio.TaxiSpawn = vector4(-1058.48, -2713.28, 20.17, 240.05)       --Taxi First Spawn Location   
CodeStudio.TaxiDestination = vector4(-1087.01, -271.25, 37.32, 26.0)         --Taxi Destination Lcoation 
CodeStudio.SkipToNearestLoc = vector4(-1198.92, -304.74, 37.47, 284.08)       --Taxi Skip Nearest Location to destination



CodeStudio.WelcomeMessage = 'Welocome To Real Roleplay'
CodeStudio.ReachedMessage = "Please Select A Vehicle To Jump Start Your Roleplay Experience"




function Notify(msg)
    SetNotificationTextEntry('STRING') --- DELETE ME IF YOU ARE USING ANOTHER SYSTEM
    AddTextComponentString(msg)  --- DELETE ME IF YOU ARE USING ANOTHER SYSTEM
    DrawNotification(0,1)  --- DELETE ME IF YOU ARE USING ANOTHER SYSTEM
end