require "point"

Rock = { }
function Rock:new(o)
    o = Actor:new(o)
    o.draw = function(self)
        drawCircle({x = self.x, y = self.y}, 15, {r=128,g=128,b=128})
    end
    return o
end

EnergyLink = { 
	target = nil
}
function EnergyLink:new(o)
	o = Actor:new(o)
	o.draw = function(self)
		drawCircle(self.position, 6, {r=220,g=220,b=20})
	end
	return o
end
function EnergyLink:update()
	local target = self.target
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
				local neighbours = Game.query(target.position, 100, target.id,
											  {"harvester", "link", "turret", "solarplant" })
				if #neighbours > 0 then
					target = neighbours[math.random(1, #neighbours)]
				end
			else
				self = nil
				target.energy = target.energy + 1
			end
		else
			self.position.x = self.position.x + math.cos(direction(self.position, target.position))
			self.position.y = self.position.y + math.sin(direction(self.position, target.position))
		end
	end
end

SolarPlant = { }
function SolarPlant:new(o)
	o = Actor:new(o)
	o.draw = function(self)
		drawCircle(self.position, 30, {r=116,g=40,b=148})
	end
	return o
end

Harvester = { }
function Harvester:new(o)
	o = Actor:new(o)
	o.draw = function(self)
		drawCircle(self.position, 12, {r=20,g=170,b=30})
	end
	return o
end

EnergyPacket = { }
function EnergyPacket:new(o)
	o = Actor:new(o)
	o.draw = function(self)
		drawCircle(self.position, 3, {r=255, g=255, b=0})
	end
end

