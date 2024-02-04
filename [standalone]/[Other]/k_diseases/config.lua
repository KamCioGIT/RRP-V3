Config = {}
Config.Variables = {
    Framework = 'QB', -- QB/ESX/None -- set to none to use k_diseases:forceStart trigger instead
    Notify = 'QB', -- QB/ESX/Custom -- custom function below
    ESXSharedObject = 'esx:getSharedObject', -- leave as is for qb(it wont be used)
    SearchForDiseasesTime = 1, -- in mins 0.5 = 30 secs, 1 = 1min, 10 = 10min
    Cooldown = 0.5, -- in mins 0.5 = 30 secs, 1 = 1min, 10 = 10min
    CycleTime = 5000, -- in MS, 5000 = 5 secs (time between disease effects)
    useBuiltInSearch = true, -- Use sickness inducers from the function  Search() at line 366
    UseCommands = false, -- Enable /useMed  exmaple: (/useMed tylenol)
    Debug = false, -- Enable  /sickness (for restarting the script to test) /getS Use to give yourself a disease (/getS "Common Cold") /removeS removes a disease (/removeS "Common Cold") /removeAllS removes all diseases
    useMedCommand = 'useMed'
}


-- This system works with SexV you can get it here! https://kbase.tebex.io/
--** NOTE WHEN CHANGING/ADDING NEW DISEASES YOU WILL HAVE TO REMOVE/WIPE SICKNESS DATA FROM DB**--
Config.Diseases = {
    ['Common Cold'] = {
        hasDiseases = true,
        iterations = 15,
    },

    ['Bad Stomach'] = {
        hasDiseases = true,
        iterations = 15,
    },

    ['Diarrhea'] = {
        hasDiseases = true,
        iterations = 10,
        chance = 50
    },

    ['Headache'] = {
        hasDiseases = true,
        iterations = 10,
    },

    ['Dizzy'] = {
        hasDiseases = true,
        iterations = 10,
    },

    ['Covid'] = {
        hasDiseases = true,
        iterations = 100,
    },

    -------Only if using SexV---------
    ['Chlamydia'] = {
        hasDiseases = false,
        iterations = 10,
    },
    ['Gonorrhea'] = {
        hasDiseases = false,
        iterations = 10,
    },
    ['Herpes'] = {
        hasDiseases = false,
        iterations = 10,
    }
}


--[[ ##EXAMPLE Disease YOU WILL NEED TO WIPE player_sickness AFTER ADDING NEW DISEASES

    ['Scary'] = {
        hasDiseases = false,
        iterations = 10, 
    }

    ['Scary'] = {
        animation = {dict = "missprologueig_5@cough", anim = "walk", time = 2000}, --set animation = false for no anim
        walk = false, --set walk = false for no walk, set time to false for infinite
        deplete = true, -- Depletes from set iterations (once iterations are done the player gets cured) 
        catchNotify = "You caught a Common Cold",  -- or false
        notify = false, -- Everytime effects happen
        spreadData = {range = 2.0, chance=50}, -- Chance to spread in % (50 = 50%, 100 = 100%)
        sound = {
            male = 'sneeze', female = 'sneezefemale', range = 3.0, volume = 0.5, sourceonly = false
        }, -- or false
        medication = {
            'tylenol',
        }, -- or false
        Effects = { -- Effects in MS
            hurt = {damage = 5}, -- or false
            blur = {transitionIn = 1000, transitionOut = 1000}, -- set to blur = false to disable blur
            screenEffect = {effectName="DanceIntensity03", duration=5000}, --or false
            ragdoll = {delaybefore = 750, time = 1000, type = 0}, -- or false
            sickpfx = true, -- or false
            affectDriving = {time = 10}, -- or false
        }
    },
]]

