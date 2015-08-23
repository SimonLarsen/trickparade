local MinigameScene = class("MinigameScene", Scene)

function MinigameScene:initialize()
	Scene.initialize(self)

	self.time = 5
end

function MinigameScene:getResult()
	return false
end

return MinigameScene
