local Entity = require('components.entity')

local Weapon = Entity:new()
Weapon.REVOLVER = 1

function Weapon:new(_type, _owner)
    weapon = {type = _type}
    self.owner = _owner
    self.__index = self
    return setmetatable(weapon, self)
end

function Weapon:fire(x, y, theta) end

function Weapon:draw()
    local dy = love.mouse.getY() - self.owner.collider.pos.y
    local dx = love.mouse.getX() - self.owner.collider.pos.x
    local angle = math.atan(dy / dx)

    local x = self.owner.collider.pos.x + 50
    local y = self.owner.collider.pos.y + 10
   
    love.graphics.setColor(1, 1, 0, 1)
    love.graphics.push()

    -- move the origin to weapon's pivot
    love.graphics.translate(x, y)
    love.graphics.rotate(angle) -- rotate the canvas around the relative origin
    love.graphics.translate(-x, -y) -- move origin back to 0, 0
    love.graphics.rectangle('fill', x, y, 100, 20)
    love.graphics.pop()
end

return Weapon
