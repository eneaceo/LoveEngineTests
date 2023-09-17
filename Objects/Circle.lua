Circle = Object:extend()


function Circle:new(x, y, radius)
    self.x = x or 0
    self.y = y or 0
    self.radius = radius or 50
    self.time = love.timer.getTime()
    return self
end


function Circle:update(dt)
    self.time = self.time + dt
end


function Circle:draw()
    love.graphics.print(tostring(self.time), 100, 100)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

return Circle