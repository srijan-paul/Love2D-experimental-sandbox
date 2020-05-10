local rect = {}

function rect:new(_x, _y, _width, _height)
    local newRect = {x = _x, y = _y, width = _width, height = _height}
    return setmetatable(newRect, rect)
end

function rect:intersects()

end

return rect
