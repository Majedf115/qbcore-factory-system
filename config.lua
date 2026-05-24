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
    maxPlayers = 8, -- Maximum players per instance\n}\n\n-- Interior ID (GTA V Secret Factory = 247000)\nConfig.InteriorID = 247000\n\n-- Prop Configurations\nConfig.Props = {\n    -- Laptop on desk\n    {\n        name = 'laptop',\n        model = 'prop_laptop_01a',\n        coords = vector3(105.5, -984.5, 29.45),\n        heading = 0.0,\n        label = 'Laptop Terminal',\n        distance = 2.0,\n        action = 'openUI',\n    },\n    -- Water barrel for sprayer filling\n    {\n        name = 'water_barrel',\n        model = 'prop_waterbarrel_01a',\n        coords = vector3(110.2, -982.8, 29.37),\n        heading = 45.0,\n        label = 'Water Barrel',\n        distance = 2.0,\n        action = 'fillSprayer',\n    },\n    -- Workbench for packaging\n    {\n        name = 'workbench',\n        model = 'prop_woodtable_03a',\n        coords = vector3(115.8, -981.2, 29.37),\n        heading = 0.0,\n        label = 'Workbench',\n        distance = 2.0,\n        action = 'packageProduct',\n    },\n}\n\n-- Target Interaction Configuration\nConfig.Targets = {\n    laptop = {\n        icon = 'fas fa-laptop',\n        label = 'Open Terminal',\n        distance = 2.0,\n    },\n    water_barrel = {\n        icon = 'fas fa-droplet',\n        label = 'Fill Sprayer',\n        distance = 2.0,\n    },\n    workbench = {\n        icon = 'fas fa-hammer',\n        label = 'Package Product',\n        distance = 2.0,\n    },\n}\n\n-- Door/Entry Point Coordinates for bucket management\nConfig.Doors = {\n    {\n        coords = vector3(265.94, 6466.99, 31.04), -- Factory entrance (Your location)\n        distance = 3.0,\n        action = 'enterFactory',\n        heading = 20.22,\n    },\n    {\n        coords = vector3(105.45, -983.65, 29.37), -- Factory exit (inside)\n        distance = 3.0,\n        action = 'exitFactory',\n        heading = 180.0,\n    },\n}\n\n-- Debug Mode\nConfig.Debug = true -- Enable for testing\n\n-- Notification Settings\nConfig.Notifications = {\n    enterFactory = 'Welcome to the factory!',\n    exitFactory = 'You have left the factory.',\n    bucketFull = 'Factory instance is full. Try another instance.',\n    fillSprayer = 'Sprayer filled with water!',\n    packageProduct = 'Product packaged successfully!',\n}\n\nreturn Config", "path": "config.lua