-- name: \\\\Arena - Boiler City

-- register the level here
LEVEL_ARENA_BOILER = level_register('level_arena_boiler_entry', COURSE_NONE, 'Boiler', 'boiler', 28000, 0x28, 0x28, 0x28)

-- make sure we don't add the level twice
local sAddedLevels = false

function on_level_init()
    -- make sure we don't add the level twice
    if sAddedLevels then return end
    sAddedLevels = true

    -- make sure Arena was loaded
    if not _G.Arena then
        djui_popup_create("Error: the Arena gamemode wasn't loaded!", 2)
        return
    end

    -- add the level to arena
    _G.Arena.add_level(LEVEL_ARENA_BOILER, 'Boiler')
end

hook_event(HOOK_ON_LEVEL_INIT, on_level_init)

local forceMovementLevels = {
    [LEVEL_ARENA_BOILER] = true
}

local smoothFloorHeight = nil
local smoothHorizontal = 0
local smoothSpeed = 25

local function mario_update(m)
    if m.playerIndex ~= 0 then return end
    if not forceMovementLevels[gNetworkPlayers[0].currLevelNum] then
        smoothFloorHeight = nil
        smoothHorizontal = 0
        return
    end

    m.pos.z = 0

    -- Smooth Camera Movement Code
    if smoothFloorHeight == nil then
        smoothFloorHeight = m.pos.y - m.floorHeight
    end
    if smoothFloorHeight < m.pos.y - m.floorHeight then
        smoothFloorHeight = smoothFloorHeight + smoothSpeed
    end
    if smoothFloorHeight > m.pos.y - m.floorHeight then
        smoothFloorHeight = smoothFloorHeight - smoothSpeed
    end
    smoothFloorHeight = math.min(smoothFloorHeight, 1000)

    if smoothHorizontal < m.vel.z then
        smoothHorizontal = smoothHorizontal + 2
    end
    if smoothHorizontal > m.vel.z then
        smoothHorizontal = smoothHorizontal - 2
    end

    camera_freeze()

    local focusPos = {
        x = m.pos.x + smoothHorizontal,
        y = m.pos.y + 250 - smoothFloorHeight*0.6,
        z = m.pos.z,
    }
    vec3f_copy(gLakituState.focus, focusPos)
    gLakituState.pos.x = m.pos.x + smoothHorizontal
    gLakituState.pos.y = m.pos.y + 400
    gLakituState.pos.z = m.pos.z + 1800
    m.faceAngle = m.controller.intendedYaw
end

local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if not forceMovementLevels[gNetworkPlayers[0].currLevelNum] and camera_is_frozen() then
        camera_unfreeze()
        return
    end
end

hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_MARIO_UPDATE, mario_update)