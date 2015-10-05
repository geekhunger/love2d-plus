require "lib.Groups"
require "lib.Rectangles"

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  io.stdout:setvbuf("no")
  
  rect1 = Rectangle(10, 10, 100, 100)
  rect1:setPivot(0, 0)
  rect1:setRotation(0)
  
  rect2 = Rectangle(100, 100, 50, 100)
  rect2:setPivot(0, 0)
  rect2:setRotation(0)
  
  grp = Group(rect1, rect2)
  --grp:setPivot(0, 0)
  --grp:setRotation(15)
  print(grp:getPivot(), grp:getSize())
end

function love.draw()
  love.graphics.setBackgroundColor(127, 127, 127)
  grp:draw()
end