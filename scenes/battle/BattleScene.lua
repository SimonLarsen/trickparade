local BattleScene = class("BattleScene", Scene)

local Controller = require("scenes.battle.Controller")

function BattleScene:initialize()
	Scene.initialize(self)

	self:add(Controller())
end

return BattleScene
