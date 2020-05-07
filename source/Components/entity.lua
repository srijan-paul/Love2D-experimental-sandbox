local Collider = require('Components/collider')

local Entity = {}

function Entity:new(x, y, w, h)
    local newEnt = {}
    self.__index = self
    newEnt.collider = Collider:new(x, y, w, h)
    setmetatable(newEnt, self)
    return newEnt
end

function Entity:draw() end

function Entity:update(dt) end

function Entity:getPos() return self.collider.pos.x, self.collider.pos.y end

function Entity:setPos(x, y) self.collider.pos.x, self.collider.pos.y = x, y end

return Entity
