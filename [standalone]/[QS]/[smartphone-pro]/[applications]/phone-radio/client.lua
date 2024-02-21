while GetResourceState('qs-smartphone-pro') ~= 'started' do
    Wait(500)
end

local ui = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/html/'

local function addApp()
    local added = exports['qs-smartphone-pro']:addCustomApp({
        app = 'radio',
        image = ui .. 'icon.png',
        ui = ui .. 'index.html',
        -- ui = ui .. 'index.html',
        label = 'Radio',
        job = false,
        blockedJobs = {},
        timeout = 5500,
        creator = 'Quasar Store',
        category = 'social',
        isGame = false,
        description = 'Contact other people through frequencies',
        age = '16+',
        extraDescription = {
            {
                header = 'Radio',
                head = 'Frequencies at your fingertips',
                image = 'https://media.discordapp.net/attachments/1166657197263036428/1203792713296773120/Sin_titulo-1.png?ex=65d26254&is=65bfed54&hm=31eb6d993484d478e226ebe968fa54e80e56c8a099a373f241a27ba494006f1d&=&format=webp&quality=lossless',
                footer = 'Contact other people through frequencies'
            }
        }
    })
    if not added then
        return print('Failed to add app')
    end
    print('App added')
end

CreateThread(addApp)

AddEventHandler('onResourceStart', function(resource)
    if resource == 'qs-smartphone-pro' then
        addApp()
    end
end)
