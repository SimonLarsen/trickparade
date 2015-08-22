require("slam.slam")
class = require("middleclass.middleclass")
gamestate = require("hump.gamestate")
timer = require("hump.timer")

Keyboard = require("Keyboard")

WIDTH = 240
HEIGHT = 160
SCALE = 2

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setLineStyle("rough")

	love.window.setMode(WIDTH*SCALE, HEIGHT*SCALE, {vsync = true, fullscreen = false})

	gamestate.registerEvents()
end

function love.update(dt)

end

function love.draw()

end
