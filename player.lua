player = world:newBSGRectangleCollider(10,10,14,14,1)
player:setFixedRotation(true)
player:setCollisionClass("player")

function player:load()
  self.image = love.graphics.newImage("graphics/Player.png")
  self.dir = "right"
end

function player:update(dt)
  self.vX, self.vY = 0, 0

  if input:down("up") then
    self.vY = -64
  end
  if input:down("down") then
    self.vY = 64
  end
  if input:down("left") then
    self.vX = -64
    self.dir = "left"
  end
  if input:down("right") then
    self.vX = 64
    self.dir = "right"
  end

  self:setLinearVelocity(self.vX, self.vY)

  local querys = world:queryRectangleArea(self:getX() - 7, self:getY() - 7, 14, 14, {"hint"})
  if querys[1] then
    querys[1]:destroy()
    querys[1].dead = true
    hud.hints = hud.hints + 1
    if collect:isPlaying() then collect:stop() end
    collect:play()
    if hud.time < 27.5 then
      hud.time = hud.time + 2.5
    else
      hud.time = 30
    end
  end

  local querys = world:queryRectangleArea(self:getX() - 7, self:getY() - 7, 14, 14, {"death"})
  if querys[1] then
    death:play()
    player:setPosition(gameLevel.properties["spawnX"]*16, gameLevel.properties["spawnY"]*16)
  end

  camera.x = self:getX()+136
  camera.y = self:getY()+136

  if camera.x < 256 then
    camera.x = 256
  end
  if camera.y < 228 then
    camera.y = 228
  end

  if camera.x > gameLevel.width*16 then
    camera.x = gameLevel.width*16
  end

  if camera.y > gameLevel.height*16 then
    camera.y = gameLevel.height*16
  end
end

function player:draw()
  if self.dir == "left" then
    love.graphics.draw(self.image, math.floor(self:getX())-8, math.floor(self:getY())-8)
  else
    love.graphics.draw(self.image, math.floor(self:getX())-8, math.floor(self:getY())-8, 0, -1, 1, 16)
  end
end
