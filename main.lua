function love.load()
  love.window.setMode(512, 512)
  love.mouse.setVisible(false)
  require("imports")
end

function love.update(dt)
  input:update()
  background:tween(dt)
  if gamestate == titlestate then
    title:tween(dt)
    if title.canStart then
      if input:pressed("start") then
        text:init(intermission.image1, 1, "OldeTimey.mp3")
        hud.time = 30
        loadLevel("maps/map" .. text.destination .. ".lua")
        hud.hints = 0
      end
    end
  elseif gamestate == textstate then
    text:update(dt)
  elseif gamestate == playstate then
    hud:update(dt)
    world:update(dt)
    player:update(dt)
    gameLevel:update(dt)
  elseif gamestate == deathstate then
    if input:pressed("start") then
      gamestate = titlestate
      audio:newSong("blacktearag.ogg")
      audio:change(true)
    end
  end
end

function love.draw()
  love.graphics.push()
    love.graphics.scale(2, 2)
    love.graphics.setFont(fontMain)
    --always
    love.graphics.draw(background.image,background.offX1,0)
    love.graphics.draw(background.image,background.offX2,0)

    if gamestate == titlestate then
      love.graphics.draw(title.image, title.x, title.y)
      if title.canStart then
        love.graphics.print("Press \'Enter\'")
      end
    elseif gamestate == textstate then
      text:draw()
    elseif gamestate == playstate then
      camera:attach()
        gameLevel:drawLayer(gameLevel.layers["Layer1"])
        for i, hint in ipairs(hints) do
          if not hint.dead then love.graphics.draw(hintImage, hint:getX()-8, hint:getY()-8) end
        end
        player:draw()
        --world:setQueryDebugDrawing(true)
        --world:draw()
      camera:detach()
      --hud
      love.graphics.draw(hud.image)
      if hud.time <= 10 then love.graphics.setColor(1, 0.5, 0.5) end
      love.graphics.print(math.ceil(hud.time), 35, 12)
      love.graphics.setColor(1, 1, 1)
      love.graphics.print(text.destination or 1, 160, 8)
      love.graphics.print(hud.hints, 81, -1)
    elseif gamestate == deathstate then
      love.graphics.draw(hud.death)
    end
  love.graphics.pop()
end
