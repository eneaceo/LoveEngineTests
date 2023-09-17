-- External libraries.
Object = require 'Libs/classic'
Input = require 'Libs/input'
Timer = require 'Libs/timerenhanced'


-- Run once at the start of the program.
function love.load()
    -- Initialize required object files.
    local object_files = {}
    RecursiveEnumerate('Objects', object_files)
    RequireFiles(object_files)
   
    CircleInstance = HyperCircle:new( 400, 300, 50, 10, 120)

    InputInstance = Input()
    InputInstance:bind('+', 'add')
    Sum = 0

    TimerInstance = Timer()
    TimerInstance:every(2, function() print(love.math.random()) end)

    Background = love.graphics.newImage('Assets/Background.png')
end




-- Enumerates all files inside a given folder 
-- and adds them as strings to a table.
function RecursiveEnumerate(folder, file_list)
    -- Lists all files and folders in the given folder 
    -- and returns them as a table of strings.
    local items = love.filesystem.getDirectoryItems(folder)
    -- Iterates and gets the full file path of each item 
    -- by concatenating the folder string and the item string.
    -- (concatenation of strings in Lua is done by using ..)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        -- Full path is used to check if it is a file or a directory.
        if love.filesystem.getInfo(file,"file") then
            table.insert(file_list, file)
        elseif love.filesystem.getInfo(file, "directory") then
            RecursiveEnumerate(file, file_list)
        end
    end
end


-- Iterate over the files and call require.
function RequireFiles(files)
    for _, file in ipairs(files) do
        -- remove the '.lua' from the end of the string.
        local file = file:sub(1, -5)
        require(file)
        -- If we dont want global classes uncomment this.
        --local last_forward_slash_index = file:find("/[^/]*$")
        --local class_name = file:sub(last_forward_slash_index+1, #file)
        -- Global table _G, holds references to all global variables in Lua.
        --_G[class_name] = require(file)
    end
end


-- Run every frame.
function love.update(dt)
    TimerInstance:update(dt)
    CircleInstance:update(dt)
    if InputInstance:pressed('add', 0.25) then Sum = Sum + 1 end
   --  print(Sum)
end


-- Run every frame.
function love.draw()
    love.graphics.draw(Background, 0, 0)
    CircleInstance:draw()
end