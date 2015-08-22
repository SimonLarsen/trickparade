require("slam.slam")
class = require("middleclass.middleclass")
gamestate = require("hump.gamestate")
timer = require("hump.timer")

Scene = require("Scene")
Entity = require("Entity")
Keyboard = require("Keyboard")
Resources = require("Resources")
Config = require("Config")

WIDTH = 240
HEIGHT = 160
TILEW = 16
SCALE = 3

local canvas

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setLineStyle("rough")

	love.window.setMode(WIDTH*SCALE, HEIGHT*SCALE, {vsync = true, fullscreen = false})

	canvas = love.graphics.newCanvas(WIDTH, HEIGHT)

	Resources.initialize()

	gamestate.registerEvents()
	gamestate.push(require("scenes.world.WorldScene")())
end

function love.gui()
	gamestate.current():gui()
end

function love.keypressed(k)
	Keyboard.keypressed(k)
end

function love.keyreleased(k)
	Keyboard.keyreleased(k)
end

function love.run()
	if love.math then
		love.math.setRandomSeed(os.time())
		for i=1,3 do love.math.random() end
	end

	if love.event then
		love.event.pump()
	end

	if love.load then love.load(arg) end

	if love.timer then love.timer.step() end

	local dt = 0

	while true do
		if love.event then
			love.event.pump()
			for e,a,b,c,d in love.event.poll() do
				if e == "quit" then
					if not love.quit or not love.quit() then
						if love.audio then
							love.audio.stop()
						end
						return
					end
				end
				love.handlers[e](a,b,c,d)
			end
		end

		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end

		if love.update then love.update(dt) end

		Keyboard.clear()

		if love.window and love.graphics and love.window.isCreated() then
			love.graphics.clear()
			love.graphics.origin()

			canvas:clear(0, 0, 0, 255)
			love.graphics.setCanvas(canvas)

			love.draw()
			love.gui()

			love.graphics.scale(SCALE, SCALE)
			love.graphics.setCanvas()
			love.graphics.draw(canvas, 0, 0)

			love.graphics.present()
		end

		if love.timer then love.timer.sleep(0.001) end
	end
end
