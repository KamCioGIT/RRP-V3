local QBCore = exports['qb-core']:GetCoreObject()
local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/1176633734515130510/h-beHea0UXJy8WMSQ5yWMqX0gT6nlxtdFmX7OTYvjGmAVbeDcj08BgdXCq5cVtFlsJIG',
    ['testwebhook'] = 'https://discord.com/api/webhooks/1176633791259881532/33-DbNVMGGqBlCkhxCOtpri2pf1PJtqJRsBvrfrdBIBnfMeUWPPAPJoAdWaOXvaHAjKk',
    ['playermoney'] = 'https://discord.com/api/webhooks/1176633851276173472/uJpDEflXvRXon3YM4o4XafMWW3tUyB3WQWuGNFjMRqRW3lvBatpsV_xkmCqp_2B-s0P0',
    ['playerinventory'] = 'https://discord.com/api/webhooks/1176633908872355900/vGd7Ndqze3sqdO0z0REFwnP2zW-JkSUQfWO6Ga17pKvTYuoM1tXAE4pDYDtaueiPutaK',
    ['robbing'] = 'https://discord.com/api/webhooks/1176633971598168205/3W9aL4CsFXsdn86HoJfVipVS0RLMpmlqIj3x1M93wcYGuOA9jv2LrjSHV1gIFWRORBEW',
    ['cuffing'] = 'https://discord.com/api/webhooks/1176634464760246272/wD0KZLH2GI-TyDuzJBKoucKyM_XmB8OVkItU6sjWejp_Gg2ssIhw4wXlfgHUs44EPMf7',
    ['drop'] = 'https://discord.com/api/webhooks/1176634536453472348/4WHGjGJG6DKQ9T4h2OgZU_dsfQvyBNDwPmAxPHvaZD5NK-tgbcGR8Xf90rKCeaYAl6lQ',
    ['trunk'] = 'https://discord.com/api/webhooks/1176634608754892870/aJ-E6AI-O6T7Y9JnRCqHTzXq23cypnGk-kD4mkuBH53IMI1j3eVfqwbYLxs3b5dNnDCH',
    ['stash'] = 'https://discord.com/api/webhooks/1176634665327657021/RA1QuxNZA0c3x4dzWPOsxHEMyhFew6p5I8AtAEX_1pAQyr-bFmZdp-kC_6HunErQV8jF',
    ['glovebox'] = 'https://discord.com/api/webhooks/1176634721871085619/UoPktDuViPk-aTlh5LdLWaAzVd_BxtjAJz4NiPtui6KB9dJNT3MD4wiRen7CCaYIzf87',
    ['banking'] = 'https://discord.com/api/webhooks/1176634809070653603/ewRmHGRxBkfdRURBGh_g0tUDuwc1iWM1zIflWKfhaImp6RmcGWcw8Acd4VfKS8u1Iw3T',
    ['vehicleshop'] = '',
    ['vehicleupgrades'] = '',
    ['shops'] = 'https://discord.com/api/webhooks/1176634928587362374/L40ZohLisMt1ZLDuQmIgHJMZo_o5OlgIetNIX03EV5XnIW14hnx7GlSZbUPny4jrl7Oh',
    ['dealers'] = '',
    ['storerobbery'] = '',
    ['bankrobbery'] = '',
    ['powerplants'] = '',
    ['death'] = 'https://discord.com/api/webhooks/1176635021449236631/6kTkcatjShTQhnY3kqyHRIg61rK42aF0futz4dMPmNLtwcQ4ac8DwlTZm5aTKzoJeVZi',
    ['joinleave'] = 'https://discord.com/api/webhooks/1176635078114279524/S00t7tWBoe7ix9juZYCBZQwj1c83CXofxxE2j9U7QUgad0lFMOZrjUTrlIp5saXZWblV',
    ['ooc'] = '',
    ['report'] = '',
    ['me'] = '',
    ['pmelding'] = '',
    ['112'] = '',
    ['bans'] = 'https://discord.com/api/webhooks/1176635197375127602/-E1X5qmSDo22W_PkhDSomffzWa-81I4-xxhNTpnWR6mpW24pTeHDnWcPg5MmEnxxiwS4',
    ['anticheat'] = 'https://discord.com/api/webhooks/1176635197375127602/-E1X5qmSDo22W_PkhDSomffzWa-81I4-xxhNTpnWR6mpW24pTeHDnWcPg5MmEnxxiwS4',
    ['weather'] = '',
    ['moneysafes'] = '',
    ['bennys'] = '',
    ['bossmenu'] = '',
    ['robbery'] = 'https://discord.com/api/webhooks/1176633971598168205/3W9aL4CsFXsdn86HoJfVipVS0RLMpmlqIj3x1M93wcYGuOA9jv2LrjSHV1gIFWRORBEW',
    ['casino'] = '',
    ['traphouse'] = '',
    ['911'] = '',
    ['palert'] = '',
    ['house'] = '',
    ['qbjobs'] = '',
}

local colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}

local logQueue = {}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local postData = {}
    local tag = tagEveryone or false
    if not Webhooks[name] then print('Tried to call a log that isn\'t configured with the name of ' ..name) return end
    local webHook = Webhooks[name] ~= '' and Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = colors[color] or colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'QBCore Logs',
                ['icon_url'] = 'https://raw.githubusercontent.com/GhzGarage/qb-media-kit/main/Display%20Pictures/Logo%20-%20Display%20Picture%20-%20Stylized%20-%20Red.png',
            },
        }
    }

    if not logQueue[name] then logQueue[name] = {} end
    logQueue[name][#logQueue[name] + 1] = {webhook = webHook, data = embedData}

    if #logQueue[name] >= 10 then
        if tag then
            postData = {username = 'QB Logs', content = '@everyone', embeds = {}}
        else
            postData = {username = 'QB Logs', embeds = {}}
        end
        for i = 1, #logQueue[name] do postData.embeds[#postData.embeds + 1] = logQueue[name][i].data[1] end
        PerformHttpRequest(logQueue[name][1].webhook, function() end, 'POST', json.encode(postData), { ['Content-Type'] = 'application/json' })
        logQueue[name] = {}
    end
end)

Citizen.CreateThread(function()
    local timer = 0
    while true do
        Wait(1000)
        timer = timer + 1
        if timer >= 60 then -- If 60 seconds have passed, post the logs
            timer = 0
            for name, queue in pairs(logQueue) do
                if #queue > 0 then
                    local postData = {username = 'QB Logs', embeds = {}}
                    for i = 1, #queue do
                        postData.embeds[#postData.embeds + 1] = queue[i].data[1]
                    end
                    PerformHttpRequest(queue[1].webhook, function() end, 'POST', json.encode(postData), {['Content-Type'] = 'application/json'})
                    logQueue[name] = {}
                end
            end
        end
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')