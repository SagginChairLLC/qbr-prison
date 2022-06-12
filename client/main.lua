inJail = false
jailTime = 0

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] > 0 then
			TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
			
		end
	end)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
	Wait(100)
	if LocalPlayer.state['isLoggedIn'] then
		exports['qbr-core']:GetPlayerData(function(PlayerData)
			if PlayerData.metadata["injail"] > 0 then
				TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
			end
		end)
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	inJail = false
	RemoveBlip(PackageBlip)
end)

RegisterNetEvent('prison:client:Enter', function(time)
	exports['qbr-core']:Notify(8, 'Welcome to Prison', 9000, 'Prison Sentence '..time..' Months      Make yourself useful go do some work!', 'generic_textures_tu', 'shield_passive', 'COLOR_GREEN')

	TriggerEvent("chatMessage", "SYSTEM", "warning", "Your property has been seized, you'll get everything back when your time is up..")
	local RandomStartPosition = Config.Locations.spawns[math.random(1, #Config.Locations.spawns)]
	SetEntityCoords(PlayerPedId(), RandomStartPosition.coords.x, RandomStartPosition.coords.y, RandomStartPosition.coords.z - 0.9, 0, 0, 0, false)
	SetEntityHeading(PlayerPedId(), RandomStartPosition.coords.w)
	Wait(500)
	inJail = true
	jailTime = time
	TriggerEvent('qbr-prison:client:jailtime')
	TriggerServerEvent("prison:server:SetJailStatus", jailTime)
	TriggerServerEvent("prison:server:SaveJailItems", jailTime)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5)
	Wait(2000)
end)

RegisterNetEvent('prison:client:Leave', function()
	if jailTime > 0 then
		exports['qbr-core']:Notify(8, 'You Still Have Time to Serve', 5000, 'Time Remaining '..jailTime.. ' Minutes', 'hud_toasts', 'toast_mp_status_change', 'COLOR_GREEN')
	else
		jailTime = 0
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		TriggerEvent("chatMessage", "SYSTEM", "warning", "you've received your property back..")
		inJail = false
		RemoveBlip(BlipPackage)
		exports['qbr-core']:Notify(8, 'You\'re Free From Prison', 9000, '', 'generic_textures_tu', 'shield_passive', 'COLOR_GREEN')

		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)

		Wait(500)

	end
end)


RegisterNetEvent('prison:client:UnjailPerson', function()
	if jailTime > 0 then
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		TriggerEvent("chatMessage", "SYSTEM", "warning", "You got your property back..")
		inJail = false
		RemoveBlip(BlipPackage)
		exports['qbr-core']:Notify(8, 'You\'re Free From Prison', 9000, '', 'generic_textures_tu', 'shield_passive', 'COLOR_GREEN')
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)
	end
end)

--Shop
RegisterNetEvent('prison:client:canteen',function()
	local ShopItems = {}
	ShopItems.label = "Prison Canteen"
	ShopItems.items = Config.CanteenItems
	ShopItems.slots = #Config.CanteenItems
	TriggerServerEvent("inventory:server:OpenInventory", "shop", "Canteenshop_"..math.random(1, 99), ShopItems)
end)

--Prison Menu
Citizen.CreateThread(function()
    for k, v in pairs(Config.JailMenu) do
        exports['qbr-core']:createPrompt(v.injail, v.coords, Config.JailMenukey, 'Open ' .. v.name, {
            type = 'client',
            event = 'qbr-prison:client:Openmenu',
            args = {},
        })
    end
end)

--qbr-menu (Just remove Icon if you are not using the Saggin's Scripts qbr-menu)

RegisterNetEvent('qbr-prison:client:Openmenu', function()
    shownJailMenu = true
    local jailMenu = {
        {
            header = "Jail Menu",
            isMenuHeader = true,
        },
        {
            header = "Open Shop",
			icon = "fas fa-hamburger", --remove line if you do not use script
            txt = "Jail Food",
            params = {
                event = "prison:client:canteen",
            }
        },
        {
            header = "Check Time",
			icon = "fas fa-clock", --remove line if you do not use script
            txt = "Check if Your Time is up",
            params = {
                event = "prison:client:Leave",
            }
        },
    }
    exports['qbr-menu']:openMenu(jailMenu)
end)

--Shitty Loop (gets the job done)

RegisterNetEvent('qbr-prison:client:jailtime', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] > 0 then
			print("works")
            Wait((1000 * 60))
            jailTime -= 1
			TriggerEvent('qbr-prison:client:jailtime')
		end
	end)
end)
