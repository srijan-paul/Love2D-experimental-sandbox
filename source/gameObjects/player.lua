local Entity = require('Components/entity')
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
    -- remove this weapon code and make it dynamic so a player can pick up 
    -- and throw weapons 
    player.weapon = Weapon:new(WeaponType.Revolver, player)

    -- physics stuff
    player.max_speed = PLAYER_DEFAULT_MS
    player.current_speed = 0
    player.move_dir = Vec2:new(0, 0)
    player._move_input = false
    player.face_dir = 1
    -- instantiate the animations
    player.anim = Anim:new(Resources.Textures.Player, 6, 3)
    player.state = 'walk'
    player.anim:add('idle-right', '1-2', 0.2, true)
    player.anim:add('idle-left', '9-11', 0.15, true)
    player.anim:add('walk-right', '3-5', 0.15, true)
    player.anim:add('walk-left', '6-8', 0.15, true)
    player.anim:play('idle-right')
    return setmetatable(player, self)
end

function Player:draw()
    love.graphics.setColor(1, 0, 1, 1)
    -- self.collider:draw()

    if self.collider.pos.x + self.collider.width / 2 > cursorX() then
        self.face_dir = -1
    else
        self.face_dir = 1
    end

    love.graphics.setColor(1, 1, 1, 1)
    if self.collider.pos.y + self.collider.width < love.mouse.getY() then
        self.anim:show(self.collider.pos.x, self.collider.pos.y, 0, 3, 3)
        self.weapon:draw()
    else
        self.weapon:draw()
        self.anim:show(self.collider.pos.x, self.collider.pos.y, 0, 3, 3)
    end

end

-- returns the position from where the weapon should be displayed
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
    local dir = GameConstants.Direction.RIGHT
    if player.face_dir == -1 then dir = GameConstants.Direction.LEFT end
    player.state = state .. '-' .. dir
end

return Player
