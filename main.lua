require "lib.prettyprint"
require "lib.Groups"
require "lib.Rectangles"

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  io.stdout:setvbuf("no")
  
  rect1 = Rectangle(-20, -20, 20, 20)
  rect2 = Rectangle(100, 150, 50, 150)
  rect3 = Rectangle(0, 0, 50, 150)
  
  grp = Group(rect2, rect1)
  --grp:pivotChildren(true)
  
  wrapper = Group(rect3, grp)
  wrapper:pivotChildren(true)
end

function love.draw()
  love.graphics.setBackgroundColor(127, 127, 127)
  wrapper:draw()
end