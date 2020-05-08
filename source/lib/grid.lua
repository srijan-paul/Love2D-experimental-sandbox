-- Fixed resolution grid for now. TODO: update to quadtree later
local Collider = require('Components/collider')
local GameConstants = require('Components/gameconstants')

local Grid = {}
-- local DEFAULT_ROW_COUNT, DEFAULT_COL_COUNT = 10, 10

function Grid:new(rows, cols) 
    local grid = {}
    self.__index = self
    grid.rows , grid.cols = rows, cols
    grid.cellWidth = GameConstants.SCREEN_WIDTH / grid.cols
    grid.cellHeight = GameConstants.SCREEN_HEIGHT / grid.rows
    grid.cells = {}
    for i = 1, grid.rows do 
        for j = 1, grid.cols do 
            grid.cells[i][j] = {}
        end
    end
    setmetatable(grid, Grid)
    return grid
end

function Grid:insert(body)
    local collider = body.collider
    local pos = body.collider.pos
end

function Grid:query()

end


function Grid:query(x, y, width, height)
    -- TODO
end
