local QBCore = exports['qb-core']:GetCoreObject()
local PlayerInFactory = false
local CurrentBucket = 0
local FactoryOpen = false
local ActiveProps = {}

-- Load configuration
local TargetSystem = Config.TargetSystem
local FactoryBucket = Config.Factory.bucket
local MaxPlayersPerBucket = Config.Factory.maxPlayers

-- Initialize target system
local function InitializeTargetSystem()
    if TargetSystem == 'ox_target' then
        if not exports.ox_target then
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                multiline = true,
                args = {'SYSTEM', 'ox_target resource not found!'}
            })
            return false
        end
    elseif TargetSystem == 'qb-target' then
        if not exports['qb-target'] then
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                multiline = true,
                args = {'SYSTEM', 'qb-target resource not found!'}
            })
            return false
        end
    end
    return true
 end

-- Load interior
local function LoadInterior(interiorID)
    RequestIpl(interiorID)
    while not IsIplActive(interiorID) do
        Wait(100)
    end
    if Config.Debug then
        print('^2Interior loaded: ' .. interiorID .. '^7')
    end
end

-- Unload interior
local function UnloadInterior(interiorID)
    RemoveIpl(interiorID)
    if Config.Debug then
        print('^3Interior unloaded: ' .. interiorID .. '^7')
    end
end

-- Spawn props in factory
local function SpawnProps()
    for _, prop in ipairs(Config.Props) do
        local modelHash = GetHashKey(prop.model)
        RequestModel(modelHash)
        
        while not HasModelLoaded(modelHash) do
            Wait(100)
        end
        
        local propEntity = CreateObject(modelHash, prop.coords.x, prop.coords.y, prop.coords.z, false, false, false)
        SetEntityHeading(propEntity, prop.heading)
        PlaceObjectOnGroundProperly(propEntity)
        
        table.insert(ActiveProps, {
            entity = propEntity,
            name = prop.name,
            action = prop.action,
            coords = prop.coords
        })
        
        ReleaseModelRequest(modelHash)
        
        if Config.Debug then
            print('^2Prop spawned: ' .. prop.name .. '^7')
        end
    end
end

-- Delete all props
local function DeleteProps()
    for _, prop in ipairs(ActiveProps) do
        if DoesEntityExist(prop.entity) then
            DeleteEntity(prop.entity)
        end
    end
    ActiveProps = {}
    if Config.Debug then
        print('^3All props deleted.^7')
    end
end

-- Setup target interactions
local function SetupTargetInteractions()
    if not InitializeTargetSystem() then
        return
    end
    
    if TargetSystem == 'ox_target' then
        -- Laptop interaction
        exports.ox_target:addModel(GetHashKey('prop_laptop_01a'), {
            {
                icon = Config.Targets.laptop.icon,
                label = Config.Targets.laptop.label,
                distance = Config.Targets.laptop.distance,
                onSelect = function(data)
                    TriggerEvent('factory:openUI')
                end,
                canInteract = function(entity, distance, coords, name)
                    return distance < Config.Targets.laptop.distance
                end,
            }
        })
        
        -- Water barrel interaction
        exports.ox_target:addModel(GetHashKey('prop_waterbarrel_01a'), {
            {
                icon = Config.Targets.water_barrel.icon,
                label = Config.Targets.water_barrel.label,
                distance = Config.Targets.water_barrel.distance,
                onSelect = function(data)
                    TriggerEvent('factory:fillSprayer')
                end,
                canInteract = function(entity, distance, coords, name)
                    return distance < Config.Targets.water_barrel.distance
                end,
            }
        })
        
        -- Workbench interaction
        exports.ox_target:addModel(GetHashKey('prop_woodtable_03a'), {
            {
                icon = Config.Targets.workbench.icon,
                label = Config.Targets.workbench.label,
                distance = Config.Targets.workbench.distance,
                onSelect = function(data)
                    TriggerEvent('factory:packageProduct')
                end,
                canInteract = function(entity, distance, coords, name)
                    return distance < Config.Targets.workbench.distance
                end,
            }
        })
        
        if Config.Debug then
            print('^2ox_target interactions registered.^7')
        end
        
    elseif TargetSystem == 'qb-target' then
        -- qb-target setup
        exports['qb-target']:AddBoxZone('factory_laptop', Config.Props[1].coords, 1.5, 1.5, {
            name = 'factory_laptop',
            heading = 0,
            debugPoly = Config.Debug
        }, {
            options = {
                {
                    type = 'client',
                    event = 'factory:openUI',
                    icon = 'fas fa-laptop',
                    label = Config.Targets.laptop.label,
                }
            },
            distance = Config.Targets.laptop.distance
        })
        
        exports['qb-target']:AddBoxZone('factory_barrel', Config.Props[2].coords, 1.5, 1.5, {
            name = 'factory_barrel',
            heading = 45,
            debugPoly = Config.Debug
        }, {
            options = {
                {
                    type = 'client',
                    event = 'factory:fillSprayer',
                    icon = 'fas fa-droplet',
                    label = Config.Targets.water_barrel.label,
                }
            },
            distance = Config.Targets.water_barrel.distance
        })
        
        exports['qb-target']:AddBoxZone('factory_workbench', Config.Props[3].coords, 1.5, 1.5, {
            name = 'factory_workbench',
            heading = 0,
            debugPoly = Config.Debug
        }, {
            options = {
                {
                    type = 'client',
                    event = 'factory:packageProduct',
                    icon = 'fas fa-hammer',
                    label = Config.Targets.workbench.label,
                }
            },
            distance = Config.Targets.workbench.distance
        })
        
        if Config.Debug then
            print('^2qb-target interactions registered.^7')
        end
    end
