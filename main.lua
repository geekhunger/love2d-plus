require "lib.Groups"
require "lib.Rectangles"

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  io.stdout:setvbuf("no")
  
  rect1 = Rectangle(30, 30, 100, 100)
  --rect1:setPivot(0, 1)
  --rect1:setRotation(30)
  --rect1:setScale(1, 2)
  print(rect1:getPivotPosition(0, 0), rect1:getPivotPosition())
  
  rect2 = Rectangle(110, 110, 50, 150)
  --rect2:setPivot(0, 0)
  --rect2:setRotation(-30)
  --rect2:setScale(2, .5)
  
  grp = Group(rect1, rect2)
  --grp:setPivot(1, 1)
  --grp:setRotation(30)
  grp:setPosition(5, 5)
  grp:pivotChildren(true)
  --grp:setScale(4, 1)
  --print(grp:getPivot(), grp:getPosition(), grp.offset, grp:getSize())
end

function love.draw()
  love.graphics.setBackgroundColor(127, 127, 127)
  grp:draw()
end