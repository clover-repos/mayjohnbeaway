audio = {}

function audio:newSong(song)
  if audio.theme then audio.theme:stop() end

  self.theme = love.audio.newSource("audio/" .. song, "stream")
  self.theme:setLooping(true)
end

function audio:change(bool)
  if bool and not self.theme:isPlaying() then
    self.theme:play()
  elseif not bool then
    self.theme:stop()
  end
end
