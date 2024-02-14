---
print("---                Horizon Speedometer                ---")
print("---          Created by: Horizon Development          ---")
---

local ind = {l = false, r = false}
local shutdown = false
local hud = false
local hudShown = false
local isUiOpen = false 
local speedBuffer = {}
local velBuffer = {}
local SeatbeltON = false
local InVehicle = false
local CruisedSpeed, CruisedSpeedKm, VehicleVectorY = 0, 0, 0

Citizen.CreateThread(function()
  TriggerEvent("horizon_speedometer:setDate")
  while true do
    Citizen.Wait(1000)
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
      if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
        hud = true
        if not hudShown then
          hudShown = true
          TriggerEvent("horizon_speedometer:setHud")
          TriggerEvent("horizon_speedometer:setSeatbelt")
          TriggerEvent("horizon_speedometer:setSeatbeltAlert")
          TriggerEvent("horizon_speedometer:setIcons")
          TriggerEvent("horizon_speedometer:indicatorControl")
          TriggerEvent("horizon_speedometer:setHandbrakeIcon")
          TriggerEvent("horizon_speedometer:setCruiseControl")
          TriggerEvent("horizon_speedometer:setDoorIcon")
          Citizen.Wait(100)
        end
      elseif PedCar then 
        if GetPedInVehicleSeat(PedCar, 0) == Ped or GetPedInVehicleSeat(PedCar, 1) == Ped or GetPedInVehicleSeat(PedCar, 2) == Ped or GetPedInVehicleSeat(PedCar, 4) == Ped or GetPedInVehicleSeat(PedCar, 5) == Ped or GetPedInVehicleSeat(PedCar, 6) == Ped then
          hud = true
          if not hudShown then
            hudShown = true
            TriggerEvent("horizon_speedometer:setSeatbelt")
          end
        end
      elseif not Pedcar then
          hud = false
          hudShown = false
          SendNUIMessage({
            showhud = false
          })
          Citizen.Wait(100)
      end
    else
      hud = false
      hudShown = false
      SendNUIMessage({
				showhud = false
			})
      Citizen.Wait(1000)
    end
  end
end)

RegisterNetEvent("horizon_speedometer:setHud")
AddEventHandler("horizon_speedometer:setHud", function()
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
        if Config.MeasurementSystem == "kph" then
				  carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
        elseif Config.MeasurementSystem == "mph" then
          carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6 / 1.609)
        end
				if GetVehicleEngineHealth(PedCar) <= 150 then
					shutdown = true
					SendNUIMessage({
						shutdown = true
					})
				else
					shutdown = false
				end
				if IsVehicleEngineOn(PedCar) and not shutdown then
            if Config.MeasurementSystem == "kph" then
						  SendNUIMessage({
							  showhud = true,
							  speed = carSpeed,
                measurementSystem = "kph"
						  })
            elseif Config.MeasurementSystem == "mph" then
              SendNUIMessage({
							  showhud = true,
							  speed = carSpeed,
                measurementSystem = "mph"
						  })
            end
				elseif not IsVehicleEngineOn(PedCar) or shutdown then
					SendNUIMessage({
						showhud = "partial",
						speed = carSpeed
					})
				end

				_,feuPosition,feuRoute = GetVehicleLightsState(PedCar)
				if(feuPosition == 1 and feuRoute == 0) then
					SendNUIMessage({
						feuPosition = true
					})
				else
					SendNUIMessage({
						feuPosition = false
					})
				end
				if(feuPosition == 1 and feuRoute == 1) then
					SendNUIMessage({
						feuRoute = true
					})
				else
					SendNUIMessage({
						feuRoute = false
					})
				end

				local VehIndicatorLight = GetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()))
				
				if(VehIndicatorLight == 0) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 1) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 2) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = true,
					})
				elseif(VehIndicatorLight == 3) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = true,
					})
				end

        currentGear = GetVehicleCurrentGear(PedCar)
        if currentGear == 0 then
          currentGear = "R"
        end
        if math.ceil(GetEntitySpeed(PedCar) * 3.6) == 0 then
          currentGear = "N"
        end
        SendNUIMessage({
          showgear = true,
          gearlvl = currentGear,
        })

			else
				SendNUIMessage({
					showhud = false
				})
			end
		else
			SendNUIMessage({
				showhud = false
			})
		end
    if not hud then
      break
      hudShown = false
    end
		Citizen.Wait(50)
	end
