local GUIComponent = require("gui.GUIComponent")
local MinigameFactory = require("scenes.battle.MinigameFactory")
local Transition = require("transition.CurtainsTransition")

local Controller = class("Controller", GUIComponent)

Controller.static.STATE_SELECT = 0
Controller.static.STATE_GAME = 1
Controller.static.STATE_GAME_TRANSITION = 2
Controller.static.STATE_ATTACK = 3
Controller.static.STATE_COUNTER = 4

local names = {
	"GHOST",
	"SPLATTER",
	"CRITTER"
}

function Controller:initialize(player, enemy)
	GUIComponent.initialize(self, 0, 0, 0, "battlecontroller")

	self.player = player
	self.enemy = enemy

	self.player_hp = 100
	self.player_hp_bar = self.player_hp
	self.enemy_hp = 100
	self.enemy_hp_bar = self.enemy_hp


	self.state = Controller.static.STATE_SELECT
	self.selection = 1
	self.time = 0
	self.shakex = 0
	self.shakey = 0
	self.next_shake = 0

	self.completed = false
	self.success = false

	self.active = { false, false, false }

	self.bg = Resources.getImage("battle/bg.png")
	self.cursor = Resources.getImage("battle/cursor.png")
	self.font = Resources.getImageFont("small.png")
	self.font_gothic16 = Resources.getFont("gothic.ttf", 16)
	self.font_gothic32 = Resources.getFont("gothic.ttf", 32)
end

function Controller:enter()
	self.scene:add(Transition(Transition.static.IN, 1))
end

function Controller:update(dt)
	self.player_hp_bar = math.movetowards(self.player_hp_bar, self.player_hp, 50*dt)
	self.enemy_hp_bar = math.movetowards(self.enemy_hp_bar, self.enemy_hp, 50*dt)

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
				self.state = Controller.static.STATE_GAME_TRANSITION
				self.time = 2
			else
				self:attack()
				self.state = Controller.static.STATE_SELECT
			end
		end
	
	elseif self.state == Controller.static.STATE_GAME_TRANSITION then
		self.time = self.time - dt
		if self.time <= 0 then
			self:startMinigame()
		end

		self.next_shake = self.next_shake - dt
		if self.next_shake <= 0 then
			self.next_shake = 1/(30+4*self.hits)
			self.shakex = love.math.randomNormal(self.hits/10, 0)
			self.shakey = love.math.randomNormal(self.hits/10, 0)
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
	timer.add(0.5, function()
		self.enemy_hp = self.enemy_hp - 2*self.hits^2
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
	
	elseif self.state == Controller.static.STATE_GAME_TRANSITION then
		love.graphics.setColor(0, 0, 0, 128)
		love.graphics.setFont(self.font_gothic32)
		love.graphics.printf(self.hits, 2+self.shakex, 56+self.shakey, WIDTH, "center")
		love.graphics.setFont(self.font_gothic16)
		love.graphics.printf("SCARES!", 2+self.shakex, 86+self.shakey, WIDTH, "center")

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(self.font_gothic32)
		love.graphics.printf(self.hits, self.shakex, 54+self.shakey, WIDTH, "center")
		love.graphics.setFont(self.font_gothic16)
		love.graphics.printf("SCARES!", self.shakex, 84+self.shakey, WIDTH, "center")
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
	love.graphics.rectangle("fill", WIDTH-8-self.enemy_hp_bar, 20, self.enemy_hp_bar, 4)
	love.graphics.rectangle("fill", 8, HEIGHT-12, self.player_hp_bar, 4)
end

function Controller:isCompleted()
	return self.completed
end

function Controller:isSuccess()
	return self.success
end

return Controller
