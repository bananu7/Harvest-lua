
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

