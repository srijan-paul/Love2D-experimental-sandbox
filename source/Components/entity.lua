local Collider = require('Components/collider')
local Vec2 = require('lib/vector2d')
local GameConstants = require('gameconstants')

local Entity = {}

function Entity:new(x, y, w, h)
    local newEnt = {}
    self.__index = self
    newEnt.spriteDir = GameConstants.Direction.LEFT
    newEnt.moveDir = Vec2.ZERO
    newEnt.moveSpeed = 0
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
