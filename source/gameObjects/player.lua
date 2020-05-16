local Entity = require('Components/entity')
local GameConstants = require('gameconstants')
local Vec2 = require('lib/vector2d')
local Collider = require('components/collider')
local Anim = require('components.animationComponent')
local Weapon = require('gameObjects.weapons.weapon')
local WeaponType = require('gameObjects.weapons.weaponTypes')

local Player = Entity:new()
local PLAYER_DEFAULT_MS = 4
local PLAYER_WIDTH, PLAYER_HEIGHT = 68, 74

local State = {idle = 'idle', walk = 'walk'}

function Player:new(_x, _y)
    local player = {x = _x, y = _y}
    self.__index = self
    player.collider = Collider:new('rect', player.x, player.y, PLAYER_WIDTH,
                                   PLAYER_HEIGHT)
    player.weapon = Weapon:new(WeaponType.Revolver, player)
    player.max_speed = PLAYER_DEFAULT_MS
    player.current_speed = 0
    player.move_dir = Vec2:new(0, 0)
    player._move_input = false
    player.face_dir = 1
    player.anim = Anim:new(Resources.Textures.Player, 6, 3)
    player.state = 'walk'
    player.anim:add('idle-right', '1-3', 0.15, true)
    player.anim:add('idle-left', '10-12', 0.15, true)
    player.anim:add('walk-right', '4-6', 0.15, true)
    player.anim:add('walk-left', '7-9', 0.15, true)
    player.anim:play('idle-right')
    return setmetatable(player, self)
end

function Player:draw()
    love.graphics.setColor(1, 0, 1, 1)
    self.collider:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.anim:show(self.collider.pos.x, self.collider.pos.y, 0, 3, 3)
    self.weapon:draw()
    local x = love.mouse.getX()
    if self.collider.pos.x > x then
        self.face_dir = -1
    else
        self.face_dir = 1
    end
end

function Player:getWeaponPivot()
    if self.face_dir == 1 then
        return self.collider.pos.x + PLAYER_WIDTH - 12,
               self.collider.pos.y + PLAYER_HEIGHT - 40
    else
        return self.collider.pos.x + 10, self.collider.pos.y + 40
    end
end

function Player:update(dt)
    if self.collider.vel.x ~= 0 or self.collider.vel.y ~= 0 then
        setState(self, State.walk)
        self.anim:play(self.state)
    else
        setState(self, State.idle)
        self.anim:play(self.state)
    end
    self:inputLoop()
    self:movementLoop()
    self.collider:update(dt)
    self.anim:update(dt)
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

function setState(player, state)
    local dir = 'right'
    if player.face_dir == -1 then dir = 'left' end
    player.state = state .. '-' .. dir
end

return Player