Config.SicknessEffects = { -- times should be should be less than CycleTime
    ['Common Cold'] = {
        animation = {dict = "missprologueig_5@cough", anim = "walk", time = 2000}, --set animation = false for no anim
        walk = false, --set walk = false for no walk, set time to false for infinite
        deplete = true, -- Depletes from set iterations (once iterations are done the player gets cured) 
        catchNotify = "You caught a Common Cold",
        notify = false, -- Everytime effects happen
        spreadData = {range = 2.0, chance=75}, -- Chance to spread in % (50 = 50%, 100 = 100%)
        sound = {
            male = 'sneeze', female = 'sneezefemale', range = 4.0, volume = 0.5, sourceonly = false
        },
        medication = {
            'tylenol',
        },
        Effects = { -- Effects in MS
            hurt = false , --{damage = 5}
            blur = {transitionIn = 1000, transitionOut = 1000}, -- set to blur = false to disable blur
            screenEffect = false,
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = false,
            affectDriving = {time = 10}, 
        }
    },

    ['Bad Stomach'] = {
        animation = {dict = "missexile3", anim = "ex03_train_roof_idle", time = 5000}, --set animation = false for no anim
        walk = {style = "MOVE_M@DRUNK@VERYDRUNK", time=10000}, --set walk = false for no walk, set time to false for infinite
        deplete = true, -- Depletes from set iterations (once iterations are done the player gets cured)
        catchNotify = false,
        notify = false,
        sound = false,
        spreadData = {range = 1.2, chance=25},
        medication = {
            'peptobismol',
        },
        Effects = { -- Effects are in ms, 1000 = 1 sec
            hurt = {damage = 1} , --{damage = 5}
            blur = false, -- set to blur = false to disable blur
            screenEffect = false,
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = true,
            affectDriving = false,
        }
    },

    ['Diarrhea'] = {
        animation = {dict = "missfbi3ig_0", anim = "shit_loop_trev", time = 5000}, --set animation = false for no anim
        walk = {style = "MOVE_M@DRUNK@VERYDRUNK", time=5000}, --set walk = false for no walk, set time to false for infinite
        deplete = true, -- Depletes from set iterations (once iterations are done the player gets cured)
        catchNotify = false,
        notify = 'You almost shit yourself.',
        sound = false,
        spreadData = {range = 1.2, chance=25},
        medication = {
            'loperamide',
        },
        Effects = { -- Effects are in ms, 1000 = 1 sec
            hurt = {damage = 1} , --{damage = 5}
            screenEffect = false,
            blur = false, -- set to blur = false to disable blur
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = false,
            affectDriving = false,
        }
    },

    ['Headache'] = {
        animation = false, --set animation = false for no anim
        walk = false, --set walk = false for no walk, set time to false for infinite
        deplete = true, -- Depletes from set iterations (once iterations are done the player gets cured)
        catchNotify = false,
        notify = false,
        sound = false,
        spreadData = false,
        medication = {
            'aspirin',
            'ibuprofen',  
        },
        Effects = { -- Effects in MS
            hurt = false , --{damage = 5}
            blur = false, -- set to blur = false to disable blur
            screenEffect = {effectName="DanceIntensity03", duration=5000},
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = false,
            affectDriving = false,
        }
    },

    ['Dizzy'] = {
        animation = false, --set animation = false for no anim
        walk = false, --set walk = false for no walk, set time to false for infinite
        deplete = true, -- Depletes from set iterations (once iterations are done the player gets cured)
        catchNotify = "You begin to feel dizzy",
        notify = false,
        sound = false,
        spreadData = false,
        medication = {
            'dramamine',
        },
        Effects = { -- Effects in MS
            hurt = false , --{damage = 5}
            blur = false, -- set to blur = false to disable blur
            screenEffect = {effectName="DrugsDrivingOut", duration=5000},
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = false,
            affectDriving = false,
        }
    },

    ['Covid'] = {
        animation = {dict = "timetable@gardener@smoking_joint", anim = "idle_cough", time = 2000}, --set animation = false for no anim
        walk = {style = "MOVE_M@DRUNK@VERYDRUNK", time=1000}, --set walk = false for no walk, set time to false for infinite
        deplete = true, -- Depletes from set iterations (once iterations are done the player gets cured)
        spreadData = {range = 2.0, chance=90},
        notify = 'It hurt\'s to breath',
        catchNotify = "You caught Covid",
        sound = {male = 'cough', female = 'coughfemale', range = 4.0, volume = 0.5, sourceonly = false},
        medication = {
            'covidvaccine',
        },
        Effects = { -- Effects in MS
            hurt = {damage = 4}, --{damage = 5}
            blur = false, -- set to blur = false to disable blur
            screenEffect = false,
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = false,
            affectDriving = false,
        }
    },

    -------Only if using SexV you can get it here https://kbase.tebex.io/ ---------
    ['Chlamydia'] = {
        animation = false, --set animation = false for no anim
        walk = false, --set walk = false for no walk, set time to false for infinite

        deplete = false, -- Depletes from set iterations (once iterations are done the player gets cured)
        catchNotify = false,
        notify = false,
        sound = false,
        spreadData = false,
        medication = {
            'doxycycline',
            'azithromycin'
        },
        Effects = { -- Effects in MS
            hurt = {damage = 2} , --{damage = 5}
            blur = false, -- set to blur = false to disable blur
            screenEffect = {effectName="CarDamageHit", duration=1000},
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = false,
            affectDriving = false,
        }
    },
    ['Gonorrhea'] = {
        animation = false, --set animation = false for no anim
        walk = false, --set walk = false for no walk, set time to false for infinite
        deplete = false, -- Depletes from set iterations (once iterations are done the player gets cured)
        catchNotify = false,
        notify = false,
        sound = false,
        spreadData = false,
        medication = {
            'azithromycin',
        },
        Effects = { -- Effects in MS
            hurt = {damage = 2} , --{damage = 5}
            blur = false, -- set to blur = false to disable blur
            screenEffect = {effectName="CarDamageHit", duration=1000},
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = false,
            affectDriving = false,
        }
    },
    ['Herpes'] = { 
        animation = false, --set animation = false for no anim
        walk = false, --set walk = false for no walk, set time to false for infinite
        deplete = false, -- Depletes from set iterations (once iterations are done the player gets cured)
        catchNotify = false,
        notify = false,
        sound = false,
        spreadData = false,
        medication = {
            'acyclovir',
        },
        Effects = { -- Effects in MS
            hurt = {damage = 2} , --{damage = 5}
            blur = false, -- set to blur = false to disable blur
            screenEffect = {effectName="CarDamageHit", duration=1000},
            ragdoll = false, -- {delaybefore = 750, time = 1000, type = 0}
            sickpfx = false,
            affectDriving = false,
        }
    }
    -------Only if using SexV you can get it here https://kbase.tebex.io/ ---------
}


