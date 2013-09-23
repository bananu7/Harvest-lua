require "point"

Rock = Actor:new()
function Rock:draw()
    drawCircle({x = self.x, y = self.y}, 15, {r=128,g=128,b=128})
end

EnergyLink = Actor:new()
EnergyLink.kind = 'link'
EnergyLink.target = nil
function EnergyLink:draw()
    drawCircle(self.position, 6, {r=220,g=220,b=20})
end

-- new class deriving from Actor
SolarPlant = Actor:new()
SolarPlant.kind = 'solarplant'
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

Harvester = Actor:new()
Harvester.kind = 'harvester'
function Harvester:draw()
    drawCircle(self.position, 12, {r=20,g=170,b=30})
end

EnergyPacket = Actor:new()
EnergyPacket.target = nil
function EnergyPacket:draw()
    drawCircle(self.position, 3, {r=255, g=255, b=0})
end
function EnergyPacket:update()
    local target = self.target
    local possibleTargets = {"harvester", "link", "turret", "solarplant" }
    if target then
        if distance(self.position, target.position) < 5 then
            local bounce = false
            if target.kind == 'link' or target.kind == 'solarplant' then
                bounce = true
            elseif target.kind == 'harvester' and target.energy > 0 then
                bounce = true
            elseif target.kind == 'turret' and target.energy > Turret.maxEnergy then
                bounce = true
            end

            if bounce then
                local neighbours = query(target.position, 100, target.id, possibleTargets)
                if #neighbours > 0 then
                    self.target = neighbours[math.random(1, #neighbours)]
                end
            else
                self.flaggedForDeletion = true
                target.energy = target.energy + 1
            end
        else
            self.position.x = self.position.x + math.cos(direction(self.position, target.position))
            self.position.y = self.position.y + math.sin(direction(self.position, target.position))
        end
    else
        local neighbours = query(self.position, 100, 0, possibleTargets)
        if #neighbours > 0 then
            self.target = neighbours[math.random(1, #neighbours)]
        end
    end
end
