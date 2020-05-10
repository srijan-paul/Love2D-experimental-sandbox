local Entity = require("Components/entity")
local Collider = require('Components/collider')
local GameConstants = require('gameconstants')
local World = require('world')
local Player = require('player')

local world
function love.load()
    world = World:new(GameConstants.SCREEN_WIDTH, GameConstants.SCREEN_HEIGHT)
    world:add(Player:new(100, 100))
end

function love.draw()
    world:draw()
end

function love.update(dt)
    world:update(dt)
end

-- function love.mousepressed(x, y)

--     table.insert(ents,
--                  Entity:new(x, y, math.random(10, 30), math.random(10, 30)))
-- end

