local Projectile = {}
local Collider = require('components/collider')

function Projectile:new(_type, x, y, dmg, speed)
    local newProjectile = {}
    newProjectile.type = _type
    newProjectile.damage = dmg
    makeProjectile(newProjectile, type)
    return setmetatable(newProjectile, self)
end

function Projectile:draw() end

function Projectile:update(dt) end

function makeProjectile(proj, _type)
    proj.collider = makeCollider(_type)
    proj.sprite = _type.sprite
    if _type.onImpact then 
        proj.onImpact = type.onImpact
    end
    if _type.
end

function makeCollider(type)
    if type.collider then
        local c = type.collider
        return
            Collider:new(c.type, c.x, c.y, c.w, c.h)
    end
end
