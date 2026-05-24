# QBCore Factory System with Eye Tracking

A professional, immersive factory system for FiveM/QBCore with eye-tracking interactions (ox_target or qb-target) and secure bucket routing.

## Features

✅ **Eye-Tracking Interactions**: No green arrows or ground markers  
✅ **Dual Target System**: Support for both ox_target and qb-target  
✅ **GTA V Secret Factory Interior**: Uses authentic interior coordinates  
✅ **Bucket Routing**: Isolated instances prevent player overlapping  
✅ **Interactive Props**:  
   - Laptop terminal on desk  
   - Water barrel for sprayer filling  
   - Workbench for product packaging  
✅ **Clean & Professional**: No unnecessary UI elements  
✅ **Debug Mode**: Optional console logging for development  
✅ **Custom Location**: Your specified coordinates vector3(265.94, 6466.99, 31.04)

## Quick Start

### Installation

```bash
cd resources
git clone https://github.com/Majedf115/qbcore-factory-system.git factory-system
```

### Add to server.cfg

```cfg
ensure qb-core
ensure oxmysql
ensure ox_target
ensure factory-system
```

### In-Game Commands

```
/factory enter     - Enter the factory
/factory exit      - Exit the factory
/factory debug     - Toggle debug mode
```

## Configuration

Edit `config.lua` to customize:

```lua
-- Target system choice
Config.TargetSystem = 'ox_target'  -- or 'qb-target'

-- Factory entrance (your location)
Config.Factory.enterCoords = vector3(265.94, 6466.99, 31.04)
Config.Factory.enterHeading = 20.22

-- Max players per instance
Config.Factory.maxPlayers = 8
```

## Dependencies

- qb-core (required)
- ox_target or qb-target (required)
- oxmysql (required)

## Documentation

- **README.md** - Feature overview
- **INSTALLATION_GUIDE.md** - Detailed setup
- **DEPENDENCIES.md** - Dependency info
- **CHANGELOG.md** - Version history

## Features Explained

### Eye Tracking System
- Clean interactions with no visual clutter
- Look at props to interact
- Support for both ox_target and qb-target
- Configurable interaction distances

### Bucket Routing
- Prevents player overlapping
- Automatic instance creation
- Configurable max players per instance
- Server-side validation

### Props System
- Laptop terminal (open UI)
- Water barrel (fill sprayer)
- Workbench (package product)
- Fully customizable positions and models

## License

MIT License - Feel free to modify for your server

---

**Version:** 1.0.0  
**Last Updated:** 2025-05-24  
**Compatibility:** QBCore, FiveM (cerulean)