end)

RegisterNetEvent("horizon_speedometer:indicatorControl")
AddEventHandler("horizon_speedometer:indicatorControl", function()
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
        if IsControlJustPressed(1, 175) then -- Right Arrow is pressed
          ind.l = not ind.l
          SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 0, ind.l)
          SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1, 0)
        end
        if IsControlJustPressed(1, 174) then -- Left Arrow is pressed
          ind.r = not ind.r
          SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1, ind.r)
          SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 0, 0)
        end
        if IsControlJustPressed(1, 173) then -- Arrow Down is pressed
          if hazardWarning then
            hazardWarningIcon(false)
            hazardWarning = false
          else
            hazardWarningIcon(true)
            hazardWarning = true
          end
          ind.r = not ind.r
          ind.l = not ind.l
          SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 0, ind.r)
          SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1, ind.l)
        end
      end
    end
    if not hud then
      break
      hudShown = false
    end
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				fuel = GetVehicleFuelLevel(PedCar)
				rpm = GetVehicleCurrentRpm(PedCar)
				rpmfuel = 0

				if rpm > 0.9 then
					rpmfuel = fuel - rpm / 4.0
					Citizen.Wait(1000)
				elseif rpm > 0.8 then
					rpmfuel = fuel - rpm / 5.1
					Citizen.Wait(1500)
				elseif rpm > 0.7 then
					rpmfuel = fuel - rpm / 10.2
					Citizen.Wait(2000)
				elseif rpm > 0.6 then
					rpmfuel = fuel - rpm / 20.1
					Citizen.Wait(3000)
				elseif rpm > 0.5 then
					rpmfuel = fuel - rpm / 25.7
					Citizen.Wait(4000)
				elseif rpm > 0.4 then
					rpmfuel = fuel - rpm / 30.4
					Citizen.Wait(5000)
				elseif rpm > 0.3 then
					rpmfuel = fuel - rpm / 30.9
					Citizen.Wait(6000)
				elseif rpm > 0.2 then
					rpmfuel = fuel - rpm / 35.3
					Citizen.Wait(8000)
				else
					rpmfuel = fuel - rpm / 35.5
					Citizen.Wait(15000)
				end

				carFuel = SetVehicleFuelLevel(PedCar, rpmfuel)

				SendNUIMessage({
			showfuel = true,
					fuel = fuel
				})
			end
		end

    if not hud then
      break
      hudShown = false
    end

		Citizen.Wait(1)
	end
end)

AddEventHandler('horizon_speedometer:sounds', function(soundFile, soundVolume)
  SendNUIMessage({
    transactionType = 'playSound',
    transactionFile = soundFile,
    transactionVolume = soundVolume
  })
end)

