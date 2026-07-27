hud = {time = 30, level = 1}
hud.image = love.graphics.newImage("graphics/HUD.png")
hud.death = love.graphics.newImage("graphics/dead.png")
hud.hints = 0

function hud:update(dt)
  self.time = self.time - 1*dt
  if self.time <= 0 then
    gamestate = deathstate
    death:play()
  end

  if self.hints == 3 then
    self.hints = 0
    text.destination = text.destination + 1
    if text.destination < 5 then
      loadLevel("maps/map" .. text.destination .. ".lua")
    else
      audio:change()
      audio:newSong("blacktearag.ogg")
      audio:change(true)
      text:init(intermission.image2, 6)
    end
  end
end
