EnergyPacket = Actor:new()
EnergyPacket.kind = "energy_packet"
EnergyPacket.target = nil
function EnergyPacket:draw()
    drawCircle(self.position, 3, {r=255, g=255, b=0})
end
function EnergyPacket:update()
    local target = self.target
    local possibleTargets = {"harvester", "energy_link", "turret", "solar_plant" }
    if target then
        if distance(self.position, target.position) < 5 then
            local bounce = false
            if target.kind == 'energy_link' or target.kind == 'solar_plant' then
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

return EnergyPacket