Config.Medication = {
    'tylenol',
    'peptobismol',
    'loperamide',
    'aspirin',
    'ibuprofen', 
    'dramamine',
    'covidvaccine',
    'doxycycline',
    'azithromycin',
    'acyclovir',
}




if not IsDuplicityVersion() then --Client Side
    function Notify(text, type)
        print(text)
        --custom code for a custom notify
    end

    function OnEffect(type)
        --print(type)
    end

    function CanPedDoAnim()
        if K.CheckDead() then
            return false
        end
        return true
    end

    RegisterCommand('getPlayerSickness', function()
        local closestPlayer, closestDistance, closestPlayerPed = K.GetClosestPlayer()
        if closestDistance < 2.0 then
            TriggerServerEvent("k_diseases:getSicknessFromPlayer", closestPlayer) 
        else
            K.NotifyFramework('No one nearby.', 'error')
        end
    end)
    

    function CanBeInfectedByOthers() -- This calls for a return on a percent (25 = 25% chance to be infected, 100 = 100% chance to be infected)
        local hasMask, maskId = K.IsPlayerWearingMask() -- gets the player and if they are wearing a mask
        --[[ Example on how you could setup certain masks to have certain resistance 
            if maskId == 5 then
                return 0 -- plauyer will have 0 chance to get infected
            end
        
        ]]

        if hasMask then
            return 5 -- if the player is wearing a mask they have an increased tolerance to getting infected by others (5% chance of getting infected)
        end
        
        return 100 -- 100 means they have no protection
    end

    function BeforeSickEffects()
        -- Just before sick effects happen
    end

    function AfterSickEffects()
        -- after sick effects
    end

    function CanInfectOthers() -- This calls for a return on a percent (25 = 25% chance to infect other players, 100 = 100% chance to infect other players)
        local hasMask, maskId = K.IsPlayerWearingMask() -- gets the player and if they are wearing a mask

        --[[ Example on how you could setup certain masks to have certain resistance 
            if maskId == 5 then
                return 0 -- plauyer will have 0 chance to infect others
            end
        
        ]]

        if hasMask then
            return 5 -- 25 means the player has a 25% chance to infect other players if they have a mask  (this wont effect spreadData this is just a 2nd check for masks) 
        end
        
        return 100 -- 100 means they will always infect other players (this wont effect spreadData this is just a 2nd check for masks) 
    end

    function NotifyClear(type)
        K.NotifyFramework('Your '..type..' seems to have gone away.', 'success')
    end

    function Search() -- Example on how the player could get a illness. 


        if GetRainLevel() >= 0.3 and GetInteriorFromEntity == 0 and not IsPedInAnyVehicle(PlayerPedId(), false) then -- best way i could find to simulate a cold method
            exports['k_diseases']:CatchDisease("Common Cold", 25, true)  --  exports['k_diseases']:CatchDisease(TYPE, CHANCE, CHECKIFALREADYHASIT)
            exports['k_diseases']:CatchDisease("Covid", 5, true)
            exports['k_diseases']:CatchDisease("Headache", 25, true)
        end

    end
    

else
    function DropExploiter(src)
        DropPlayer(src, 'stinky cheetor')
    end
end


function GetCore()
    if not IsDuplicityVersion() then -- Client side
        if Config.Variables.Framework == 'QB' then
            return exports['qb-core']:GetCoreObject()
        elseif Config.Variables.Framework == 'ESX' then
            local ESX = nil
            Citizen.CreateThread(function()
                while ESX == nil do
                    TriggerEvent(Config.Variables.ESXSharedObject, function(obj) return obj end)
                    Wait(0)
                end
            end)
        end

    else -- Server side
        print('^3Thanks for using my script :) Need assistance support at ^5discord.gg/y6RtPVwkXq ^7')
        if Config.Variables.Framework == 'QB' then
            return exports['qb-core']:GetCoreObject()
        elseif Config.Variables.Framework == 'ESX' then
            local ESX = nil
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            return ESX
        end
    end
    return false
end
