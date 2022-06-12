    Citizen.CreateThread(function()

        for k, v in pairs(Config.PrisonJobs) do
            exports['qbr-core']:createPrompt(v.jobType, v.coords, Config.JailMenukey, 'Package ' .. v.name, {
                type = 'client',
                event = 'qbr-prison:client:packagegoods',
                args = {},
            })
            if v.showblip == true then
                local BlipPackage = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
                SetBlipSprite(BlipPackage, 1321928545, 1)
                SetBlipScale(BlipPackage, 0.2)
                Citizen.InvokeNative(0x9CB1A1623062F402, BlipPackage, v.name)
            end
        end
    end)


RegisterNetEvent('qbr-prison:client:packagegoods', function()
    exports['qbr-core']:Progressbar("search_register", "Packaging Goods", Config.PackagingTime, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "script_ca@cachr@ig@ig4_vaultloot",
        anim = "ig13_14_grab_money_front01_player_zero",
        flags = 1,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        jailTime -= math.random(1, 2)
    end, function()
        ClearPedTasks(PlayerPedId())
        exports['qbr-core']:Notify(8, 'Packaging Cancelled', 5000, '', 'itemtype_textures', 'itemtype_player_deadeye', 'COLOR_GREEN')
        end)
    end)
