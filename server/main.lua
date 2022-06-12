local GotItems = {}

RegisterNetEvent('prison:server:SetJailStatus', function(jailTime)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if not Player then return end
    Player.Functions.SetMetaData("injail", jailTime)
    -- if Config.RemoveJob == true then
    if jailTime > 0 then
        if Player.PlayerData.job.name ~= "unemployed" then
            Player.Functions.SetJob("unemployed")
            -- TriggerClientEvent('QBCore:Notify', src, Lang:t("info.lost_job"))
        end
    else
        GotItems[source] = nil
    end
-- end
end)

RegisterNetEvent('prison:server:SaveJailItems', function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if not Player then return end
    if not Player.PlayerData.metadata["jailitems"] or not next(Player.PlayerData.metadata["jailitems"]) then
        Player.Functions.SetMetaData("jailitems", Player.PlayerData.items)
        Player.Functions.AddMoney('cash', 10)
        Wait(2000)
        Player.Functions.ClearInventory()
    end
end)

RegisterNetEvent('prison:server:GiveJailItems', function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if not Player then return end
    Wait(1000)
    for _, v in pairs(Player.PlayerData.metadata["jailitems"]) do
        Player.Functions.AddItem(v.name, v.amount, false, v.info)
    end
    Wait(1000)
    Player.Functions.SetMetaData("jailitems", {})
end)

RegisterNetEvent('prison:server:CheckRecordStatus', function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if not Player then return end
    local CriminalRecord = Player.PlayerData.metadata["criminalrecord"]
    local currentDate = os.date("*t")

    if (CriminalRecord["date"].month + 1) == 13 then
        CriminalRecord["date"].month = 0
    end

    if CriminalRecord["hasRecord"] then
        if currentDate.month == (CriminalRecord["date"].month + 1) or currentDate.day == (CriminalRecord["date"].day - 1) then
            CriminalRecord["hasRecord"] = false
            CriminalRecord["date"] = nil
        end
    end
end)
