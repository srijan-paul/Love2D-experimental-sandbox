-- Fixed resolution grid for now. TODO: update to quadtree later
local Collider = require('Components/collider')

local Grid = {}
-- local DEFAULT_ROW_COUNT, DEFAULT_COL_COUNT = 10, 10

function Grid:new(row, col, width, height) 
    local grid = {}
    self.__index = self
    setmetatable(grid, Grid)
    return grid
end

-- query returns all the elements enclosed by the rectangle specified
-- by the parameters


function Grid:query(x, y, width, height)
    -- TODO
end
