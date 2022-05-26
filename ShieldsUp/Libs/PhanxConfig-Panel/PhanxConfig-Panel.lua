--[[--------------------------------------------------------------------
	PhanxConfig-Panel
	Simple background panel widget generator. Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber(("$Revision: 59 $"):match("%d+"))

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Panel", MINOR_VERSION)
if not lib then return end

local panelBackdrop = {
	bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tile = true, tileSize = 16,
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
}

function lib.CreatePanel(parent, width, height)
	assert( type(parent) == "table" and parent.CreateFontString, "PhanxConfig-Panel: Parent is not a valid frame!" )

	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameStrata(parent:GetFrameStrata())
	frame:SetFrameLevel(parent:GetFrameLevel() + 1)

	frame:SetBackdrop(panelBackdrop)
	frame:SetBackdropColor(0.06, 0.06, 0.06, 0.4)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

	frame:SetWidth(width or 1)
	frame:SetHeight(height or 1)

	return frame
end