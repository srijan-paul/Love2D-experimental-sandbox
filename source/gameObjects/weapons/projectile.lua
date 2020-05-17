local Projectile = {}
local Collider = require('components/collider')

function Projectile:new(_type, x, y, dmg, speed)
    local newProjectile = {}
    newProjectile.type = _type
    newProjectile.damage = dmg
    makeProjectile(newProjectile, type, x, y)
    return setmetatable(newProjectile, self)
end

function Projectile:draw() 

end

function Projectile:update(dt) end

function makeProjectile(proj, _type, x, y)
    proj.collider = makeCollider(_type, x, y)
    proj.sprite = _type.sprite
    if _type.onImpact then 
        proj.onImpact = type.onImpact
    end
end

function makeCollider(type, x, y)
    if type.collider then
        local c = type.collider
        return
            Collider:new(c.type, x, y, c.w, c.h)
    end
end
