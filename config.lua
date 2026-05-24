-- Factory System Configuration
-- Updated for location: vector3(265.94, 6466.99, 31.04)
Config = {}

-- Target System (ox_target or qb-target)
Config.TargetSystem = 'ox_target' -- Options: 'ox_target' or 'qb-target'

-- Factory Locations
Config.Factory = {
    -- Your custom location coordinates
    enterCoords = vector3(265.94, 6466.99, 31.04), -- Factory entrance (Your location)
    enterHeading = 20.22,
    exitCoords = vector3(105.45, -983.65, 29.37), -- Factory exit (inside)
    exitHeading = 180.0,

    -- Routing Buckets (Virtual Worlds) for player isolation
    bucket = 1, -- Main factory bucket ID
    maxPlayers = 8, -- Maximum players per instance
}

-- Interior ID (GTA V Secret Factory = 247000)
Config.InteriorID = 247000

-- Prop Configurations
Config.Props = {
    -- Laptop on desk
    {
        name = 'laptop',
        model = 'prop_laptop_01a',
        coords = vector3(105.5, -984.5, 29.45),
        heading = 0.0,
        label = 'Laptop Terminal',
        distance = 2.0,
        action = 'openUI',
        rotation = vector3(0.0, 0.0, 0.0),
    },
    -- Water barrel for sprayer filling
    {
        name = 'water_barrel',
        model = 'prop_waterbarrel_01a',
        coords = vector3(110.2, -982.8, 29.37),
        heading = 45.0,
        label = 'Water Barrel',
        distance = 2.0,
        action = 'fillSprayer',
        rotation = vector3(0.0, 0.0, 45.0),
    },
    -- Workbench for packaging
    {
        name = 'workbench',
        model = 'prop_woodtable_03a',
        coords = vector3(115.8, -981.2, 29.37),
        heading = 0.0,
        label = 'Workbench',
        distance = 2.0,
        action = 'packageProduct',
        rotation = vector3(0.0, 0.0, 0.0),
    },
}

-- Target Interaction Configuration
Config.Targets = {
    laptop = {
        icon = 'fas fa-laptop',
        label = 'Open Terminal',
        distance = 2.0,
    },
    water_barrel = {
        icon = 'fas fa-droplet',
        label = 'Fill Sprayer',
        distance = 2.0,
    },
    workbench = {
        icon = 'fas fa-hammer',
        label = 'Package Product',
        distance = 2.0,
    },
}

-- Door/Entry Point Coordinates for bucket management
Config.Doors = {
    {
        coords = vector3(265.94, 6466.99, 31.04), -- Factory entrance (Your location)
        distance = 3.0,
        action = 'enterFactory',
        heading = 20.22,
    },
    {
        coords = vector3(105.45, -983.65, 29.37), -- Factory exit (inside)
        distance = 3.0,
        action = 'exitFactory',
        heading = 180.0,
    },
}

-- UI Coordinates and Rotation
Config.UI = {
    enabled = true,
    resource = 'qb-core',
}

-- Debug Mode
Config.Debug = false

-- Notification Settings
Config.Notifications = {
    enterFactory = 'Welcome to the factory!',
    exitFactory = 'You have left the factory.',
    bucketFull = 'Factory instance is full. Try another instance.',
    fillSprayer = 'Sprayer filled with water!',
    packageProduct = 'Product packaged successfully!',
}

-- Blip Settings (Optional, can be disabled)
Config.Blips = {
    enabled = false, -- Set to false to remove all map blips
}

-- Police/Job Restrictions (Optional)
Config.RestrictedJobs = {} -- Jobs that can access factory
Config.RestrictedCitizens = true -- Only citizens can access

return Config