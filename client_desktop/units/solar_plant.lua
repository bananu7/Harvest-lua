SolarPlant = Actor:new()
SolarPlant.kind = 'solar_plant'
function SolarPlant:draw()
    drawCircle(self.position, 30, {r=116,g=40,b=148})
end
function SolarPlant:update()
    if self.energy > 100 then 
        self.energy = 0
        local p = EnergyPacket:new()
        p.position = Point(self.position.x, self.position.y)
        table.insert(objects, p)
    else
        self.energy = self.energy + 1
    end
end

return SolarPlant