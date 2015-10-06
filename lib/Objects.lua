require "lib.Classes"
require "lib.Vectors"

Object = class()

function Object:init()
  self.position = Vector(0, 0)
  self.pivot = Vector(0, 0)
	self.size = Vector(0, 0)
  self.scale = Vector(1, 1)
  self.rotation = 0
end

function Object:draw()
  local angle  = math.rad(self:getRotation())
  love.graphics.translate((-self:getScale():permul(self:getPivotOffset()):rotate(angle)):unpack())
  love.graphics.rotate(angle)
  love.graphics.translate(self:getPosition():rotate(-angle):unpack())
  love.graphics.scale(self:getScale():unpack())
end

function Object:setPivot(cx, cy)
	self.pivot.x = math.max(0, math.min(1, cx))
  self.pivot.y = math.max(0, math.min(1, cy))
  return self:getPivot()
end

function Object:setPosition(x, y)
	self.position.x = x
	self.position.y = y
  return self:getPosition()
end

function Object:setSize(width, height)
  self.size.x = width
  self.size.y = height
  return self:getSize()
end

function Object:setScale(x, y)
  self.scale.x = x
  self.scale.y = y
  return self:getScale()
end

function Object:setRotation(angle)
  self.rotation = angle
  return self:getRotation()
end

function Object:getPivot()
	return self.pivot
end

function Object:getPivotPosition(x, y)
  return self:getPosition() + self:getPivotOffset(x, y)
end

function Object:getPivotOffset(x, y)
  local pivot = self:getPivot()
  x = x or pivot.x
  y = y or pivot.y
  return self:getSize():permul(Vector(x, y))
end

function Object:getPosition()
	return
    self.position,
    self.position - self:getPivotOffset()
end

function Object:getSize()
  return self:getScale():permul(self.size)
end

function Object:getScale()
  return self.scale
end

function Object:getRotation()
  return self.rotation
end