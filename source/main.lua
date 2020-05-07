local Entity = require("Components/Entity")
local Collider = require('Components/Collider')

local ent = Entity:new(10, 10, 100, 50)
local ent2 = Entity:new(70, 70, 50, 100)

function love.load() end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    drawEnt(ent)
    if Collider.checkAABB(ent.collider, ent2.collider) then
        love.graphics.setColor(1, 0, 0, 1)
    end
    drawEnt(ent2)
end

function love.update(dt) ent:setPos(love.mouse.getX(), love.mouse.getY()) end

function drawEnt(ent)
    local x, y = ent:getPos()
    love.graphics.rectangle('fill', x, y, ent.collider.width, ent.collider.height)
end
