text = {}

function text:init(image, destination, newSong)
  self.image = image
  self.y = 256
  self.destination = destination
  gamestate = textstate
  changeSong = newSong
end

function text:update(dt)
  self.y = self.y - 25*dt
  if self.destination > 4 then
    if self.y < -80 then
      self.y = -80
      return
    end
  end

  if self.y < -275 then
    gamestate = playstate
    self.y = 256
    if changeSong then
      audio:change()
      audio:newSong(changeSong)
      audio:change(true)
    end
  end
  if self.y < 240 and input:pressed("start") then
    self.y = -256
  end
end

function text:draw()
  love.graphics.draw(self.image, 0, self.y)
end
