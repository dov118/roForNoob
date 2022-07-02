RoForNoob = RoForNoob or {}
local RoForNoob = RoForNoob

RoForNoob.UI = RoForNoob.UI or {}

function RoForNoob.UI.build()
  RoForNoob.UI.frame = WINDOW_MANAGER:CreateTopLevelWindow("RoForNoob")
  RoForNoob.UI.frame:SetHidden(false)
  RoForNoob.UI.frame:SetDimensions(RoForNoob.savedVariables.size, RoForNoob.savedVariables.size)
  RoForNoob.UI.frame:SetHandler("OnMoveStop", RoForNoob.UI.OnMoveStop)
  RoForNoob.UI.frame:SetMouseEnabled(not RoForNoob.savedVariables.lockUI)
  RoForNoob.UI.frame:SetMovable(not RoForNoob.savedVariables.lockUI)
  RoForNoob.UI.frame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, RoForNoob.savedVariables.left, RoForNoob.savedVariables.top)

  RoForNoob.UI.Timer = WINDOW_MANAGER:CreateControl("RoForNoobTimer", RoForNoob.UI.frame, CT_LABEL)
  RoForNoob.UI.Timer:SetVerticalAlignment(TEXT_ALIGN_CENTER)
  RoForNoob.UI.Timer:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
  RoForNoob.UI.Timer:SetHidden(false)
  RoForNoob.UI.Timer:SetAnchor(CENTER, RoForNoob.UI.frame, CENTER)
  RoForNoob.UI.Timer:SetDimensions(RoForNoob.savedVariables.size, RoForNoob.savedVariables.size)
  RoForNoob.UI.Timer:SetFont(string.format('%s|%d|%s', '$(MEDIUM_FONT)', math.floor((RoForNoob.savedVariables.size * 0.6)+0.5), 'soft-shadow-thick'))
  RoForNoob.UI.Timer:SetText("0")
  RoForNoob.UI.Timer:SetColor(RoForNoob.savedVariables["downColor"].r, RoForNoob.savedVariables["downColor"].g, RoForNoob.savedVariables["downColor"].b, 1)

  RoForNoob.UI.Icon = WINDOW_MANAGER:CreateControl("RoForNoobIcon", RoForNoob.UI.frame, CT_TEXTURE)
  RoForNoob.UI.Icon:SetTexture('/esoui/art/icons/ability_buff_major_slayer.dds')
  RoForNoob.UI.Icon:SetDimensions(RoForNoob.savedVariables.size, RoForNoob.savedVariables.size)
  RoForNoob.UI.Icon:SetHidden(false)
  RoForNoob.UI.Icon:SetAnchor(CENTER, RoForNoob.UI.frame, CENTER)

  EVENT_MANAGER:RegisterForEvent(RoForNoob.name .. "ReticleHiddenUpdate", EVENT_RETICLE_HIDDEN_UPDATE, RoForNoob.UI.changeVisibility)
end

function RoForNoob.UI.OnMoveStop()
  RoForNoob.savedVariables.left = RoForNoob.UI.frame:GetLeft()
  RoForNoob.savedVariables.top = RoForNoob.UI.frame:GetTop()
end

function RoForNoob.UI.lock()
  RoForNoob.UI.frame:SetMovable(false)
  RoForNoob.UI.frame:SetMouseEnabled(false)
end

function RoForNoob.UI.unlock()
  RoForNoob.UI.frame:SetMovable(true)
  RoForNoob.UI.frame:SetMouseEnabled(true)
end

function RoForNoob.UI.changeVisibility(_, visibility)
  RoForNoob.UI.frame:SetHidden(visibility)
end

function RoForNoob.UI.updateSize(size)
  RoForNoob.UI.frame:SetDimensions(size, size)
  RoForNoob.UI.Timer:SetDimensions(size, size)
  RoForNoob.UI.Timer:SetFont(string.format('%s|%d|%s', '$(MEDIUM_FONT)', math.floor((size * 0.6)+0.5), 'soft-shadow-thick'))
  RoForNoob.UI.Icon:SetDimensions(size, size)
end

function RoForNoob.UI.getTimerColor(value)
  if value > 6.5 then
    return "ureadyColor"
  elseif value <= 6.5 and value > 1.5 then
    return "almostReadyColor"
  elseif value <= 1.5 and value > 0 then
    return "readyColor"
  elseif value <= 0 then
    return "downColor"
  end
end

function RoForNoob.UI.updateTimerValue(value)
  local color = RoForNoob.savedVariables[RoForNoob.UI.getTimerColor(value)]
  RoForNoob.UI.Timer:SetColor(color.r, color.g, color.b, 1)
  RoForNoob.UI.Timer:SetText(value)
end