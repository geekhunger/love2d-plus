require "lib.Groups"
require "lib.Rectangles"

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  io.stdout:setvbuf("no")
  
  rect1 = Rectangle(100, 100, 100, 100)
  rect1:setPivot(0, 1)
  --rect1:setRotation(10)
  --rect1:setScale(4, 1)
  
  rect2 = Rectangle(10, 10, 50, 150)
  rect2:setPivot(0, 0)
  --rect2:setRotation(45)
  --rect2:setScale(.5, .5)
  
  grp = Group(rect1, rect2)
  grp:setPivot(1, 1)
  --grp:setRotation(30)
  --grp:setScale(2, .5)
  grp:setPosition(10, 10)
  print(grp:getPivot(), grp:getPosition(), grp:getSize())
end

function love.draw()
  love.graphics.setBackgroundColor(127, 127, 127)
  grp:draw()
end