require "point"

units = { }

if js then
    local file_prefix = "units/"
    local files = { }--"harvester", "energy_link", "energy_packet", "rock", "solar_plant" }
    for _,file in ipairs(files) do
        units[file] = dofile(file_prefix .. file)
        --print ("loaded "..file.." as ")
        --for k,v in pairs(units[file]) do print(k,v) end
    end
else 
    require'lfs'

    for file in lfs.dir[[./units]] do
        --print ("checking file " .. file)
        if lfs.attributes("./units/"..file,"mode") == "file" then 
           --print ("is a file " .. file)
           if string.sub(file, -4, -1) == ".lua" then
                --print("loading file, "..file)      
                local unit = dofile("./units/" .. file)
            
                if not unit.kind then
                    error "Loaded unit didn't export its kind"
                end
                
                units[unit.kind] = unit
           end
        end 
    end
end

return units




