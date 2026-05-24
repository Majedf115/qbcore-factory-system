# Factory System Dependencies

## Required Resources

### 1. QBCore Framework
**Purpose:** Core framework providing player management

```bash
git clone https://github.com/qbcore-framework/qb-core.git resources/qb-core
```

**Ensure in server.cfg:**
```cfg
ensure qb-core
```

---

### 2. ox_target
**Purpose:** Eye-tracking interaction system

```bash
git clone https://github.com/overextended/ox_target.git resources/ox_target
```

**Ensure in server.cfg:**
```cfg
ensure ox_target
```

**Features:**
- Clean eye-tracking interactions
- No green arrows or markers
- Modern and performant

---

### 3. oxmysql
**Purpose:** Modern MySQL/MariaDB driver

```bash
git clone https://github.com/overextended/oxmysql.git resources/oxmysql
```

**Ensure in server.cfg:**
```cfg
ensure oxmysql
```

---

## Optional Resources

### qb-target (Alternative)
**Purpose:** Alternative targeting system

```bash
git clone https://github.com/qbcore-framework/qb-target.git resources/qb-target
```

**Configuration:**
```lua
Config.TargetSystem = 'qb-target'
```

---

## Installation Order (CRITICAL)

```cfg
# 1. Framework
ensure qb-core

# 2. Database
ensure oxmysql

# 3. Target System
ensure ox_target
# OR ensure qb-target

# 4. Factory System
ensure factory-system
```

## Dependency Tree

```
factory-system
├── Requires: qb-core
├── Requires: ox_target (or qb-target)
└── Requires: oxmysql
```

## Version Compatibility

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| QBCore | 1.0.0 | Latest |
| ox_target | Latest | Latest |
| oxmysql | Latest | Latest |
| qb-target | 1.0.0 | Latest |
| FiveM | 7000+ | 8000+ |

## Checking Installation

```bash
# Check all resources
/status

# Check specific resource
/status qb-core
/status ox_target
/status factory-system
```

## Troubleshooting

### Missing QBCore

**Error:** `QBCore is not running!`

**Fix:**
```bash
git clone https://github.com/qbcore-framework/qb-core.git resources/qb-core
# Add to server.cfg: ensure qb-core
restart
```

### Missing ox_target

**Error:** `ox_target resource not found!`

**Fix:**
```bash
git clone https://github.com/overextended/ox_target.git resources/ox_target
# Add to server.cfg: ensure ox_target
restart
```

### Wrong Load Order

**Error:** `Factory System failed - QBCore not found`

**Fix:** Check server.cfg order - QBCore must load before factory-system

---

**Dependencies Version:** 1.0.0  
**Last Updated:** 2025-05-24
