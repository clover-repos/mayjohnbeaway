require("collHandler")

function loadLevel(map)
  --Unload old map
  hud.hints = 0

  if walls then
    removeMapColliders(walls)
  end
  if deaths then
    removeMapColliders(deaths)
  end
  if hints then
    removeMapColliders(hints)
  end
  hints = {}
  walls = {}
  deaths = {}

  gameLevel = sti(map) --Load new map
  loadMapColliders("Walls", walls, "wall")
  loadMapColliders("Hints", hints, "hint")
  loadMapColliders("Deaths", deaths, "death")

  player:setPosition(gameLevel.properties["spawnX"]*16, gameLevel.properties["spawnY"]*16)
  hud.time = 30
end
