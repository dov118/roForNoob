local RoForNoob = {}

function RoForNoob.AddOnLoaded(_, _)
  d("AddOnLoaded")
  RoForNoob.savedVariables = ZO_SavedVars:NewAccountWide("roForNOOBSavedVariables", 1, {})
end

EVENT_MANAGER:RegisterForEvent('EsolikeMineCollectionLoaded', EVENT_ADD_ON_LOADED, RoForNoob.AddOnLoaded)

SLASH_COMMANDS["/rfnMove"] = function()
  d('rfnMove')
end