local Entity = require('components.entity')

local Weapon = Entity:new()
Weapon.REVOLVER = 1

function Weapon:new(_type)
    weapon = {type = _type}
    self.__index = self
    return setmetatable(weapon, self)
end

function Weapon:fire(x, y, theta)
    
end

function Weapon:show()

end

return Weapon