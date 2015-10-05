require "lib.Classes"
require "lib.Vectors"
require "lib.Objects"

Group = class(Object)

function Group:init(...)
  Object.init(self)
  self.offset = Vector(0, 0)
  self.children = {}
  self:addChild(...)
end

local function draw(children)
  for _, child in ipairs(children) do
    if child.draw then child:draw() end
    if child.children then draw(child.children) end
  end
end

function Group:draw()
  local x, y = self:getPosition():unpack()
  local w, h = self:getSize():unpack()
  
  love.graphics.push()
  love.graphics.push()
  Object.draw(self)
  love.graphics.translate(self:getOffset():unpack())
  
  draw(self.children)
  
  -- Debug: bounding
  love.graphics.setColor(255, 255, 0)
  love.graphics.rectangle("line", 0, 0, w, h)
  
  -- Debug: pivot
  love.graphics.pop()
  love.graphics.setPointSize(7);
  love.graphics.point(x, y);
  
  love.graphics.pop()
end

function Group:update()
  -- Update self.size and self.pivot based on self.children
  -- Gather all positions for sorting
  local positions = {x = {}, y = {}}
  for _, obj in ipairs(self.children) do
    local pos = obj:getPosition()
    local p1 = (obj:getPivotPosition(0, 0)) -- top left
    local p2 = (obj:getPivotPosition(0, 1)) -- bottom left
    local p3 = (obj:getPivotPosition(1, 1)) -- bottom right
    local p4 = (obj:getPivotPosition(1, 0)) -- top right
    
    table.insert(positions.x, p1.x)
    table.insert(positions.x, p2.x)
    table.insert(positions.x, p3.x)
    table.insert(positions.x, p4.x)
    table.insert(positions.y, p1.y)
    table.insert(positions.y, p2.y)
    table.insert(positions.y, p3.y)
    table.insert(positions.y, p4.y)
  end

  -- Find smallest x and y,
  -- find biggest width and height,
  -- calculate bounding size
  table.sort(positions.x)
  table.sort(positions.y)
  local min  = Vector(positions.x[1], positions.y[1])
  local max  = Vector(positions.x[#positions.x], positions.y[#positions.y])
  local size = max - min
  
  -- Update self.size (again) based on self.rotation
  do
    --code
  end
  
  self:setOffset((self:getPosition() - min):unpack())
  self:setSize(size:unpack())
  self:setPivot((self:getOffset() / self:getSize()):unpack())
end

function Group:addChild(...)
  for _, child in ipairs{...} do
    assert(child.is_a and child:is_a(Object), "Wrong argument types (<Group>:addChild(<Object>, ...) expected)")
    
    local duplicateId = false
    for i = 1, #self.children do
      if child == self.children[i] then
        duplicateId = i
        break
      end
    end
    
    if duplicateId then
      -- Update drawing order
      table.insert(self.children, self.children[duplicateId])
      table.remove(self.children, duplicateId)
    else
      -- Add child
      child.parent = self
      table.insert(self.children, child)
    end
  end
  
  self:update()
end

function Group:removeChild(obj)
  for id, child in ipairs(self.children) do
      if child == obj then
        table.remove(self.children, id)
        break
      end
    end
    self:update()
end

function Group:setOffset(x, y)
  self.offset.x = x
  self.offset.y = y
  return self:getOffset()
end

function Group:getOffset()
  return self.offset
end