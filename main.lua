-- name: \\#ffdcdc\\2D Game
-- incompatible: romhack

local forceMovementLevels = {
    [LEVEL_BOB] = true
}

local rotateActs = {
    [ACT_TURNING_AROUND] = true,
    [ACT_SIDE_FLIP] = true,
    [ACT_LEDGE_GRAB] = true,
    [ACT_LEDGE_CLIMB_DOWN] = true,
    [ACT_LEDGE_CLIMB_FAST] = true,
    [ACT_LEDGE_CLIMB_SLOW_1] = true,
    [ACT_LEDGE_CLIMB_SLOW_2] = true,
}

local smoothFloorHeight = nil
local smoothHorizontal = 0
local smoothSpeed = 25
local focusOffset = 0
local faceRight = true

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

    -- Mario Wonder type Rotation
    if m.vel.x < 0 and not rotateActs[m.action] then
        faceRight = true
    end
    if m.vel.x > 0 and not rotateActs[m.action] then
        faceRight = false
    end
    if not rotateActs[m.action] then
        if faceRight then
            m.marioObj.header.gfx.angle.y = -0x2000
        else
            m.marioObj.header.gfx.angle.y = 0x2000
        end
    end
end

local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if not forceMovementLevels[gNetworkPlayers[0].currLevelNum] and camera_is_frozen() then
        camera_unfreeze()
        return
    end
end

local function update()
end

hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_UPDATE, update)