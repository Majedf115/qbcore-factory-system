# Complete Installation Guide for QBCore Factory System

## Prerequisites

1. ✅ FiveM Server running
2. ✅ QBCore Framework installed
3. ✅ MySQL database configured
4. ✅ Administrator access to server files

## Step-by-Step Installation

### Step 1: Clone Repository

```bash
cd your-server/resources
git clone https://github.com/Majedf115/qbcore-factory-system.git factory-system
```

### Step 2: Verify Dependencies

Ensure these resources are installed:

```
resources/
├── qb-core/
├── ox_target/
├── oxmysql/
└── factory-system/ (NEW)
```

### Step 3: Add to server.cfg

```cfg
# Database
ensure oxmysql

# Framework
ensure qb-core

# Target System
ensure ox_target
# OR for qb-target:
# ensure qb-target

# Factory System
ensure factory-system
```

### Step 4: Configure

Edit `resources/factory-system/config.lua`:

```lua
Config.TargetSystem = 'ox_target'  -- or 'qb-target'
Config.Factory.bucket = 1
Config.Factory.maxPlayers = 8
Config.Debug = true  -- Set to false in production
```

### Step 5: Start Server

```bash
restart
```

### Step 6: Verify

Check console for:

```
^2Factory System Server initialized.^7
^2Factory System initialized.^7
```

### Step 7: Test

1. Join server
2. Run: `/factory enter`
3. Look at props to see interactions
4. Run: `/factory exit`

## Troubleshooting

### Resource Won't Start

**Check dependencies:**
```bash
/status qb-core
/status ox_target
/status oxmysql
```

**Solution:** Ensure all dependencies are running and properly ordered in server.cfg

### Can't See Interactions

**Enable debug mode:**
```lua
Config.Debug = true
```

**Check console for:**
```
^2ox_target interactions registered.^7
```

### Players Overlapping

**Solution:** Increase bucket distance:
```lua
Config.Factory.bucket = 1000  -- Use higher ID
Config.Factory.maxPlayers = 4  -- Reduce per instance
```

## Using qb-target Instead

1. In `config.lua`:
```lua
Config.TargetSystem = 'qb-target'
```

2. In `server.cfg`:
```cfg
ensure qb-target
# ensure ox_target  -- Comment out
```

3. Restart: `restart factory-system`

## Performance Tips

- Keep `Config.Debug = false` for production
- Use unique bucket IDs (1, 1000, 2000)
- Limit `maxPlayers` based on server resources
- Monitor server console for errors

---

**Installation Version:** 1.0.0  
**Last Updated:** 2025-05-24
