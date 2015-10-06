local function draw(obj) -- recursive
  for _, child in ipairs(obj) do
    if child.draw then child:draw() end
    if child.children then draw(child.children) end
  end
end

local function update(self)
  -- Update self.size and self.offset based on self.children
  if not self:pivotChildren() then return end
  
  local list = {x = {}, y = {}}
  local function collect(obj) -- recursive
    for _, child in ipairs(obj) do
      -- Gather all positions for sorting
      local verts = {
        child:getPivotPosition(0, 0),
        child:getPivotPosition(0, 1),
        child:getPivotPosition(1, 1),
        child:getPivotPosition(1, 0)
      }
      for i = 1, #verts do
        table.insert(list.x, verts[i].x)
        table.insert(list.y, verts[i].y)
      end
      if child.children then collect(child.children) end
    end
  end
  
  -- Find smallest and biggest positions and update self
  collect(self.children)
  table.sort(list.x)
  table.sort(list.y)
  local min  = Vector(list.x[1], list.y[1])
  local max  = Vector(list.x[#list.x], list.y[#list.y])
  
  self.offset = self:getPosition() - min
  self:setSize((max - min):unpack())
end


require "lib.Classes"
require "lib.Vectors"
require "lib.Objects"

Group = class(Object)

function Group:init(...)
  Object.init(self)
  self.offset = Vector(0, 0)
  self._pivotChildren = false
  self.children = {}
  self:addChild(...)
end

function Group:draw()
  local x, y = self:getPosition():unpack()
  local w, h = self:getSize():unpack()
  
  love.graphics.push()
  love.graphics.push()
  love.graphics.push()
  Object.draw(self)
  if self:pivotChildren() then
    love.graphics.pop()
    love.graphics.translate((self.offset):unpack())
  end
  
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

function Group:pivotChildren(tag) -- set & get
  if tag then
    self._pivotChildren = tag
    update(self)
  end
  return self._pivotChildren
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
  
  if self:pivotChildren() then update(self) end
end

function Group:removeChild(obj)
  for id, child in ipairs(self.children) do
    if child == obj then
      table.remove(self.children, id)
      break
    end
  end
  if self:pivotChildren() then update(self) end
end