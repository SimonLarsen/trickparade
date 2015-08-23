local GUIComponent = require("gui.GUIComponent")
local MinigameFactory = require("scenes.battle.MinigameFactory")
local Transition = require("transition.CurtainsTransition")

local Controller = class("Controller", GUIComponent)

Controller.static.STATE_SELECT = 0
Controller.static.STATE_GAME = 1
Controller.static.STATE_ATTACK = 2
Controller.static.STATE_COUNTER = 3

local names = {
	"GHOST",
	"SPLATTER",
	"CRITTER"
}

function Controller:initialize()
	GUIComponent.initialize(self)

	self.player_hp = 100
	self.enemy_hp = 100

	self.state = Controller.static.STATE_SELECT
	self.selection = 1

	self.active = { false, false, false }

	self.bg = Resources.getImage("battle/bg.png")
	self.cursor = Resources.getImage("battle/cursor.png")
	self.font = Resources.getImageFont("small.png")
end

function Controller:update(dt)
	if self.state == Controller.static.STATE_SELECT then
		if Keyboard.wasPressed(Config.KEY_UP) then if self.selection == 4 then self.selection = 2 end end
		if Keyboard.wasPressed(Config.KEY_DOWN) then self.selection = 4 end
		if Keyboard.wasPressed(Config.KEY_LEFT) then if self.selection ~= 4 then self.selection = math.max(1, self.selection-1) end end
		if Keyboard.wasPressed(Config.KEY_RIGHT) then if self.selection ~= 4 then self.selection = math.min(3, self.selection+1) end end 

		if Keyboard.wasPressed(Config.KEY_ACTION) then
			if self.selection <= 3 then self.active[self.selection] = not self.active[self.selection] end
			if self.selection == 4 then
				self.hits = 0
				self:startMinigame()
			end
		end
	elseif self.state == Controller.static.STATE_GAME then
		local controller = self.minigame:find("minigamecontroller")
		if controller:isCompleted() then
			if controller:isSuccess() then
				self.hits = self.hits + 1
				self:attack()
				self.state = Controller.static.STATE_ATTACK
			else
				self.state = Controller.static.STATE_SELECT
			end
		end
	elseif self.state == Controller.static.STATE_ATTACK then

	end
end

function Controller:startMinigame()
	self.state = Controller.static.STATE_GAME
	self.minigame = MinigameFactory.random(self.active)
	self.scene:add(Transition(Transition.static.OUT, 0.5))
	timer.add(0.5, function()
		gamestate.push(self.minigame)
		self.scene:add(Transition(Transition.static.IN, 0.5))
	end)
end

function Controller:attack()
	self.enemy_hp = self.enemy_hp - 2*self.hits^2
	timer.add(2, function()
		self:startMinigame()
	end)
end

function Controller:gui()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.bg, 0, 0)

	if self.state == Controller.static.STATE_SELECT then
		-- Draw toggle buttons
		for i=1,3 do
			love.graphics.setColor(255, 255, 255)
			if self.active[i] then
				self:drawButtonActive(WIDTH/2 - 110 + (i-1)*75, HEIGHT/2-30, 70, 20)
			else
				self:drawButton(WIDTH/2 - 110 + (i-1)*75, HEIGHT/2-30, 70, 20)
			end
			love.graphics.setColor(0, 0, 0)
			love.graphics.printf(names[i], WIDTH/2 - 110 + (i-1)*75, HEIGHT/2-24, 70, "center")
			love.graphics.setColor(0, 0, 0)
		end

		-- Draw SCARE button
		love.graphics.setColor(255, 255, 255)
		self:drawButton(WIDTH/2 - 30, HEIGHT/2, 60, 30)
		love.graphics.setColor(0, 0, 0)
		love.graphics.printf("SCARE!", WIDTH/2 - 30, HEIGHT/2+11, 60, "center")

		-- Draw cursor
		love.graphics.setColor(255, 255, 255)
		if self.selection <= 3 then
			love.graphics.draw(self.cursor, WIDTH/2 - 55 + (self.selection-1)*75, HEIGHT/2-25)
		else
			love.graphics.draw(self.cursor, WIDTH/2 + 15, HEIGHT/2+15)
		end
	end

	love.graphics.setColor(255, 255, 255)
	self:drawBox(0, HEIGHT-32, WIDTH, 32)
	self:drawBox(0, 0, WIDTH, 32)

	-- Draw player/enemy names
	love.graphics.setFont(self.font)
	love.graphics.printf("BULLY", 8, 8, WIDTH-16, "right")
	love.graphics.printf("PLAYER", 8, HEIGHT-24, WIDTH-16, "left")

	-- Draw health bars
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", WIDTH-108, 20, 100, 4)
	love.graphics.rectangle("fill", 8, HEIGHT-12, 100, 4)

	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", WIDTH-8-self.enemy_hp, 20, self.enemy_hp, 4)
	love.graphics.rectangle("fill", 8, HEIGHT-12, self.player_hp, 4)
end

return Controller
