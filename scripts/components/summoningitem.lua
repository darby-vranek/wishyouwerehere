
local SummoningItem = Class(function(self, inst)
	self.inst = inst
end)

function SummoningItem:CollectInventoryActions(doer, actions)
	table.insert(actions, ACTIONS.CASTSUMMON)
end

function SummoningItem:CollectUseActions(doer, target, actions)
	table.insert(actions, ACTIONS.CASTUNSUMMON)
end

return SummoningItem
