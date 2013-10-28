Rock = Actor:new()
function Rock:draw()
    drawCircle({x = self.x, y = self.y}, 15, {r=128,g=128,b=128})
end

return Rock