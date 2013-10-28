Harvester = Actor:new()
Harvester.kind = 'harvester'
function Harvester:draw()
    drawCircle(self.position, 12, {r=20,g=170,b=30})
end

return Harvester