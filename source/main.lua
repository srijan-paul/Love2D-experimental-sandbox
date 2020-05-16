local Entity = require("Components/entity")
local Collider = require('Components/collider')
local GameConstants = require('gameconstants')
local World = require('world')
local Player = require('gameObjects.player')
local util = require('lib.util')

local world

function love.load()
    Resources.load()
    cursor = Resources.Textures.Cursor
    love.mouse.setVisible(false)
    world = World:new(GameConstants.SCREEN_WIDTH, GameConstants.SCREEN_HEIGHT)
    world:add(Player:new(200, 400))
    love.graphics.setBackgroundColor(util.hexToColor('#3B3B98'))
end

function love.draw()    
    love.graphics.draw(cursor, love.mouse.getX(), love.mouse.getY(), 0, 3, 3)
    show_stats()
    world:draw()
end

function love.update(dt) world:update(dt) end

function show_stats()
    -- love.graphics.setColor(1, 0, 1, 0.4)
    -- love.graphics.rectangle('fill', 0, 0, 200, 100)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. love.timer.getFPS(), 10, 10, 0, 1.2, 1.2)
    love.graphics.print('Memory: ' .. collectgarbage('count'), 10, 25, 0, 1.2,
                        1.2)
end
