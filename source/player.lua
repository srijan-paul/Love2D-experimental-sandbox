local Entity = require('Components/entity')
local GameConstats = require('GameConstants')
local Vec2 = require('lib/vector2d')

local Player = {}
local PLAYER_DEFAULT_MS = 30

function Player:new()
    local plyr = Entity:new()
    plyr.moveSpeed = PLAYER_DEFAULT_MS
    return setmetatable(plyr, Player)
end

function Player:draw() end

function Player:update(dt) 
    
end

function Player:handleInput()
    if love.keyboard.isDown('a') then
        self.spriteDir = GameConstants.Direction.LEFT
        self.moveDir.x = -1
    end
    if love.keyboard.isDown('d') then
        self.spriteDir = GameConstants.Direction.RIGHT
        self.moveDir.x = 1
    end
    if love.keyboard.isDown('w') then self.moveDir.y = -1 end
    if love.keyboard.isDown('s') then self.moveDir.y = 1 end
end

return Player
