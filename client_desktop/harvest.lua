
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

-- harvest game logic
Actor = {
    id = nil,
    x = 0, y = 0,
    kind = nil, -- turret, rock, plant
}
lastActorId = 1
function Actor:new(o)
    o = o or { }
    setmetatable(o, self)
    self.__index = self
    
    o.id = lastActorId
    lastActorId = lastActorId + 1
    return o
end

Rock = { }
function Rock:new(o)
    o = Actor:new(o)
    o.draw = function(self)
        --drawSquare({x = self.x, y = self.y}, 5, {r=128,g=128,b=128})
        drawCircle({x = self.x, y = self.y}, 50, {r=128,g=128,b=128})
    end
    return o
end


objects = { }

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

r = Rock:new()
r.x, r.y = 100, 100
table.insert(objects, r)