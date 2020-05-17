local Entity = require('components.entity')

local Weapon = Entity:new()

function Weapon:new(_type, _owner)
    weapon = {type = _type}
    weapon.owner = _owner
    weapon.sprite = _type.sprite
    weapon.scaleX = _type.scaleX
    weapon.scaleY = _type.scaleY
    self.__index = self
    return setmetatable(weapon, self)
end

function Weapon:fire(x, y, theta) end

function Weapon:draw()
    local x, y = self.owner:getWeaponPivot()
    local sx, sy = self.scaleX, self.scaleY
    if self.owner.face_dir == -1 then sx = sx * -1 end
    love.graphics.push()

    local yOff = y + self.type.muzzleX * self.scaleY
    local angle = math.atan((cursorY() - yOff) / (cursorX() - x))
    -- move the origin to weapon's pivot

    love.graphics.translate(x, yOff)
    love.graphics.rotate(angle) -- rotate the canvas around the relative origin
    love.graphics.translate(-x, -yOff) -- move origin back to 0, 0
    love.graphics.draw(Resources.Textures.Weapons.Revolver, x, y, 0, sx, sy)
    love.graphics.pop()
end

return Weapon
