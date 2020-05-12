local Grid = require('lib/grid')
local World = {}
local TIME_STEP = 0.016

function World:new()
    world = {}
    world.entities = {}
    world.grid = Grid:new(2, 3, world)
    world.friction = 0.01
    world.time_lag = 0
    self.__index = self
    return setmetatable(world, self)
end

function World:update(dt)
    self.time_lag = self.time_lag + dt
    while self.time_lag >= TIME_STEP do
        self._accumulatedTime = 0
        self:_update()
        self.time_lag = self.time_lag - TIME_STEP
    end
end

function World:draw()
    for i = 1, #self.entities do self.entities[i]:draw() end
    self.grid:draw()
end

function World:_update()
    self.grid:clear()
    for i = 1, #self.entities do
        local ent = self.entities[i]
        ent:update(dt)
        ent.collider.pos = ent.collider.pos + ent.collider.vel
        self.grid:insert(ent)
    end
end

function World:add(ent)
    table.insert(self.entities, ent)
    ent.world = self
    self.grid:insert(ent)
end

function World:query(x, y, w, h)
    return self.grid:query(x, y, w, h)
end

--[[
    Below this point lies code that has absolutely no need 
    to exist, but I'm too afraid to delete it because who knows
    when I might need it
--]]

function sortAndSweepX(entities)
    local sortedX = qSort(entities, 'x')
    for i = 1, #sortedX do
        for j = i + 1, #sortedX do
            if sortedX[j].collider.pos.x > sortedX[i].collider.pos.x and
                sortedX[j].collider.pos.x <
                (sortedX[i].collider.pos.x + sortedX[i].collider.width) then
                if Collider.checkAABB(sortedX[i].collider, sortedX[j].collider) then
                    -- sortedX[i].hit = true
                    -- sortedX[j].hit = true
                end
            else
                break
            end
        end
    end
end

function bSearchJustLessThan(arr, num)
    local lo, hi = 1, #arr
    -- corner case for when number is outside of array bounds
    if num < arr[lo].collider.pos.x or num > arr[hi].collider.pos.x then
        return -1
    end
    while lo < hi do
        local mid = (lo + hi) / 2
        if arr[mid].collider.pos.x == num then return mid end

        if arr[mid].collider.pos.x < num then
            lo = mid + 1
        else
            if mid > 1 then end
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

return World