RegisterNetEvent("horizon_speedometer:setSeatbelt")
AddEventHandler("horizon_speedometer:setSeatbelt", function()
while true do
	Citizen.Wait(0)
  
    local ped = PlayerPedId()
    local car = GetVehiclePedIsIn(ped)

    if car ~= 0 and (InVehicle or IsCar(car)) then
      InVehicle = true
          if isUiOpen == false and not IsPlayerDead(PlayerId()) then
              isUiOpen = true
          end

      if SeatbeltON then 
        DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
        DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
	    end

      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)

      if not SeatbeltON and speedBuffer[2] ~= nil and GetEntitySpeedVector(car, true).y > 1.0 and speedBuffer[1] > (Config.Speed / 3.6) and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
        local co = GetEntityCoords(ped)
        local fw = Fwv(ped)
        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
        Citizen.Wait(1)
        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
      end
        
      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)
      if IsControlJustReleased(0, Config.SeatBeltKey) and GetLastInputMethod(0) then
          SeatbeltON = not SeatbeltON 
          if SeatbeltON then
          Citizen.Wait(1)

            if Config.Sounds then  
            TriggerEvent("horizon_speedometer:sounds", "buckle", Config.Volume)
            end
            if Config.Notification then
            exports.pNotify:SendNotification(
              {
                text = "Seat Belt attached.",
                type = "success",
                timeout = 3000,
                layout = "topCenter",
              }
            )
            end
            
            isUiOpen = true 
          else 
            if Config.Notification then
            exports.pNotify:SendNotification(
              {
                text = "Seat Belt detached.",
                type = "error",
                timeout = 3000,
                layout = "topCenter",
              }
            )
            end

            if Config.Sounds then
            TriggerEvent("horizon_speedometer:sounds", "unbuckle", Config.Volume)
            end

            isUiOpen = true  
          end
    end
    
    elseif InVehicle then
      InVehicle = false
      SeatbeltON = false
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
          if isUiOpen == true and not IsPlayerDead(PlayerId()) then
            isUiOpen = false 
          end
    end
    if not hud then
      break
      hudShown = false
    end
  end
end)

RegisterNetEvent("horizon_speedometer:setSeatbeltAlert")
AddEventHandler("horizon_speedometer:setSeatbeltAlert", function()
  while true do
    Citizen.Wait(0)
	  local ped = PlayerPedId()
    local Vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if GetPedInVehicleSeat(Vehicle, -1) == ped then
    local VehSpeed = GetEntitySpeed(Vehicle) * 3.6

    if Config.AlarmOnlySpeed and VehSpeed > Config.AlarmSpeed then
      ShowWindow = true
    else
      ShowWindow = false
      SendNUIMessage({seatbeltIcon = 'false'})
    end

      if IsPlayerDead(PlayerId()) or IsPauseMenuActive() then
        if isUiOpen == true then
          SendNUIMessage({seatbeltIcon = 'false'})
        end
        elseif not SeatbeltON and InVehicle and not IsPauseMenuActive() and not IsPlayerDead(PlayerId()) then
          if Config.AlarmOnlySpeed and ShowWindow and VehSpeed > Config.AlarmSpeed then
            SendNUIMessage({seatbeltIcon = true})
          end
      end
    end
    if not hud then
      break
      hudShown = false
    end
  end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3500)
    if not SeatbeltON and InVehicle and not IsPauseMenuActive() and Config.LoopSound and ShowWindow then
      TriggerEvent("horizon_speedometer:sounds", "seatbelt", Config.Volume)
		end    
	end
end)

RegisterNetEvent("horizon_speedometer:setIcons")
AddEventHandler("horizon_speedometer:setIcons", function()
  while true do
    Citizen.Wait(3500)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if GetPedInVehicleSeat(vehicle, -1) == ped then 
      if GetVehicleFuelLevel(vehicle) < 25 then
        if not alert then
        TriggerEvent("horizon_speedometer:sounds", "seatbelt", Config.Volume)
        fuelIcon(true)
        alert = true
        end
      else 
        alert = false
        fuelIcon(false)
      end

      if IsVehicleTyreBurst(vehicle, 5, false) or IsVehicleTyreBurst(vehicle, 4, false) or IsVehicleTyreBurst(vehicle, 1, false) or IsVehicleTyreBurst(vehicle, 0, false) then
        TriggerEvent("horizon_speedometer:sounds", "seatbelt", Config.Volume)
        tyreIcon(true)
      else 
        tyreIcon(false)
      end

      if GetVehicleEngineHealth(vehicle) < 350 then
        TriggerEvent("horizon_speedometer:sounds", "seatbelt", Config.Volume)
        engineIcon(true)
      else 
        engineIcon(false)
      end

      if GetVehicleDoorLockStatus(vehicle) == 1 or GetVehicleDoorLockStatus(vehicle) == 0 then
        if GetEntitySpeed(vehicle) * 3.6 >= 30.00 and Config.AutoDoorLock then
          PlayVehicleDoorCloseSound(vehicle, 0)
          SetVehicleDoorsLocked(vehicle, 2)
          lockIcon(true)
        end
      elseif GetVehicleDoorLockStatus(vehicle) == 2 then
        lockIcon(true)
      end

      if GetVehicleDoorLockStatus(vehicle) == 1 or GetVehicleDoorLockStatus(vehicle) == 0 then
        lockIcon(false)
      end

      if not hud then
        break
        hudShown = false
      end
    end

    if not hud then
      break
      hudShown = false
    end

  end
end)

