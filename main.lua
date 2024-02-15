-- name: \\#ffdcdc\\2D Game
-- incompatible: romhack

local forceMovementLevels = {
    [LEVEL_BOB] = true
}

local function mario_update(m)
    if m.playerIndex ~= 0 then return end
    if not forceMovementLevels[gNetworkPlayers[0].currLevelNum] then return end
    m.pos.x = 0
    camera_freeze()
    local focusPos = {
        x = m.pos.x,
        y = m.pos.y + 120,
        z = m.pos.z,
    }
    vec3f_copy(gLakituState.focus, focusPos)
    gLakituState.pos.x = m.pos.x + 2000
    gLakituState.pos.y = m.pos.y + 500
    gLakituState.pos.z = m.pos.z
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