local Entity = require("Components/entity")
local Collider = require('Components/collider')
local GameConstants = require('gameconstants')
local World = require('world')
local Player = require('gameObjects.player')
local Resources = require('resources')

local world

function love.load()
    Resources.load()
    cursor = Resources.Texture.Cursor
    love.mouse.setVisible(false)
    world = World:new(GameConstants.SCREEN_WIDTH, GameConstants.SCREEN_HEIGHT)
    world:add(Player:new(200, 400))
end

function love.draw()    
    love.graphics.draw(cursor, love.mouse.getX(), love.mouse.getY(), 0, 1.5, 1.5)
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

-- function love.load()

-- end

-- local x,y = 100, 100

-- function love.draw()
--     love.graphics.rectangle('fill', x, y, 40, 40)
-- end

-- function love.update(dt)
--     if love.keyboard.isDown('d') then
--         x = x + 20
--     end

--     if love.keyboard.isDown('a') then
--         x = x - 20
--     end
--     if love.keyboard.isDown('s') then
--         y = y + 20
--     end

--     if love.keyboard.isDown('w') then
--         y = y - 20
--     end
-- end
