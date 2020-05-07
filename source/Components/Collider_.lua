local Vec2 = require('lib/vector2d')

local Collider = {}

local ColliderShapes = {Point = 'point', Rect = 'rectangle', Circle = 'circle'}

function Collider:new(type, _x, _y, _w, _h)
    assert(type(_x) == 'number' and type(_y) == 'number',
           'Expected number as collider position')

    newCollider = {pos = Vec2:new(_x, _y)}
    self.__index = self

    if type == ColliderShapes.Circle then
        newCollider.radius = _w
    elseif type == ColliderShapes.Rectangle then
        newCollider.width, newCollider.height = _w, _h
    elseif type ~= ColliderShapes.Point then
        error('Collider shape must be rectangle, circle or point')
    end

    return setmetatable(newCollider, self)
end

function Collider.checkCollision(a, b)
    if a.type == 'point' then
        if b.type == 'point' then
            return cdPointPoint(a, b)
        elseif b.type == 'rectangle' then
            return cdPointRect(a, b)
        elseif b.type == 'circle' then
            return cdPointCirc(a, b)
        end
    elseif a.type == 'rectangle' then
        if b.type == 'point' then
            return cdPointRect(b, a)
        elseif b.type == 'rectangle' then
            return cdRectRect(a, b)
        elseif b.type == 'circle' then
            return cdCircRect(b, a)
        end
    elseif a.type == 'circle' then
        if b.type == 'point' then
            return cdPointCirc(b, a)
        elseif b.type == 'rectangle' then
            return cdCircRect(a, b)
        elseif b.type == 'circle' then
            return cdCircCirc(a, b)
        end
    end
end

function cdPointPoint(p1, p2)
    return p1.pos.x == p2.pos.x and p1.pos.y == p2.pos.y
end

function cdRectRect(r1, r2)
    return not ((r1.pos.x > r2.pos.x + r2.width) or
               (r1.pos.x + r1.width < r1.pos.x) or
               (r1.pos.y + r1.height < r2.pos.y) or
               (r1.pos.y > r2.pos.y + r2.height));
end

function cdCircCirc(c1, c2)
    return (c2.pos - c1.pos):mag() <= c1.radius + c2.radius
end

function cdPointCirc(p, c) return (c.pos - p.pos):mag() > c.radius end

function cdPointRect(p, r)
    -- todo: implement this
    return false
end

function cdCircRect(c, r)
    local rCenter = vec2:new(r.pos.x + r.width / 2, r.pos.y + r.height / 2)
    local dist = rCenter - c.pos
    
end