RegisterNetEvent("horizon_speedometer:setDoorIcon")
AddEventHandler("horizon_speedometer:setDoorIcon", function()
  while true do
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 or GetVehicleDoorAngleRatio(vehicle, 1) > 0.0 or GetVehicleDoorAngleRatio(vehicle, 2) > 0.0 or GetVehicleDoorAngleRatio(vehicle, 3) > 0.0 or GetVehicleDoorAngleRatio(vehicle, 4) > 0.0 or GetVehicleDoorAngleRatio(vehicle, 5) > 0.0 then
      local VehSpeed = GetEntitySpeed(vehicle) * 3.6
      doorIcon(true)
      if Config.AutoDoorLock then
        SetVehicleDoorsLocked(vehicle, 1)
        lockIcon(false)
      end
      if Config.AlarmOnlySpeed and VehSpeed > Config.AlarmSpeed then
        TriggerEvent("horizon_speedometer:sounds", "seatbelt", Config.Volume)
      end
    else
      doorIcon(false)
    end

    if not hud then
      break
      hudShown = false
    end

    Citizen.Wait(100)
  end
end)

RegisterNetEvent("horizon_speedometer:setHandbrakeIcon")
AddEventHandler("horizon_speedometer:setHandbrakeIcon", function()
  while true do
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if GetPedInVehicleSeat(vehicle, -1) == ped then 
      if GetVehicleHandbrake(vehicle) then
        handbrakeIcon(true)
      else 
        handbrakeIcon(false)
      end
    end

    if not hud then
      break
      hudShown = false
    end
    
    Citizen.Wait(100)
  end
end)

RegisterNetEvent("horizon_speedometer:setCruiseControl")
AddEventHandler("horizon_speedometer:setCruiseControl", function()
  while true do
		Wait(0)
		if IsControlJustPressed(1, Config.CruiseControlKey) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
			Player = PlayerPedId()
			TriggerCruiseControl()
		end
    if not hud then
      break
      hudShown = false
    end
	end
end)

RegisterNetEvent("horizon_speedometer:cruiseControl")
AddEventHandler("horizon_speedometer:cruiseControl", function()
  while GetPedInVehicleSeat(GetVehiclePedIsIn(Player, false), -1) == Player do
    Citizen.Wait(0)
    if CruisedSpeedKm > Config.CruiseSpeedMin then
      if not IsTurningOrHandBraking() and GetVehicleSpeed() < (CruisedSpeed - 1.5) then
        CruisedSpeed = 0
        if Config.Notification then
          exports.pNotify:SendNotification(
            {
              text = "Cruise control deactivated.",
              type = "error",
              timeout = 3000,
              layout = "topCenter",
            }
          )
        end
        SendNUIMessage({
          type = "blinkingAnimation",
          status = false,
      })
        Wait(2000)
        break
      end
  
      if not IsTurningOrHandBraking() and IsVehicleOnAllWheels(GetVehiclePedIsIn(Player, false)) and GetVehicleSpeed() < CruisedSpeed then
        SetVehicleForwardSpeed(GetVehiclePedIsIn(Player, false), CruisedSpeed)
      end
  
      if IsControlJustPressed(1, 246) then
        CruisedSpeed = GetVehicleSpeed()
        CruisedSpeedKm = TransformToKm(CruisedSpeed)
      end
  
      if IsControlJustPressed(2, 72) then
        CruisedSpeed = 0
        if Config.Notification then
          exports.pNotify:SendNotification(
            {
              text = "Cruise control deactivated.",
              type = "error",
              timeout = 3000,
              layout = "topCenter",
            }
          )
        end
        SendNUIMessage({
          type = "blinkingAnimation",
          status = false,
      })
        Wait(2000)
        break
      end
    else
      break
    end
  end
end)

