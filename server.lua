local QBCore = exports['qb-core']:GetCoreObject()

-- Bucket management
local FactoryBuckets = {}
local MaxPlayersPerBucket = Config.Factory.maxPlayers
local FactoryBucketID = Config.Factory.bucket

-- Initialize bucket tracking
local function InitializeBucketSystem()
    FactoryBuckets[FactoryBucketID] = {
        playerCount = 0,
        maxPlayers = MaxPlayersPerBucket,
        createdAt = os.time(),
    }
end

-- Get or create bucket
local function GetAvailableBucket()
    for bucketID, data in pairs(FactoryBuckets) do
        if data.playerCount < data.maxPlayers then
            return bucketID
        end
    end
    
    -- Create new bucket if all are full
    local newBucketID = FactoryBucketID + math.random(1, 1000)
    FactoryBuckets[newBucketID] = {
        playerCount = 0,
        maxPlayers = MaxPlayersPerBucket,
        createdAt = os.time(),
    }
    
    print('^2New factory bucket created: ' .. newBucketID .. '^7')
    return newBucketID
end

-- Player joined event
AddEventHandler('playerJoining', function()
    -- Ensure player starts in default bucket
    SetPlayerRoutingBucket(source, 0)
end)

-- Player dropped event
AddEventHandler('playerDropped', function(reason)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if player then
        -- Clean up bucket count
        for _, data in pairs(FactoryBuckets) do
            if data.playerCount > 0 then
                data.playerCount = data.playerCount - 1
            end
        end
    end
end)

-- Server-side validation for factory actions
RegisterNetEvent('factory:validateAction', function(actionType)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if not player then
        TriggerClientEvent('QBCore:Notify', src, 'Player not found', 'error')
        return
    end
    
    if Config.Debug then
        print('^5Player ' .. player.PlayerData.charinfo.firstname .. ' performed action: ' .. actionType .. '^7')
    end
end)

-- Notify bucket full
RegisterNetEvent('factory:notifyBucketFull', function()
    local src = source
    TriggerClientEvent('QBCore:Notify', src, Config.Notifications.bucketFull, 'error')
end)

-- Server-side logging for audit trail
local function LogFactoryAction(playerID, playerName, action, timestamp)
    local logEntry = string.format(
        '[%s] Player: %s (ID: %d) - Action: %s',
        os.date('%Y-%m-%d %H:%M:%S', timestamp),
        playerName,
        playerID,
        action
    )
    
    if Config.Debug then
        print('^5' .. logEntry .. '^7')
    end
    
    -- Optional: Save to database
    -- MySQL.Async.execute('INSERT INTO factory_logs (player_id, player_name, action, created_at) VALUES (?, ?, ?, ?)',
    --     {playerID, playerName, action, os.time()})
end

-- Initialize on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        InitializeBucketSystem()
        print('^2Factory System Server initialized.^7')
        print('^2Bucket System: ' .. FactoryBucketID .. '^7')
        print('^2Max Players per Instance: ' .. MaxPlayersPerBucket .. '^7')
    end
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('^3Factory System Server stopped.^7')
    end
end)