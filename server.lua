local copas = require'copas'

function echo_fun(ws) 
    while true do
        local message = ws:receive()
        if message then
           print("received: " .. message)
           ws:send(message)
        else
           print("closing socket")
           ws:close()
           return
        end
    end
end

-- create a copas webserver and start listening
local server = require'websocket'.server.copas.listen
{
    -- listen on port 8080
    port = 8080,
    -- the protocols field holds
    --   key: protocol name
    --   value: callback on new connection
    protocols = {
    -- this callback is called, whenever a new client connects.
    -- ws is a new websocket instance
        echo = echo_fun
    },
    --default = echo_fun
}

-- use the copas loop
copas.loop()