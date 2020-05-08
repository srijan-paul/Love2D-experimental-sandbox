local Vector2 = {}

Vector2.__add =
    function(v1, v2) return Vector2:new(v1.x + v2.x, v1.y + v2.y) end

Vector2.__mul =
    function(v1, v2) return Vector2:new(v1.x * v2.x, v1.y * v2.y) end

Vector2.__sub =
    function(v1, v2) return Vector2:new(v1.x - v2.x, v1.y - v2.y) end

Vector2.__unm = function(v) return Vector2:new(-v.x, -v.y) end

Vector2.__eq = function(v1, v2) return v1.x == v2.x and v1.y == v2.y end

Vector2.__tostring =
    function(v) return '{x = ' .. v.x .. ', y = ' .. v.y .. '}' end

function Vector2:new(_x, _y)
    local newVec = {}
    assert(type(_x) == 'number' and type(_y) == 'number',
           'Expected number as vector parameter')
    
    if _x then
        newVec.x = _x
    else
        newVec.x = 0
    end

    if _y then
        newVec.y = _y
    else
        newVec.y = 0
    end
    self.__index = self
    return setmetatable(newVec, self)
end

function Vector2:mag() return math.sqrt(self.x * self.x + self.y * self.y) end

-- test code
-- local v1 = Vector2:new(1, 1)
-- local v2 = Vector2:new(1, 2)
-- print((v1 + v2):mag(), math.sqrt( 13 ))
Vector2.LEFT = Vector2:new(-1, 0)
Vector2.RIGHT = Vector2:new(1, 0)
Vector2.UP = Vector2:new(0, -1)
Vector2.DOWN = Vector2:new(0, 1)
Vector2.ZERO = Vector2:new(0, 0)


return Vector2