RegisterNetEvent("horizon_speedometer:setDate")
AddEventHandler("horizon_speedometer:setDate", function()
	while true do
		if not shutdown then
			SendNUIMessage({
				date = true
			})
		end
		Citizen.Wait(30000)
	end
end)

function TriggerCruiseControl ()
	if CruisedSpeed == 0 and IsPedInAnyVehicle(Player, false) then
		if GetVehicleCurrentGear(GetVehiclePedIsIn(Player, false)) > 0 then
      if TransformToKm(GetVehicleSpeed()) > Config.CruiseSpeedMin then 
        CruisedSpeed = GetVehicleSpeed()
        CruisedSpeedKm = TransformToKm(CruisedSpeed)
        if Config.Notification then
          if Config.MeasurementSystem == "kph" then
            exports.pNotify:SendNotification(
              {
                text = "Cruise control set: "..CruisedSpeedKm.. " kph.",
                type = "success",
                timeout = 3000,
                layout = "topCenter",
              }
            )
          elseif Config.MeasurementSystem == "mph" then
            exports.pNotify:SendNotification(
              {
                text = "Cruise control set: "..math.ceil(CruisedSpeedKm/1.609).. " mph.",
                type = "success",
                timeout = 3000,
                layout = "topCenter",
              }
            )
          end
        end
        SendNUIMessage({
          type = "blinkingAnimation",
          status = true,
      })
        TriggerEvent("horizon_speedometer:cruiseControl")
      else
        if Config.Notification then
          if Config.MeasurementSystem == "kph" then
            exports.pNotify:SendNotification(
              {
                text = "Cruise control can be activated above " ..Config.CruiseSpeedMin.. " kph.",
                type = "error",
                timeout = 3000,
                layout = "topCenter",
              }
            )
          elseif Config.MeasurementSystem == "mph" then
            exports.pNotify:SendNotification(
              {
                text = "Cruise control can be activated above " ..math.ceil(Config.CruiseSpeedMin/1.609).. " mph.",
                type = "error",
                timeout = 3000,
                layout = "topCenter",
              }
            )
          end
        end
      end
    end
  end
end

function IsCar(veh)
  local vc = GetVehicleClass(veh)
  return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

function Fwv(entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then hr = 360.0 + hr end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

function IsTurningOrHandBraking ()
	return IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64)
end

function GetVehicleSpeed ()
	return GetEntitySpeed(GetVehiclePedIsIn(Player, false))
end

function TransformToKm (speed)
	return math.floor(speed * 3.6 + 0.5)
end

function fuelIcon(bool)
  display = bool
  SendNUIMessage({
      type = "fuelIcon",
      status = bool,
  })
end

function tyreIcon(bool)
  display = bool
  SendNUIMessage({
      type = "tyreIcon",
      status = bool,
  })
end

function engineIcon(bool)
  display = bool
  SendNUIMessage({
      type = "engineIcon",
      status = bool,
  })
end

function handbrakeIcon(bool)
  display = bool
  SendNUIMessage({
      type = "handbrakeIcon",
      status = bool,
  })
end

function doorIcon(bool)
  display = bool
  SendNUIMessage({
      type = "doorIcon",
      status = bool,
  })
end

function lockIcon(bool)
  display = bool
  SendNUIMessage({
      type = "lockIcon",
      status = bool,
  })
end

function hazardWarningIcon(bool)
  display = bool
  SendNUIMessage({
      type = "hazardWarningIcon",
      status = bool,
  })
end