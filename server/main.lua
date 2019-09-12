ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- Success server event
RegisterServerEvent('rs_crafting:CraftingSuccess')
AddEventHandler('rs_crafting:CraftingSuccess', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Items[CraftItem]
    for itemname, v in pairs(item.needs) do
        xPlayer.removeInventoryItem(itemname, v.count)
    end
    if CraftItem == "weapon_pistol" or CraftItem == "weapon_combatpistol" then
        xPlayer.addWeapon(CraftItem, 0)
    else
        xPlayer.addInventoryItem(CraftItem, 1)
    end
    -- Adding function for crafting points (you can remove it if you want, YOU HAVE TO REMOVE THRESHOLDS ASWELL) 
    AddCraftingPoints(src)
    TriggerClientEvent('esx:showNotification', src, "You have made ~b~"..item.label.."~w~!")
end)
-- Fail server event
RegisterServerEvent('rs_crafting:CraftingFailed')
AddEventHandler('rs_crafting:CraftingFailed', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Items[CraftItem]
    -- Random chance to lose your items you can't change it
    local rand = math.random(1,50)
    if rand >= 50 then
        TriggerClientEvent('esx:showNotification', src, "Luckily you still have your items..")
    else
        for itemname, v in pairs(item.needs) do
            xPlayer.removeInventoryItem(itemname, v.count)
        end
    end
    -- Adding function for crafting points (you can remove it if you want, YOU HAVE TO REMOVE THRESHOLDS ASWELL)
	RemoveCraftingPoints(src)
    TriggerClientEvent('esx:showNotification', src, "~r~It failed to make ~b~"..item.label)
end)

-- Callback to get your crafting points from the database
ESX.RegisterServerCallback('rs_crafting:GetSkillLevel', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM user_levels WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] ~= nil then
            cb(tonumber(result[1].crafting))
        else
            MySQL.Async.execute('INSERT INTO user_levels (identifier, crafting) VALUES (@identifier, @crafting)', {
                ['@identifier'] = identifier,
                ['@crafting'] = 1
            }, function(rowsChanged)
                return cb(1)
            end)
        end
    end)
end)
-- Check if you have the items
ESX.RegisterServerCallback('rs_crafting:HasTheItems', function(source, cb, CraftItem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = Crafting.Items[CraftItem]
    for itemname, v in pairs(item.needs) do
        if xPlayer.getInventoryItem(itemname).count < v.count then
            cb(false)
        end
    end
    cb(true)
end)
-- Adding crafting points function (you can change the math random to whatever you want)
function AddCraftingPoints(source)
    local identifier =  GetPlayerIdentifiers(source)[1]
    MySQL.Sync.execute('UPDATE user_levels SET crafting = crafting + @crafting WHERE identifier = @identifier', {
        ['@crafting'] = math.random(1, 3),
        ['@identifier'] = identifier
    })
end
-- Remove crafting points function (you can change the math random to whatever you want)
function RemoveCraftingPoints(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM user_levels WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result1)
        local craftinglevel = tonumber(result1[1].crafting)
        if craftinglevel > 0 then
            MySQL.Sync.execute('UPDATE user_levels SET crafting = crafting - @crafting WHERE identifier = @identifier', {
                ['@crafting'] = 1,
                ['@identifier'] = identifier
            })
        else
            -- nothing has to happen here
            return
	    end
	end)
end
-- Function to get players crafting level
function GetCraftingLevel(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM user_levels WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] ~= nil then
            return tonumber(result[1].crafting)
        else
            MySQL.Async.execute('INSERT INTO user_levels (identifier, crafting) VALUES (@identifier, @crafting)', {
                ['@identifier'] = identifier,
                ['@crafting'] = 1
            }, function(rowsChanged)
                return 1
            end)
        end
    end)
end