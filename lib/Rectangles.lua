require "lib.Classes"
require "lib.Vectors"
require "lib.Objects"

Rectangle = class(Object)

function Rectangle:init(x, y, width, height)
  Object.init(self)
  self:setPosition(x, y)
  self:setSize(width, height)
end

function Rectangle:draw()
  local x, y = self:getPosition():unpack()
  local w, h = self:getSize():unpack()
  
  love.graphics.push()
  love.graphics.push()
  Object.draw(self)
  
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill", 0, 0, w, h)
  
  -- Debug: bounding
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("line", 0, 0, w, h)
  
  -- Debug: pivot
  love.graphics.pop()
  love.graphics.setPointSize(5);
  love.graphics.point(x, y);
  
  love.graphics.pop()
end