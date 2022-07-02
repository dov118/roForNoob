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

local function OnCombatEvent(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)
  if abilityId == 93109 and result == 2240 then
    updateTime(21);
  end
end

function RoForNoob.OnAddOnLoaded(event, addonName)
  if addonName ~= RoForNoob.name then return end

  RoForNoob.savedVariables = ZO_SavedVars:NewAccountWide(RoForNoob.name .. "SavedVariables", 1, RoForNoob.name, {
    lockUI = false,
    left = 500,
    top = 500,
    downColor = {
      r = 0.8117647171,
      g = 0,
      b = 0.0588235296,
    },
    ureadyColor = {
      r = 1,
      g = 0.7529411912,
      b = 0.0235294122,
    },
    readyColor = {
      r = 0,
      g = 0.6000000238,
      b = 0.2627451122,
    },
    almostReadyColor = {
      r = 0,
      g = 0.4784313738,
      b = 1,
    },
    size = 60
  })

  RoForNoob.Menu.build()
  RoForNoob.UI.build()

  RoForNoob.Listen()

  EVENT_MANAGER:UnregisterForEvent(RoForNoob.name, EVENT_ADD_ON_LOADED)
end

function RoForNoob.Listen()
  EVENT_MANAGER:RegisterForEvent('UnitCombatEvent', EVENT_COMBAT_EVENT, OnCombatEvent)
end

function updateTime(time)
  local nextTime = time - 0.1

  EVENT_MANAGER:RegisterForUpdate("updateTimeLoop", 100, function()
    RoForNoob.UI.updateTimerValue(math.abs(math.floor((nextTime * 10^2) + 0.5) / (10^2)))
  end)
end

function updateTime(time)
  local nextTime = time - 0.1

  EVENT_MANAGER:RegisterForUpdate("updateTimeLoop", 100, function()
    if nextTime > 0 then
      RoForNoob.UI.updateTimerValue(math.abs(math.floor((nextTime * 10^2) + 0.5) / (10^2)))
      nextTime = nextTime - 0.1
    end

    if nextTime <= 0 then
      RoForNoob.UI.updateTimerValue(0)
      EVENT_MANAGER:UnregisterForUpdate("updateTimeLoop")
    end
  end)
end

-- * EVENT_ADD_ON_LOADED (*string* _addonName_)
EVENT_MANAGER:RegisterForEvent(RoForNoob.name, EVENT_ADD_ON_LOADED, RoForNoob.OnAddOnLoaded)

SLASH_COMMANDS["/rl"] = function()
  ReloadUI("ingame")
end

SLASH_COMMANDS["/pte"] = function()
  ESO_Dialogs.INSTANCE_LEAVE_DIALOG.buttons[1].callback();
end