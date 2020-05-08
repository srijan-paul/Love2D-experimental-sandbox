-- yeah I'll implement this one later. for now let's just go with
-- a constant grid

local Collider = require('Collider')

local Quadtree = {}
local DEFAULT_MAX_ELEMENTS

function Quadtree:new(x, y, _width, _height, maxElems)
    local qTree = {width = _width, height = _height}
    self.__index = self
    qTree.x, qTree.y = x, y
    qTree.divided = false
    self.count = 0
    self.bodies = {}
    qTree.maxElements = maxElems or DEFAULT_MAX_ELEMENTS
    return setmetatable(qTree, self)
end

function Quadtree:setPos(x, y) self.x, self.y = x, y end

function Quadtree:split()
    self.topRight = Quadtree:new(self.x + self.width / 2, self.y,
                                 self.width / 4, self.height / 4,
                                 self.maxElements)
    self.bottomRight = Quadtree:new(self.x + self.width / 2,
                                    self.y + self.height / 2, self.width / 4,
                                    self.height / 4, self.maxElements)

    self.bottomLeft = Quadtree:new(self.x, self.y + self.height / 2,
                                   self.width / 4, self.height / 4,
                                   self.maxElements)

    self.topLeft = Quadtree:new(self.x, self.y, self.width / 4, self.height / 4,
                                self.maxElements)
    self.divided = true
end

function Quadtree:insert(body)
    if not self:intersects(body) then return false end
    if #self.bodies < self.maxElements then
        table.insert(self.bodies, body)
        return true
    end
    if not self.divided then self:split() end
end

function Quadtree:clear()
    self.counts = 0
    self.bodies = {}
    if self.divided then
        self.topRight:clear()
        self.topLeft:clear()
        self.bottomLeft:clear()
        self.bottomRight:clear()
    end
    self.topRight = nil
    self.topLeft = nil
    self.bottomLeft = nil
    self.bottomRight = nil
end

function Quadtree:indexOf(body) 

end
