require "lib.Classes"
require "lib.Vectors"
require "lib.Objects"

Group = class(Object)

function Group:init(...)
  Object.init(self)
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
end

function Group:removeChild(obj)
  for id, child in ipairs(self.children) do
      if child == obj then
        table.remove(self.children, id)
        break
      end
    end
end