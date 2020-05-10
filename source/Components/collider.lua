local Vec2 = require('lib/vector2d')
local GameConstants = require('gameconstants')

local Collider = {}

function Collider:new(_x, _y, _w, _h)
    assert(type(_x) == 'number' and type(_y) == 'number',
           'Expected number as collider position')

    assert(type(_w) == 'number' and type(_h) == 'number',
           'Expected number as collider dimension')

    newCollider = {pos = Vec2:new(_x, _y), width = _w, height = _h}
    self.__index = self
    return setmetatable(newCollider, self)
end

function Collider:draw()
    love.graphics.rectangle('line', self.pos.x, self.pos.y, self.width,
                            self.height)
end

function Collider.checkAABB(a, b)
    if a == b then return false end
    return
        not ((a.pos.x > b.pos.x + b.width) or (a.pos.x + a.width < b.pos.x) or
            (a.pos.y + a.height < b.pos.y) or (a.pos.y > b.pos.y + b.height))
end

function Collider.getCollisionDir(a, b)
    local dist = a - b
    if math.abs(dist.x) == math.abs(dist.y) then
        if dist.y > 0 then return GameConstants.Direction.UP end
        return GameConstants.Direction.DOWN
    elseif math.abs(dist.x) < math.abs(dist.y) then
        if (dist.x > 0) then return GameConstants.Direction.RIGHT end
        return GameConstants.Direction.LEFT
    end

    if dist.y > 0 then return GameConstants.Direction.BOTTOM end
    return GameConstants.Direction.TOP
end

return Collider
