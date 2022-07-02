RoForNoob = RoForNoob or {
  name = 'roForNoob',
  majorVersion = "1",
  minorVersion = "0",
  revisionVersion = 0,
  displayName = "|cffd700RO For|cff0000 NOOB|r|r",
  author = "@|cffd700dov118|r",
  website = 'https://github.com/dov118/roForNoob'
}
local RoForNoob = RoForNoob

function RoForNoob.OnAddOnLoaded(event, addonName)
  if addonName ~= RoForNoob.name then return end

  RoForNoob.savedVariables = ZO_SavedVars:NewAccountWide(RoForNoob.name .. "SavedVariables", 1, RoForNoob.name, {
    lockUI = false,
    left = 100,
    top = 100,
    downColor = {
      r = 1,
      g = 0,
      b = 0,
    },
    ureadyColor = {
      r = 1,
      g = 0,
      b = 1,
    },
    readyColor = {
      r = 0,
      g = 1,
      b = 0,
    },
    almostReadyColor = {
      r = 0,
      g = 0,
      b = 1,
    },
    size = 100
  })

  RoForNoob.Menu.build()
  RoForNoob.UI.build()

  RoForNoob.Listen()

  EVENT_MANAGER:UnregisterForEvent(RoForNoob.name, EVENT_ADD_ON_LOADED)
end

function RoForNoob.onHeavyAttack()
  d('heavy Attack')
end

function RoForNoob.Listen()
  EVENT_MANAGER:RegisterForEvent(RoForNoob.name, EVENT_COMBAT_EVENT, RoForNoob.onHeavyAttack)
  EVENT_MANAGER:AddFilterForEvent(RoForNoob.name, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, 93109)
  EVENT_MANAGER:AddFilterForEvent(RoForNoob.name, EVENT_COMBAT_EVENT, REGISTER_FILTER_COMBAT_RESULT, 2240)
end

-- * EVENT_ADD_ON_LOADED (*string* _addonName_)
EVENT_MANAGER:RegisterForEvent(RoForNoob.name, EVENT_ADD_ON_LOADED, RoForNoob.OnAddOnLoaded)

SLASH_COMMANDS["/rl"] = function()
  ReloadUI("ingame")
end

SLASH_COMMANDS["/pte"] = function()
  ESO_Dialogs.INSTANCE_LEAVE_DIALOG.buttons[1].callback();
end