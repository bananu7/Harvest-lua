require "point"

-- drawing functions
function drawSquare(point, size, color)
    local x = point.x
    local y = point.y
    size = size/2
    gl.Color(color.r/255, color.g/255, color.b/255)
    gl.Begin('QUADS')
    gl.Vertex(x-size, y-size)
    gl.Vertex(x+size, y-size)
    gl.Vertex(x+size, y+size)
    gl.Vertex(x-size, y+size)
    gl.End()
end

function drawCircle(point, radius, color)
    -- works if using pixel units
    local repeats = radius * 2 * 3.1416
    local step = (1/repeats) * 2 * 3.1416
    local theta = 0.0
    
    gl.Color(color.r/255, color.g/255, color.b/255)
    gl.Begin('TRIANGLE_FAN')
    for i = 1,repeats do 
        local x = point.x + radius * math.cos(theta)
        local y = point.y + radius * math.sin(theta)
        gl.Vertex(x, y)
        theta = theta + step
    end
    gl.End()
end

function distance (x1,y1,x2,y2) 
	local x = x2-x1
	local y = y2-y1
	return math.sqrt(x*x + y*y)
end

-- harvest game logic
Actor = {
    id = nil,
    position = Point(0,0),
    kind = "actor", -- turret, rock, plant
}
lastActorId = 1
function Actor:new(o)
    o = o or { }
    setmetatable(o, self)
    self.__index = self
    
    o.id = lastActorId
	o.position = Point(0,0)
    lastActorId = lastActorId + 1
    return o
end

---------------------
-- Actual game logic

objects = { }
clickmode = 'idle' -- 'build_turret' etc.

function update()
    for _,object in ipairs(objects) do
        object:update()
    end
end

function draw()
    for _,object in ipairs(objects) do
        object:draw()
    end
end

require"units"

function mouse_callback(but, pressed, x, y, status)
	if but == iup.BUTTON3 and pressed==1 then clickmode = 'idle' end

	local modemappings = {
		build_harvester = Harvester,
		build_energylink = EnergyLink,
		build_solarplant = SolarPlant
	}
	if but == iup.BUTTON1 and pressed==1 then
		if clickmode ~= 'idle' then
			print ("building "..clickmode)
			o = modemappings[clickmode]:new()
			o.position.x, o.position.y = x,y
			table.insert(objects, o)
		end
	end
end

function keyboard_callback(key)
	if key == iup.K_r then clickmode = 'build_harvester' end
	if key == iup.K_s then clickmode = 'build_solarplant' end
	if key == iup.K_e then clickmode = 'build_energylink' end
end


