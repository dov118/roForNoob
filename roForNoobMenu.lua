RoForNoob = RoForNoob or {}
local RoForNoob = RoForNoob

RoForNoob.Menu = RoForNoob.Menu or {}

local LibAddonMenu = LibStub("LibAddonMenu-2.0")

function RoForNoob.Menu.build()
  LibAddonMenu:RegisterAddonPanel(RoForNoob.name .. "General", {
    type = "panel",
    name = RoForNoob.name,
    displayName = RoForNoob.displayName,
    author = RoForNoob.author,
    registerForRefresh = true,
    version = RoForNoob.majorVersion .. "." .. RoForNoob.minorVersion .. ".|cff0000" .. RoForNoob.revisionVersion .. "|r",
    website = RoForNoob.website,
  })

  LibAddonMenu:RegisterOptionControls(RoForNoob.name .. "General", {
    {
      type = "header",
      name = "Position",
    },
    {
      type = "checkbox",
      name = "Lock Frame",
      getFunc = function() return RoForNoob.savedVariables.lockUI end,
      setFunc = function(value)
        if value then
          RoForNoob.UI.lock()
          EVENT_MANAGER:RegisterForEvent(RoForNoob.name .. "ReticleHiddenUpdate", EVENT_RETICLE_HIDDEN_UPDATE, RoForNoob.UI.changeVisibility)
        else
          RoForNoob.UI.unlock()
          EVENT_MANAGER:UnregisterForEvent(RoForNoob.name .. "ReticleHiddenUpdate", EVENT_RETICLE_HIDDEN_UPDATE)
        end
        RoForNoob.savedVariables.lockUI = value
        RoForNoob.UI.frame:SetHidden(value)
      end,
    },
    {
      type = "header",
      name = "Colors",
    },
    {
      type = "colorpicker",
      name = "Down Color",
      getFunc = function() return RoForNoob.savedVariables.downColor.r, RoForNoob.savedVariables.downColor.g, RoForNoob.savedVariables.downColor.b end,	--(alpha is optional)
      setFunc = function(r,g,b,a)
        RoForNoob.savedVariables.downColor.r = r
        RoForNoob.savedVariables.downColor.g = g
        RoForNoob.savedVariables.downColor.b = b
      end,
    },
    {
      type = "colorpicker",
      name = "Unready Color",
      getFunc = function() return RoForNoob.savedVariables.ureadyColor.r, RoForNoob.savedVariables.ureadyColor.g, RoForNoob.savedVariables.ureadyColor.b end,	--(alpha is optional)
      setFunc = function(r,g,b,a)
        RoForNoob.savedVariables.ureadyColor.r = r
        RoForNoob.savedVariables.ureadyColor.g = g
        RoForNoob.savedVariables.ureadyColor.b = b
      end,
    },
    {
      type = "colorpicker",
      name = "Almost ready Color",
      getFunc = function() return RoForNoob.savedVariables.almostReadyColor.r, RoForNoob.savedVariables.almostReadyColor.g, RoForNoob.savedVariables.almostReadyColor.b end,	--(alpha is optional)
      setFunc = function(r,g,b,a)
        RoForNoob.savedVariables.almostReadyColor.r = r
        RoForNoob.savedVariables.almostReadyColor.g = g
        RoForNoob.savedVariables.almostReadyColor.b = b
      end,
    },
    {
      type = "colorpicker",
      name = "Ready Color",
      getFunc = function() return RoForNoob.savedVariables.readyColor.r, RoForNoob.savedVariables.readyColor.g, RoForNoob.savedVariables.readyColor.b end,	--(alpha is optional)
      setFunc = function(r,g,b,a)
        RoForNoob.savedVariables.readyColor.r = r
        RoForNoob.savedVariables.readyColor.g = g
        RoForNoob.savedVariables.readyColor.b = b
      end,
    },
    {
      type = "header",
      name = "Size",
    },
    {
      type = "slider",
      name = "Size",
      min = 40,
      max = 200,
      getFunc = function() return RoForNoob.savedVariables.size end,
      setFunc = function(value)
        RoForNoob.UI.frame:SetHidden(false)
        RoForNoob.savedVariables.size = value
        RoForNoob.UI.updateSize(value)
      end,
    },
  })
end