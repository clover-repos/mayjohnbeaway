function loadMapColliders(layer, tableN, class)
  if gameLevel.layers[layer] then
    for i, obj in ipairs(gameLevel.layers[layer].objects) do
      local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)

      collider.height = obj.height
      collider.width = obj.width

      if class then
        collider:setCollisionClass(class)
      end

      collider:setType("static")

      collider.name = obj.name

      table.insert(tableN, collider)
    end
  end
end

function removeMapColliders(table)
  for i = 1, #table do
    if table[i].dead then return end
    table[i]:destroy()
  end
end
