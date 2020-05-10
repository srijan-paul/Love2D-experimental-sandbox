local Entity = require('Components/entity')
local GameConstants = require('gameconstants')
local Vec2 = require('lib/vector2d')
local Collider = require('components/collider')

local Player = Entity:new()
local PLAYER_DEFAULT_MS = 30
local PLAYER_WIDTH, PLAYER_HEIGHT = 50, 50

function Player:new(_x, _y)
    local plyr = {x = _x, y = _y}
    print(_x, _y)
    self.__index = self
    plyr.collider = Collider:new(plyr.x, plyr.y, PLAYER_WIDTH, PLAYER_HEIGHT)
    plyr.moveSpeed = PLAYER_DEFAULT_MS
    return setmetatable(plyr, self)
end

function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.collider:draw()
end

function Player:update(dt) self:handleInput() end

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
