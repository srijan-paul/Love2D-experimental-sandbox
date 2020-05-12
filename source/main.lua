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
    show_stats()
    world:draw()
end

function love.update(dt) world:update(dt) end

function show_stats()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', 0, 0, 200, 100)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(love.timer.getFPS(), 10, 10)
end
