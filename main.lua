-- name: \\#ffdcdc\\2D Game
-- incompatible: romhack

local forceMovementLevels = {
    [LEVEL_BOB] = true
}

local smoothFloorHeight = nil
local smoothHorizontal = 0
local smoothSpeed = 15

local function mario_update(m)
    if m.playerIndex ~= 0 then return end
    if not forceMovementLevels[gNetworkPlayers[0].currLevelNum] then
        smoothFloorHeight = nil
        smoothHorizontal = 0
        return
    end

    m.pos.x = 0

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

    if smoothHorizontal < m.vel.z then
        smoothHorizontal = smoothHorizontal + 2
    end
    if smoothHorizontal > m.vel.z then
        smoothHorizontal = smoothHorizontal - 2
    end

    camera_freeze()

    local focusPos = {
        x = m.pos.x,
        y = m.pos.y + 250 - smoothFloorHeight*0.6 + math.min(0, m.vel.y)*0.1,
        z = m.pos.z + smoothHorizontal,
    }
    vec3f_copy(gLakituState.focus, focusPos)
    gLakituState.pos.x = m.pos.x + 1800
    gLakituState.pos.y = m.pos.y + 400
    gLakituState.pos.z = m.pos.z + smoothHorizontal

    -- Mario Wonder type Rotation
    m.marioObj.header.gfx.angle.y = 0x4000 + math.ceil(m.controller.stickY*0.01)
end

local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if not forceMovementLevels[gNetworkPlayers[0].currLevelNum] then
        camera_unfreeze()
        return
    end
    local stickX = m.controller.stickX
    local stickY = m.controller.stickY

    stickY = stickY + stickX*0.1
    stickX = stickX + stickY*0.1
    
    m.controller.stickY = stickX
    m.controller.stickX = 0
end

local function update()
end

hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_UPDATE, update)