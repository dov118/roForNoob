RoForNoob = {}
RoForNoob.savedVariables = {}

local function OnCombatEvent(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)
    if abilityId == 93109 and result == 2240 then
        updateTime(21);
    end
end

local function Initialize()
    RoForNoob.savedVariables = ZO_SavedVars:NewAccountWide("RoForNoobSavedVariables", 1, nil, {})

    EVENT_MANAGER:RegisterForEvent('UnitCombatEvent', EVENT_COMBAT_EVENT, OnCombatEvent)
    EVENT_MANAGER:RegisterForEvent('hideRo', EVENT_RETICLE_HIDDEN_UPDATE, hideRo)

    RoForNoob:ClearAnchors()
    RoForNoob:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, RoForNoob.savedVariables.left, RoForNoob.savedVariables.top)
end

function hideRo(_, hide)
    if RoForNoob.savedVariables.camMove == false then
        RoForNoob:SetHidden(hide)
    end
end

function updateTime(time)
    RoForNoobLabel:SetColor(255, 255, 255, 1.0)
    RoForNoobLabel:SetText(time)
    local nextTime = time - 0.1

    EVENT_MANAGER:RegisterForUpdate("updateTimeLoop", 100, function()
        if nextTime > 1.5 then
            RoForNoobLabel:SetText('|c28a745' .. math.abs(math.floor((nextTime * 10^2) + 0.5) / (10^2)))
            nextTime = nextTime - 0.1
        end

        if nextTime <= 1.5 and nextTime > 0 then
            RoForNoobLabel:SetColor(220, 53, 69, 1.0)
            RoForNoobLabel:SetText('|cffc107' .. math.abs(math.floor((nextTime * 10^2) + 0.5) / (10^2)) .. " (On se prépare !!)")
            nextTime = nextTime - 0.1
        end

        if nextTime <= 0 then
            RoForNoobLabel:SetText("|cdc3545Trop tard Zebi !!")
            EVENT_MANAGER:UnregisterForUpdate("updateTimeLoop")
        end
    end)
end

function OnIndicatorMoveStop()
  RoForNoob.savedVariables.left = RoForNoob:GetLeft()
  RoForNoob.savedVariables.top = RoForNoob:GetTop()
end

EVENT_MANAGER:RegisterForEvent('UnitLoaded', EVENT_ADD_ON_LOADED, Initialize)
EVENT_MANAGER:RegisterForEvent('UnitActivated', EVENT_PLAYER_ACTIVATED, Initialize)

SLASH_COMMANDS["/rl"] = function()
    ReloadUI("ingame")
end

SLASH_COMMANDS["/pte"] = function()
    ESO_Dialogs.INSTANCE_LEAVE_DIALOG.buttons[1].callback();
end

SLASH_COMMANDS["/vipi"] = function()
    d("C'est carré ca")
end

SLASH_COMMANDS["/dov"] = function()
    d("I'm loki")
end

SLASH_COMMANDS["/oo"] = function()
    d("Zebi")
end

SLASH_COMMANDS["/hircine"] = function()
    d("Micronder les hemorrhoides")
end

SLASH_COMMANDS["/shin"] = function()
    d("Mais grooooss")
end

SLASH_COMMANDS["/khintos"] = function()
    d("Ah les femmes, faut toujours qu'elles ouvrent leurs gueules !")
end

SLASH_COMMANDS["/maeana"] = function()
    d("")
end

SLASH_COMMANDS["/moveoo"] = function()
    RoForNoob.savedVariables.camMove = not RoForNoob.savedVariables.camMove

    if RoForNoob.savedVariables.camMove == true then
        RoForNoob:SetHidden(false)
    end
end