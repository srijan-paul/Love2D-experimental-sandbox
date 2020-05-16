local Collider = require('Components/collider')
local Vec2 = require('lib/vector2d')
local GameConstants = require('gameconstants')

local Entity = {}

function Entity:new()
    local newEnt = {}
    self.__index = self
    newEnt.sprite_dir = GameConstants.Direction.LEFT
    newEnt.move_dir = Vec2:new(0, 0)
    newEnt.max_speed = 0
    setmetatable(newEnt, self)
    return newEnt
end

function Entity:draw()

end

function Entity:update(dt)
    
end

function Entity:getPos() return self.collider.pos.x, self.collider.pos.y end

function Entity:setPos(x, y) self.collider.pos.x, self.collider.pos.y = x, y end

function Entity:getSize() return self.collider.width, self.collider.height end

return Entity
