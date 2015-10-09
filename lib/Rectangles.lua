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
  love.graphics.push()
  Object.draw(self)
    
    local w, h = self:getSize():unpack()
    
    -- Rectangle
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 0, 0, w, h)
    
    -- Debug: bounding
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("line", 0, 0, w, h)
    
    -- Debug: pivot
    love.graphics.setPointSize(5);
    love.graphics.point(self:getPivotOffset():unpack());
    
  love.graphics.pop()
end