love.graphics.setDefaultFilter("nearest", "nearest")

--states
titlestate = 1
playstate = 2
deathstate = 3
textstate = 4

gamestate = titlestate

death = love.audio.newSource("audio/death.ogg", "static")
collect = love.audio.newSource("audio/collect.ogg", "static")

require("audio")
require("text")
baton = require("lib.baton")
require("input")
audio:newSong("blacktearag.ogg")
wf = require("lib.windfield")
cam = require("lib.camera")
sti = require("lib.sti")
require("level")

camera = cam()

world = wf.newWorld()
world:addCollisionClass("hint")
world:addCollisionClass("wall")
world:addCollisionClass("death")
world:addCollisionClass("player", {ignores = {"hint", "death"}})

require("player")
player:load()

title = {x=-50, y=100}
background = {offX1=0, offX2=256}

--images

require("hud")

title.image = love.graphics.newImage("graphics/JohnHouse.png")
background.image = love.graphics.newImage("graphics/Background.png")
intermission = {}
intermission.image1 = love.graphics.newImage("graphics/Intro.png")
intermission.image2 = love.graphics.newImage("graphics/End.png")

hintImage = love.graphics.newImage("graphics/hint.png")

function title:tween(dt)
  if self.y > -150 then
    self.y = self.y - 50*dt
    --background.y = background.y + 6*dt
  elseif self.y < -150 then
    self.y = -150
  else
    self.canStart = true
    audio:change(true)
  end
end

function background:tween(dt)
  self.offX1 = self.offX1 - 5*dt
  self.offX2 = self.offX2 - 5*dt

  if self.offX2 < 0 then
    self.offX1 = 0
    self.offX2 = 256
  end
end

fontMain = love.graphics.newFont("graphics/KiwiSoda.ttf", 16)
fontMain:setFilter("nearest", "nearest")
