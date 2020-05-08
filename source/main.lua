local Entity = require("Components/entity")
local Collider = require('Components/collider')
local GameConstants = require('gameconstants')

local ents = {}
local checkCount = 0
local collisions = 0

function love.load()
    for i = 1, 2000 do
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
    -- brute force. 2000 entities leads to an FPS of 12-18
    sortAndSweepX(ents)
    for i = 1, #ents do ents[i]:update(dt) end

    --[[
        Coordiante sorting :
            create two copies of the list of entities, then
                sort one based on x-coordinate of the entities and the other 
                based on the Y-coordinates.
            then iterate both arrays, check for overlap on each axis.
            If an entity's collider overlaps on both axes with another entity's collider
            then resolve the collision
    --]]

    -- add more entities if mouse is down

    -- if love.mouse.isDown(1) then
    --     local x, y = love.mouse.getX(), love.mouse.getY()
    --     table.insert(ents,
    --                  Entity:new(x + math.random(-30, 30),
    --                             y + math.random(-40, 40), math.random(10, 30),
    --                             math.random(10, 30)))
    -- end
end

-- function love.mousepressed(x, y)

--     table.insert(ents,
--                  Entity:new(x, y, math.random(10, 30), math.random(10, 30)))
-- end

function sortAndSweepX(entities)
    local sortedX = qSort(ents, 'x')
    for i = 1, #sortedX do
        for j = i + 1, #sortedX do
            if sortedX[j].collider.pos.x > sortedX[i].collider.pos.x and
                sortedX[j].collider.pos.x <
                (sortedX[i].collider.pos.x + sortedX[i].collider.width) then
                checkCount = checkCount + 1
                if Collider.checkAABB(sortedX[i].collider, sortedX[j].collider) then
                    -- sortedX[i].hit = true
                    -- sortedX[j].hit = true
                    collisions = collisions + 1
                end
            else
                break
            end
        end
    end
end

function bruteForce(entities)
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
end

function qSort(bodies, dimension)
    local copy = {}
    for i = 1, #bodies do copy[i] = bodies[i] end
    _qSort(copy, dimension, 1, #copy)
    return copy
end

function _qSort(list, dimension, lo, hi)
    if #list < 2 or lo >= hi then return list end
    -- overflow in this scenario is highly unlikely so I'll 
    -- just go with this approach.
    local pivot = list[math.floor((lo + hi) / 2)]
    local l, r = lo, hi

    while l <= r do
        while list[l].collider.pos[dimension] < pivot.collider.pos[dimension] do
            l = l + 1
        end
        while list[r].collider.pos[dimension] > pivot.collider.pos[dimension] do
            r = r - 1
        end
        if l <= r then
            list[l], list[r] = list[r], list[l]
            l = l + 1
            r = r - 1
        end
    end
    _qSort(list, dimension, lo, r)
    _qSort(list, dimension, l, hi)
end
