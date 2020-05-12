local Entity = require('Components/entity')
local GameConstants = require('gameconstants')
local Vec2 = require('lib/vector2d')
local Collider = require('components/collider')

local Player = Entity:new()
local PLAYER_DEFAULT_MS = 20
local PLAYER_WIDTH, PLAYER_HEIGHT = 50, 50

function Player:new(_x, _y)
    local player = {x = _x, y = _y}
    self.__index = self
    player.collider = Collider:new('rect', player.x, player.y, PLAYER_WIDTH,
                                   PLAYER_HEIGHT)
    player.max_speed = PLAYER_DEFAULT_MS
    player.current_speed = 0
    return setmetatable(player, self)
end

function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.collider:draw()
end

function Player:update(dt)
    self:inputLoop()
    self:movementLoop()
end

function Player:inputLoop()
    if love.keyboard.isDown('a') then
        self.sprite_dir = GameConstants.Direction.LEFT
        self.move_dir.x = -1
    end
    if love.keyboard.isDown('d') then
        self.sprite_dir = GameConstants.Direction.RIGHT
        self.move_dir.x = 1
    end
    if love.keyboard.isDown('w') then self.move_dir.y = -1 end
    if love.keyboard.isDown('s') then self.move_dir.y = 1 end
end

function Player:movementLoop()

    if self.move_dir.x or self.move_dir.y then
        self.current_speed = self.current_speed + 1
        if self.current_speed >= self.max_speed then
            self.current_speed = self.max_speed
        end
    else
        self.current_speed = self.current_speed - 1
        if self.current_speed < 0 then self.current_speed = 0 end
    end
    self.collider.vel = self.current_speed * self.move_dir:normalized()
    self.move_dir = Vec2:new(0, 0)
end

return Player
