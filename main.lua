require "lib.prettyprint"
require "lib.Groups"
require "lib.Rectangles"

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  io.stdout:setvbuf("no")
  
  rect1 = Rectangle(200, -100, 100, 100)
  --rect1:setPivot(0, 1)
  --rect1:setRotation(30)
  --rect1:setScale(1, 2)
  
  rect2 = Rectangle(10, 10, 50, 150)
  --rect2:setPivot(1, 1)
  --rect2:setRotation(-30)
  --rect2:setScale(2, .5)
  
  grp = Group(rect2, rect1)
  --grp:setPivot(1, 1)
  --grp:setRotation(30)
  --grp:setScale(4, 1)
  grp:setPosition(5, 5)
  grp:pivotChildren(true)
end

function love.draw()
  love.graphics.setBackgroundColor(127, 127, 127)
  grp:draw()
end