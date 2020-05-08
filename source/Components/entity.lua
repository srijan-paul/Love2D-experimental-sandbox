local Collider = require('Components/collider')
local Vec2 = require('lib/vector2d')
local GameConstants = require('gameconstants')

local Entity = {}

function Entity:new(x, y, w, h)
    local newEnt = {}
    self.__index = self
    newEnt.spriteDir = GameConstants.Direction.LEFT
    newEnt.moveDir = Vec2.ZERO
    newEnt.collider = Collider:new(x, y, w, h)
    newEnt.moveSpeed = 0
    newEnt.hit = false
    newEnt.r, newEnt.g, newEnt.b = math.random(), math.random(), math.random()
    setmetatable(newEnt, self)
    return newEnt
end

function Entity:draw()
    if self.hit then
        love.graphics.setColor(1, 1, 1)
        self.hit = false
    else
        love.graphics.setColor(self.r, self.g, self.b)
    end
    local x, y = self.collider.pos.x, self.collider.pos.y
    local width, height = self.collider.width, self.collider.height
    love.graphics.rectangle('fill', x, y, width, height)
end

function Entity:update(dt)
    local x, y = self:getPos()
    self:setPos(x + (-2 + math.random() * 4), y + (-2 + math.random() * 4))
end

function Entity:getPos() return self.collider.pos.x, self.collider.pos.y end

function Entity:setPos(x, y) self.collider.pos.x, self.collider.pos.y = x, y end

function Entity:getSize() return self.collider.width, self.collider.height end

return Entity
