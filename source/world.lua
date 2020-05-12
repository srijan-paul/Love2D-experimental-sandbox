local Grid = require('lib/grid')
local World = {}
local TIME_STEP = 0.022

function World:new()
    world = {}
    world.entities = {}
    world._accumulatedTime = 0
    world.grid = Grid:new(3, 3, world)
    world.friction = 0.01
    self.__index = self
    return setmetatable(world, self)
end

function World:update(dt)
    self._accumulatedTime = self._accumulatedTime + dt
    if self._accumulatedTime >= TIME_STEP then
        self._accumulatedTime = 0
        for i = 1, #self.entities do self.entities[i]:update(dt) end
        self.grid:update(dt)
    end
end

function World:draw()
    for i = 1, #self.entities do self.entities[i]:draw() end
    self.grid:draw()
end

function World:add(ent)
    table.insert(self.entities, ent)
    ent.world = self
    self.grid:insert(ent)
end

function World:query(x, y, w, h)
    --[[
        1. quick sort all the entities in the world by their x coordinates
        2. use binary search to find the index of the entity whose position is 
            **just** more than or equal to x.
        3. iterate the sorted array startting from that index and then test all entities
            in that range for collision until an entity with it's x outside of the query rect is 
            found. store all the colliding entities in an array and then return it
    --]]

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
