Hello, thanks for purchasing my script!
`All support is done via my discord at discord.gg/y6RtPVwkXq`
Here is a setup guide to get everything working!

##### ::::::::::::::::::::::::::::

Step #1:
`Add k_diseases to your server's resources folder`

Step #2:
`Add the following to the bottom of your server.cfg`

ensure k_diseases

Step 3:
`Add the images from k_diseases/itemimages to your inventory!`

Step 4:
`ESX: Import the SQL or OX items from k_diseases\setup\items`
`QB: Add the items to qb-core/shared/items.lua from k_diseases\setup\items\qbitems.txt`
`Standalone: Skip this step.`

Step 5:
`Pick prefered framework in config.lua (for standalone put None)`

Step 6:
`Run the SQL file from k_diseases\setup\sql and make sure it creates a database table called "player_sickness"`

Step 7:
`Download https://github.com/plunkettscott/interact-sound and start it in your server.cfg`

```lua
    ensure interact-sound       
```

`Add the sounds from k_diseases\sounds to interact-sound\client\html\sounds`

### If you are installing interact-sound for the first time you will need to do the following
at `interact-sound/fxmanifest.lua` add the following

files {
    'client/html/index.html',
    'client/html/sounds/*.ogg'
}

Instead of 

files {
    'client/html/index.html',
    -- Begin Sound Files Here...
    -- client/html/sounds/ ... .ogg
    'client/html/sounds/demo.ogg'
}


Step 8:
`Follow the docs below to setup your own diseases/cures!`

Step 9:
`Enjoy! I'd suggest looking a few lines down at the docs to understand how to setup more ways to get diseases!`

##### ::::::::::::::::::::::::::::

###### DOCS

If debug is enabled in config.lua the following commands will be enabled:

`/getS` example: `/getS "Common Cold"` -- this will grant the player this disease
`/removeS` example: `/removeS "Common Cold"` -- this will remove the players disease
`/removeAllS` example: `/removeAllS` -- this will remove all the players diseases (just the source player not all)
`/sickness `example: `/sickness` -- this will bypass the startup check for ESX and QB (forces the disease system to start)

``
    exports['k_diseases']:CatchDisease(type, chance, checkifalreadyhasit)
    TriggerServerEvent('k_diseases:catchdisease', source, type, chance, checkifalreadyhasit)
    TriggerEvent('k_diseases:catchdisease', type, chance, checkifalreadyhasit)
    `This can be used to give a player a specified disease`: (`exports['k_diseases']:CatchDisease(type, chance, checkifalreadyhasit)`) Example: exports['k_diseases']:CatchDisease("Common Cold", 100, false)
    type: Config.Diseases
    chance: Chance in %
    checkifalreadyhasit: Checks if the player already has this disease and if they do it wont renew.
``
    exports['k_diseases']:ClearDisease(type)
    TriggerServerEvent('k_diseases:cleardisease', source, type)
    TriggerEvent('k_diseases:cleardisease', type)
    `This can be used to remove a player a specified disease`: (`exports['k_diseases']:ClearDisease(type)`) Example: exports['k_diseases']:ClearDisease("Common Cold")
    type: Config.Diseases

``
    exports['k_diseases']:GetDiseases()
    `This is used to return all a players diseases`: (`exports['k_diseases']:GetDiseases()`)
    returns: Same layout as Config.Diseases example: exports['k_diseases']:GetDiseases()['Common Cold'].hasDiseases
``
    exports['k_diseases']:ClearAllDisease()
    TriggerServerEvent('k_diseases:clearall', source)
    TriggerEvent('k_diseases:clearall')
    `Removes all a specified player's current diseases`: (`exports['k_diseases']:ClearAllDisease()`)
``
    "CatchDisease", -- exports['k_diseases']:CatchDisease(type, chance, check)
    "ClearDisease", -- exports['k_diseases']:ClearDisease(type)
    "GetDiseases",-- exports['k_diseases']:GetDiseases() -- returns list of Diseases true or false and iterations Example: ( exports['k_diseases']:GetDiseases()["Common Cold"].hasDiseases )
    "ClearAllDisease" -- exports['k_diseases']:ClearAllDisease() -- Clears every sickness (could be used on player revive or something :P)
``

`You can easily add more medicenes in the config.lua!`

`Adding new diseases is relatively easy. there is a example at line 66 in config.lua!`

`You will need to make your own ways to get some of the diseases that are already setup`
`There is a example disease search in the config.lua at line 366`


###### DOCS

Need support?
`All support is done via my discord at discord.gg/y6RtPVwkXq`

Freaquently asked questions:

Can i add onto this script?
`Yes there are callbacks and lots of configurable options!`

Are you going to do an open source version?
`At this moment in time, no sorry`
