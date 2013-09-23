Rock = { }
function Rock:new(o)
    o = Actor:new(o)
    o.draw = function(self)
        drawCircle({x = self.x, y = self.y}, 15, {r=128,g=128,b=128})
    end
    return o
end

EnergyLink = { }
function EnergyLink:new(o)
	o = Actor:new(o)
	o.draw = function(self)
		drawCircle({x = self.x, y = self.y}, 6, {r=220,g=220,b=20})
	end
	return o
end

SolarPlant = { }
function SolarPlant:new(o)
	o = Actor:new(o)
	o.draw = function(self)
		drawCircle({x = self.x, y = self.y}, 30, {r=116,g=40,b=148})
	end
	return o
end

Harvester = { }
function Harvester:new(o)
	o = Actor:new(o)
	o.draw = function(self)
		drawCircle({x = self.x, y = self.y}, 12, {r=20,g=170,b=30})
	end
	return o
end

