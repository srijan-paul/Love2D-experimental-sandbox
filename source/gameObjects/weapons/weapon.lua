local Entity = require('components.entity')

local Weapon = Entity:new()

function Weapon:new(_type, _owner)
    weapon = {type = _type}
    weapon.owner = _owner
    weapon.sprite = _type.sprite
    self.__index = self
    return setmetatable(weapon, self)
end

function Weapon:fire(x, y, theta) end

function Weapon:draw()
    local w = self.owner.collider.width
    local h = self.owner.collider.height
    local dy = love.mouse.getY() - self.owner.collider.pos.y + h / 2
    local dx = love.mouse.getX() - self.owner.collider.pos.x + w / 2
    local angle = math.atan(dy / dx)

    local x,y = self.owner:getWeaponPivot()
    -- love.graphics.circle('fill', self.owner.collider.pos.x + w / 2,
    --                      self.owner.collider.pos.y + h / 2, 10)
    love.graphics.push()

    -- move the origin to weapon's pivot
    love.graphics.translate(x, y)
    love.graphics.rotate(angle) -- rotate the canvas around the relative origin
    love.graphics.translate(-x, -y) -- move origin back to 0, 0
    love.graphics.draw(Resources.Textures.Weapons.Revolver, x, y, 0, 0.5, 0.5)
    love.graphics.pop()
end

return Weapon
