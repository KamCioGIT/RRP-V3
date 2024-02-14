function AddEntityToTargeting(entity, hash, message, event, key, canInteract)
    if (Config.target.enabled and Config.target.system) then
        
        local system = Config.target.system
        
        local options = {
            {
                type = 'client',
                event = event,
                icon = 'fas fa-box',
                label = message,
                key = key,
                canInteract = canInteract or function () return true end
            }
        }
        
        if system == 'ox-target' or system == 'ox_target' then
            exports[system]:addLocalEntity({entity}, options)
        else
            exports[system]:AddEntityZone(hash, entity, {
                name = hash,
                debugPoly = false,
                useZ = true,
            }, {
                options = options,
                distance = 2.0
            })
        end
    end
end

RegisterNetEvent('kq_materialize:target:pickup')
AddEventHandler('kq_materialize:target:pickup', function(data)
    if DoesEntityExist(data.entity) then
        PickupObject(data.entity)
    end
end)
