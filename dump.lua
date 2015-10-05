function Group:update()
  -- Update self.size and self.pivot based on self.children
  -- Gather all positions for sorting
  local positions = {x = {}, y = {}}
  for _, obj in ipairs(self.children) do
    local sizeOffset = obj:getPivotOffset()
    local angle = math.rad(obj:getRotation())
    local p1 = (obj:getPivotPosition(0, 0)) -- top left
    local p2 = (obj:getPivotPosition(0, 1)) -- bottom left
    local p3 = (obj:getPivotPosition(1, 1)) -- bottom right
    local p4 = (obj:getPivotPosition(1, 0)) -- top right
    
    table.insert(positions.x, p1.x)
    table.insert(positions.x, p2.x)
    table.insert(positions.x, p3.x)
    table.insert(positions.x, p4.x)
    table.insert(positions.y, p1.y)
    table.insert(positions.y, p2.y)
    table.insert(positions.y, p3.y)
    table.insert(positions.y, p4.y)
  end

  -- Find smallest x and y,
  -- find biggest width and height,
  -- calculate bounding size
  table.sort(positions.x)
  table.sort(positions.y)
  local min  = Vector(positions.x[1], positions.y[1])
  local max  = Vector(positions.x[#positions.x], positions.y[#positions.y])
  local size = max - min
  
  -- Update self.size (again) based on self.rotation
  do
    --code
  end
  
  self:setOffset((self:getPosition() - min):unpack())
  self:setSize(size:unpack())
  self:setPivot((self:getOffset() / self:getSize()):unpack())
end