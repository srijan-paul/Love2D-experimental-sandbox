local Vector2 = {}

Vector2.__add =
    function(v1, v2) return Vector2:new(v1.x + v2.x, v1.y + v2.y) end

Vector2.__mul = function(v1, v2)
    if type(v1) == 'number' then return Vector2:new(v1 * v2.x, v1 * v2.y) end
    if type(v2) == 'number' then return Vector2:new(v2 * v1.x, v2 * v1.y) end
    return Vector2:new(v1.x * v2.x, v1.y * v2.y)
end

Vector2.__sub =
    function(v1, v2) return Vector2:new(v1.x - v2.x, v1.y - v2.y) end

Vector2.__unm = function(v) return Vector2:new(-v.x, -v.y) end

Vector2.__eq = function(v1, v2) return v1.x == v2.x and v1.y == v2.y end

Vector2.__tostring =
    function(v) return '{x = ' .. v.x .. ', y = ' .. v.y .. '}' end

Vector2.__lt = function(v1, v2) return v1:mag() < v2:mag() end

Vector2.__le = function(v1, v2) return v1:mag() <= v2:mag() end

Vector2.__gt = function(v1, v2) return v1:mag() < v2:mag() end

Vector2.__ge = function(v1, v2) return v1:mag() >= v2:mag() end

function Vector2:new(_x, _y)
    local newVec = {}
    assert(type(_x) == 'number' and type(_y) == 'number',
           'Expected number as vector parameter')

    newVec.x, newVec.y = _x, _y
    self.__index = self
    return setmetatable(newVec, self)
end

function Vector2:mag() return math.sqrt(self.x * self.x + self.y * self.y) end

function Vector2:normalized()
    local root = math.sqrt(self.x * self.x + self.y * self.y)
    if root == 0 then return Vector2:new(0, 0) end
    return Vector2:new(self.x / root, self.y / root)
end

function Vector2:setMag(n)
    local root = math.sqrt(self.x * self.x + self.y * self.y)
    self.x = n * (self.x / root)
    self.y = n * (self.y / root)
end

-- test code
-- local v1 = Vector2:new(1, 1)
-- local v2 = Vector2:new(1, 2)
-- print(v2 * 2)

Vector2.LEFT = function() return Vector2:new(-1, 0) end
Vector2.RIGHT = function() return Vector2:new(1, 0) end
Vector2.UP = function() return Vector2:new(0, -1) end
Vector2.DOWN = function() return Vector2:new(0, 1) end
Vector2.ZERO = function() return Vector2:new(0, 0) end

return Vector2
