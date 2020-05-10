-- Fixed resolution grid for now. 
--TODO: test against a quadtree later

local Collider = require('components/collider')
local GameConstants = require('gameconstants')

local Grid = {}
-- local DEFAULT_ROW_COUNT, DEFAULT_COL_COUNT = 10, 10

function Grid:new(rows, cols)
    local grid = {}
    self.__index = self
    grid.rows, grid.cols = rows, cols
    grid.cellWidth = GameConstants.SCREEN_WIDTH / grid.cols
    grid.cellHeight = GameConstants.SCREEN_HEIGHT / grid.rows
    grid.cells = {}
    for i = 1, grid.rows do
        grid.cells[i] = {}
        for j = 1, grid.cols do grid.cells[i][j] = {} end
    end
    setmetatable(grid, Grid)
    return grid
end

function Grid:insert(body)
    local collider = body.collider
    local pos = body.collider.pos
    --[[ finding the row and column of the min and max cell locations.
        An entity can span multiple grid cells, so I need to find out :
        -> the row and column where the TOP_LEFT corner of the entity ends up 
        -> the last column that the entity takes up
        -> the last row that the entity takes up
    --]]

    local row = math.floor(pos.x / self.cellWidth) + 1
    local col = math.floor(pos.x / self.cellHeight) + 1
    local maxCol = math.floor((pos.x + collider.width) / self.cellWidth) + 1
    local maxRow = math.floor((pos.y + collider.height) / self.cellHeight) + 1
    local x, y = row, col
    for i = row, maxRow do
        for j = col, maxCol do table.insert(self.cells[i][j], body) end
    end
end

function Grid:draw()
    love.graphics.setColor(1, 0.3, 0.3, 0.4)
    for i = 1, self.rows do
        love.graphics.line(0, i * self.cellHeight, GameConstants.SCREEN_WIDTH,
                           i * self.cellHeight)
    end
    for i = 1, self.cols do
        love.graphics.line(i * self.cellWidth, 0, i * self.cellWidth,
                           GameConstants.SCREEN_HEIGHT)

    end
end

function Grid:update(dt)
    
end

function Grid:query(x, y, width, height)
    -- TODO
end

return Grid