end

-- Get available bucket
local function GetAvailableBucket()
    local availableBucket = FactoryBucket
    
    -- Check if bucket has space
    local playerCount = 0
    for _, playerId in ipairs(GetPlayers()) do
        if GetPlayerRoutingBucket(playerId) == availableBucket then
            playerCount = playerCount + 1
        end
    end
    
    if playerCount >= MaxPlayersPerBucket then
        availableBucket = FactoryBucket + math.random(1, 10) -- Create new instance
        if Config.Debug then
            print('^3New bucket created: ' .. availableBucket .. '^7')
        end
    end
    
    return availableBucket
end

-- Enter factory
local function EnterFactory()
    if PlayerInFactory then
        TriggerEvent('QBCore:Notify', Config.Notifications.enterFactory, 'success')
        return
    end
    
    CurrentBucket = GetAvailableBucket()
    SetPlayerRoutingBucket(PlayerId(), CurrentBucket)
    
    LoadInterior(Config.InteriorID)
    SpawnProps()
    SetupTargetInteractions()
    
    -- Teleport player inside
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(PlayerPedId(), Config.Factory.exitCoords.x, Config.Factory.exitCoords.y, Config.Factory.exitCoords.z, false, false, false, false)
    SetEntityHeading(PlayerPedId(), Config.Factory.exitHeading)
    Wait(500)
    DoScreenFadeIn(500)
    
    PlayerInFactory = true
    FactoryOpen = true
    
    TriggerEvent('QBCore:Notify', Config.Notifications.enterFactory, 'success')
    
    if Config.Debug then
        print('^2Player entered factory. Bucket: ' .. CurrentBucket .. '^7')
    end
end

-- Exit factory
local function ExitFactory()
    if not PlayerInFactory then
        return
    end
    
    SetPlayerRoutingBucket(PlayerId(), 0)
    UnloadInterior(Config.InteriorID)
    DeleteProps()
    
    -- Teleport player outside
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(PlayerPedId(), Config.Factory.enterCoords.x, Config.Factory.enterCoords.y, Config.Factory.enterCoords.z, false, false, false, false)
    SetEntityHeading(PlayerPedId(), Config.Factory.enterHeading)
    Wait(500)
    DoScreenFadeIn(500)
    
    PlayerInFactory = false
    FactoryOpen = false
    
    TriggerEvent('QBCore:Notify', Config.Notifications.exitFactory, 'success')
    
    if Config.Debug then
        print('^3Player exited factory.^7')
    end
end

-- Factory interaction events
RegisterNetEvent('factory:openUI', function()
    if not PlayerInFactory then return end
    
    TriggerEvent('QBCore:Notify', 'Terminal opened.', 'info')
    -- Add your UI opening logic here (NUI callback)
    if Config.Debug then
        print('^5UI Opened^7')
    end
end)

RegisterNetEvent('factory:fillSprayer', function()
    if not PlayerInFactory then return end
    
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
    Wait(3000)
    ClearPedTasksImmediately(playerPed)
    
    TriggerEvent('QBCore:Notify', Config.Notifications.fillSprayer, 'success')
    if Config.Debug then
        print('^2Sprayer filled^7')
    end
end)

RegisterNetEvent('factory:packageProduct', function()
    if not PlayerInFactory then return end
    
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_STUPOR', 0, true)
    Wait(5000)
    ClearPedTasksImmediately(playerPed)
    
    TriggerEvent('QBCore:Notify', Config.Notifications.packageProduct, 'success')
    if Config.Debug then
        print('^2Product packaged^7')
    end
end)

-- Door/Entry proximity zones
local function SetupDoorZones()
    if TargetSystem == 'ox_target' then
        -- Entrance door
        exports.ox_target:addSphere(Config.Doors[1].coords, Config.Doors[1].distance, {
            {
                icon = 'fas fa-door-open',
                label = 'Enter Factory',
                distance = Config.Doors[1].distance,
                onSelect = function(data)
                    EnterFactory()
                end,
            }
        })
        
        -- Exit door
        exports.ox_target:addSphere(Config.Doors[2].coords, Config.Doors[2].distance, {
            {
                icon = 'fas fa-sign-out-alt',
                label = 'Exit Factory',
                distance = Config.Doors[2].distance,
                onSelect = function(data)
                    ExitFactory()
                end,
            }
        })
    end
end

-- Command to enter factory (testing)
RegisterCommand('factory', function(source, args, rawCommand)
    if args[1] == 'enter' then
        EnterFactory()
    elseif args[1] == 'exit' then
        ExitFactory()
    elseif args[1] == 'debug' then
        Config.Debug = not Config.Debug
        print('Debug mode: ' .. tostring(Config.Debug))
    end
end)

-- Initialize on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if Config.Debug then
            print('^2Factory System initialized.^7')
            print('^2Target System: ' .. TargetSystem .. '^7')
        end
        SetupDoorZones()
    end
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if PlayerInFactory then
            ExitFactory()
        end
        DeleteProps()
        if Config.Debug then
            print('^3Factory System stopped.^7')
        end
    end
end)

-- Handle player disconnect
AddEventHandler('playerDropped', function()
    if PlayerInFactory then
        ExitFactory()
    end
end)