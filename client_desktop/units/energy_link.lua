EnergyLink = Actor:new()
EnergyLink.kind = 'energy_link'
EnergyLink.target = nil
function EnergyLink:draw()
    drawCircle(self.position, 6, {r=220,g=220,b=20})
end

return EnergyLink