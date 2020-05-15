local Entity = require('Components/entity')
local GameConstants = require('gameconstants')
local Vec2 = require('lib/vector2d')
local Collider = require('components/collider')
local Anim = require('components.animationComponent')
local Resources = require('resources')
local Weapon = require('gameObjects.weapon')

local Player = Entity:new()
local PLAYER_DEFAULT_MS = 4
local PLAYER_WIDTH, PLAYER_HEIGHT = 54, 70

function Player:new(_x, _y) 
    local player = {x = _x, y = _y}
    self.__index = self
    player.collider = Collider:new('rect', player.x, player.y, PLAYER_WIDTH,
                                   PLAYER_HEIGHT)
    player.weapon = Weapon:new(nil, player)
    player.max_speed = PLAYER_DEFAULT_MS
    player.current_speed = 0
    player.move_dir = Vec2:new(0, 0)
    player._move_input = false
    
    return setmetatable(player, self)
end

function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.collider:draw()
    self.weapon:draw()
end

function Player:update(dt)
    self:inputLoop()
    self:movementLoop()
    self.collider:update(dt)
end

function Player:inputLoop()
    if love.keyboard.isDown('a') then
        self.move_dir.x = -1
        self.move_input = true
    end
    if love.keyboard.isDown('d') then
        self.move_dir.x = 1
        self.move_input = true
    end
    if love.keyboard.isDown('w') then
        self.move_dir.y = -1
        self.move_input = true
    end
    if love.keyboard.isDown('s') then
        self.move_dir.y = 1
        self.move_input = true
    end
end

function Player:movementLoop()
    if self.move_input then
        self.current_speed = self.current_speed + 0.6
        if self.current_speed >= self.max_speed then
            self.current_speed = self.max_speed
        end
    else
        self.current_speed = self.current_speed - 0.6
        if self.current_speed < 0 then self.current_speed = 0 end
    end
    local move_vel = self.current_speed * self.move_dir:normalized()
    self.collider.vel = self.collider.vel + move_vel
    self.move_dir = Vec2:new(0, 0)
    self.move_input = false
end

return Player
