local BattleScene = class("BattleScene", Scene)

local Controller = require("scenes.battle.Controller")

function BattleScene:initialize(player, enemy)
	Scene.initialize(self)

	self:add(Controller(player, enemy))
end

return BattleScene
