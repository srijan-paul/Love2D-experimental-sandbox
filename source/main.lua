local Entity = require("Components/entity")
local Collider = require('Components/collider')
local GameConstants = require('gameconstants')

local ents = {}
local checkCount = 0
local collisions = 0

function love.load()
    for i = 1, 1000 do
        table.insert(ents, Entity:new(math.random(GameConstants.SCREEN_WIDTH),
                                      math.random(GameConstants.SCREEN_HEIGHT),
                                      math.random(10, 30), math.random(10, 30)))
    end
end

function love.draw()
    for i = 1, #ents do ents[i]:draw() end
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', 0, 0, 200, 100)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('FPS: ' .. love.timer.getFPS(), 10, 10)
    love.graphics.print('body count: ' .. #ents, 10, 20)
    love.graphics.print('checks: ' .. checkCount, 10, 30)
    love.graphics.print('collisions: ' .. collisions, 10, 40)
    love.graphics.print('detection: Brute force', 10, 50)
end

function love.update(dt)
    checkCount = 0
    collisions = 0
    for i = 1, #ents do
        for j = i + 1, #ents do
            if i == j then goto continue end
            checkCount = checkCount + 1
            if Collider.checkAABB(ents[i].collider, ents[j].collider) then
                -- ents[i].hit = true
                -- ents[j].hit = true
                collisions = collisions + 1
            end
            ::continue::
        end
    end
    for i = 1, #ents do ents[i]:update(dt) end

    if love.mouse.isDown(1) then
        local x, y = love.mouse.getX(), love.mouse.getY()
        table.insert(ents,
                     Entity:new(x + math.random(-30, 30),
                                y + math.random(-40, 40), math.random(10, 30),
                                math.random(10, 30)))
    end
end

-- function love.mousepressed(x, y)

--     table.insert(ents,
--                  Entity:new(x, y, math.random(10, 30), math.random(10, 30)))
-- end
