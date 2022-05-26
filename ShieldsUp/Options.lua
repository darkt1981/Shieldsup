--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
----------------------------------------------------------------------]]

if select( 2, UnitClass("player") ) ~= "DRUID" then return end

local ADDON_NAME, namespace = ...

local ShieldsUp = namespace.ShieldsUp
local L = namespace.L

local optionsPanels = { }
ShieldsUp.optionsPanels = optionsPanels

local CreateOptionsPanel = LibStub("PhanxConfig-OptionsPanel").CreateOptionsPanel

------------------------------------------------------------------------

optionsPanels[ #optionsPanels +1 ] = CreateOptionsPanel( ADDON_NAME, nil, function( self )
	local db = ShieldsUpDB
	local SharedMedia = LibStub( "LibSharedMedia-3.0", true )

	local screenwidth = UIParent:GetWidth()
	local screenheight = UIParent:GetHeight()

	local CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	local CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	local CreateColorPicker = LibStub("PhanxConfig-ColorPicker").CreateColorPicker
	local CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown
	local CreateSlider = LibStub("PhanxConfig-Slider").CreateSlider

	--------------------------------------------------------------------

	local title, notes = LibStub("PhanxConfig-Header").CreateHeader( self, ADDON_NAME, L["ShieldsUp is a monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] )

	--------------------------------------------------------------------

	local posx = CreateSlider( self, L["Horizontal Position"], math.floor( screenwidth / 10 ) / 2 * -10, math.floor( screenwidth / 10 ) / 2 * 10, 5 )
	posx.desc = L["Set the horizontal distance from the center of the screen to place the display."]
	posx:SetPoint( "TOPLEFT", notes, "BOTTOMLEFT", -4, -8 )
	posx:SetPoint( "TOPRIGHT", notes, "BOTTOM", -8, 8 )

	posx.OnValueChanged = function( self, value )
		db.posx = value
		ShieldsUp:ApplySettings()
	end

	--------------------------------------------------------------------

	local posy = CreateSlider( self, L["Vertical Position"], floor( screenheight / 10 ) / 2 * -10, floor( screenheight / 10 ) / 2 * 10, 5 )
	posy.desc = L["Set the vertical distance from the center of the screen to place the display."]
	posy:SetPoint( "TOPLEFT", posx, "BOTTOMLEFT", 0, -8 )
	posy:SetPoint( "TOPRIGHT", posx, "BOTTOMRIGHT", 0, -8 )

	posy.OnValueChanged = function( self, value )
		db.posy = value
		ShieldsUp:ApplySettings()
	end

	--------------------------------------------------------------------

	local padh = CreateSlider( self, L["Horizontal Padding"], 0, floor( screenwidth / 10 ) / 2 * 10, 1 )
	padh.desc = L["Set the horizontal space between the charge counters."]
	padh:SetPoint( "TOPLEFT", posy, "BOTTOMLEFT", 0, -8 )
	padh:SetPoint( "TOPRIGHT", posy, "BOTTOMRIGHT", 0, -8 )

	padh.OnValueChanged = function( self, value )
		db.padh = value
		ShieldsUp:ApplySettings()
	end

	--------------------------------------------------------------------

	local padv = CreateSlider( self, L["Vertical Padding"], 0, floor( screenwidth / 10 ) / 2 * 10, 1 )
	padv.desc = L["Set the vertical space between the target name and charge counters."]
	padv:SetPoint( "TOPLEFT", padh, "BOTTOMLEFT", 0, -8 )
	padv:SetPoint( "TOPRIGHT", padh, "BOTTOMRIGHT", 0, -8 )

	padv.OnValueChanged = function( self, value )
		db.padv = value
		ShieldsUp:ApplySettings()
	end

	--------------------------------------------------------------------

	local face = LibStub("PhanxConfig-ScrollingDropdown").CreateScrollingDropdown( self, L["Font Face"], ShieldsUp.fonts )
	face.desc = L["Set the font face to use for the display text."]
	face:SetPoint( "TOPLEFT", notes, "BOTTOM", 8, -8 )
	face:SetPoint( "TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8 )
	do
		local _, height, flags = face.valueText:GetFont()
		face.valueText:SetFont( SharedMedia:Fetch( "font", db.font.face or "Friz Quadrata TT" ), height, flags )

		function face:OnValueChanged( value )
			local _, height, flags = self.valueText:GetFont()
			self.valueText:SetFont( SharedMedia:Fetch( "font", value ), height, flags )
			db.font.face = value
			ShieldsUp:ApplySettings()
		end

		local button_OnClick = face.button:GetScript("OnClick")
		face.button:SetScript( "OnClick", function( self )
			button_OnClick( self )
			face.dropdown.list:Hide()

			local function SetButtonFonts( self )
				local buttons = face.dropdown.list.buttons
				for i = 1, #buttons do
					local button = buttons[i]
					if button.value and button:IsShown() then
						button.label:SetFont( SharedMedia:Fetch( "font", button.value ), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT )
					end
				end
			end

			local OnShow = face.dropdown.list:GetScript("OnShow")
			face.dropdown.list:SetScript( "OnShow", function( self )
				OnShow( self )
				SetButtonFonts( self )
			end )

			local OnVerticalScroll = face.dropdown.list.scrollFrame:GetScript("OnVerticalScroll")
			face.dropdown.list.scrollFrame:SetScript( "OnVerticalScroll", function( self, delta )
				OnVerticalScroll( self, delta )
				SetButtonFonts( self )
			end )

			local SetText = face.dropdown.list.text.SetText
			face.dropdown.list.text.SetText = function( self, text )
				self:SetFont( SharedMedia:Fetch( "font", text ), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 1 )
				SetText( self, text )
			end

			button_OnClick( self )
			self:SetScript( "OnClick", button_OnClick )
		end )
	end

	--------------------------------------------------------------------

	local outlines = {
		["NONE"] = L["None"],
		["OUTLINE"] = L["Thin"],
		["THICKOUTLINE"] = L["Thick"],
	}

	local outline
	do
		local function OnClick( self )
			db.font.outline = self.value
			ShieldsUp:ApplySettings()
			outline:SetValue( self.value, self.text )
		end

		local info = { } -- UIDropDownMenu_CreateInfo()

		outline = CreateDropdown( self, L["Outline"], function()
			local selected = db.font.outline

			info.text = L["None"]
			info.value = "NONE"
			info.func = OnClick
			info.checked = "NONE" == selected
			UIDropDownMenu_AddButton( info )

			info.text = L["Thin"]
			info.value = "OUTLINE"
			info.func = OnClick
			info.checked = "THIN" == selected
			UIDropDownMenu_AddButton( info )

			info.text = L["Thick"]
			info.value = "THICKOUTLINE"
			info.func = OnClick
			info.checked = "THICK" == selected
			UIDropDownMenu_AddButton( info )
		end )
	end
	outline.desc = L["Select an outline width for the display text."]
	outline:SetPoint( "TOPLEFT", face, "BOTTOMLEFT", 0, -8 )
	outline:SetPoint( "TOPRIGHT", face, "BOTTOMRIGHT", 0, -8 )

	--------------------------------------------------------------------

	local large = CreateSlider( self, L["Counter Size"], 6, 32, 1 )
	large.desc = L["Set the text size for the charge counters."]
	large:SetPoint( "TOPLEFT", outline, "BOTTOMLEFT", 0, -8 )
	large:SetPoint( "TOPRIGHT", outline, "BOTTOMRIGHT", 0, -8 )

	large.OnValueChanged = function( self, value )
		db.font.large = value
		ShieldsUp:ApplySettings()
	end

	--------------------------------------------------------------------

	local small = CreateSlider( self, L["Name Size"], 6, 32, 1 )
	small.desc = L["Set the text size for the target name."]
	small:SetPoint( "TOPLEFT", large, "BOTTOMLEFT", 0, -8 )
	small:SetPoint( "TOPRIGHT", large, "BOTTOMRIGHT", 0, -8 )

	small.OnValueChanged = function( self, value )
		db.font.small = value
		ShieldsUp:ApplySettings()
	end

	--------------------------------------------------------------------

	local shadow = CreateCheckbox( self, L["Shadow"] )
	shadow.desc = L["Add a drop shadow effect to the display text."]
	shadow:SetPoint( "TOPLEFT", small, "BOTTOMLEFT", 0, -8 )

	shadow.OnClick = function( self, checked )
		db.font.shadow = checked
		ShieldsUp:ApplySettings()
	end

	--------------------------------------------------------------------

	local overwrite = CreateCheckbox( self, L["Overwrite Alert"] )
	overwrite.desc = L["Print a message in the chat frame alerting you who overwrites your %s."]:format( L["Earth Shield"] )
	overwrite:SetPoint( "TOPLEFT", padv, "BOTTOMLEFT", 0, -8 )

	overwrite.OnClick = function( self, checked )
		db.alert.earth.overwritten = checked
	end

	--------------------------------------------------------------------

	local vdist = -8 - face:GetHeight() - 8 - outline:GetHeight() - 8 - large:GetHeight() - 8 - small:GetHeight() - 8 - shadow:GetHeight() - 4

	local colors = CreatePanel( self )

	colors.label = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
	colors.label:SetPoint( "BOTTOMLEFT", colors, "TOPLEFT", 4, 0 )
	colors.label:SetText( L["Colors"] )

	colors:SetPoint( "TOPLEFT", notes, "BOTTOMLEFT", 0, vdist - colors.label:GetHeight() )
	colors:SetPoint( "TOPRIGHT", notes, "BOTTOMRIGHT", 0, vdist - colors.label:GetHeight() )

	--------------------------------------------------------------------

	local earth = CreateColorPicker( self, L["Earth Shield"] )
	earth.desc = string.format( L["Set the color for the %s charge counter."], L["Earth Shield"] )
	earth:SetPoint( "TOPLEFT", colors, 8, -8 )
	earth.GetColor = function() return unpack( db.color.earth ) end
	earth.OnColorChanged = function( self, r, g, b )
		db.color.earth[1] = r
		db.color.earth[2] = g
		db.color.earth[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local lightning = CreateColorPicker( self, L["Lightning Shield"] )
	lightning.desc = string.format( L["Set the color for the %s charge counter."], L["Lightning Shield"] )
	lightning:SetPoint( "TOPLEFT", earth, "BOTTOMLEFT", 0, -8 )
	lightning.GetColor = function() return unpack( db.color.lightning ) end
	lightning.OnColorChanged = function( self, r, g, b )
		db.color.lightning[1] = r
		db.color.lightning[2] = g
		db.color.lightning[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local water = CreateColorPicker( self, L["Water Shield"] )
	water.desc = string.format( L["Set the color for the %s charge counter."], L["Water Shield"] )
	water:SetPoint( "TOPLEFT", lightning, "BOTTOMLEFT", 0, -8 )
	water.GetColor = function() return unpack( db.color.water ) end
	water.OnColorChanged = function( self, r, g, b )
		db.color.water[1] = r
		db.color.water[2] = g
		db.color.water[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local normal = CreateColorPicker( self, L["Active"] )
	normal.desc = string.format( L["Set the color for the target name while your %s is active."], L["Earth Shield"] )
	normal:SetPoint( "TOPLEFT", colors, "TOP", 8, -8 )
	normal.GetColor = function() return unpack( db.color.normal ) end
	normal.OnColorChanged = function( self, r, g, b )
		db.color.normal[1] = r
		db.color.normal[2] = g
		db.color.normal[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local overwritten = CreateColorPicker( self, L["Overwritten"] )
	overwritten.desc = string.format( L["Set the color for the target name when your %s has been overwritten."], L["Earth Shield"] )
	overwritten:SetPoint( "TOPLEFT", normal, "BOTTOMLEFT", 0, -8 )
	overwritten.GetColor = function() return unpack( db.color.overwritten ) end
	overwritten.OnColorChanged = function( self, r, g, b )
		db.color.overwritten[1] = r
		db.color.overwritten[2] = g
		db.color.overwritten[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local alert = CreateColorPicker( self, L["Inactive"] )
	alert.desc = L["Set the color for expired, dispelled, or otherwise inactive shields."]
	alert:SetPoint( "TOPLEFT", overwritten, "BOTTOMLEFT", 0, -8 )
	alert.GetColor = function() return unpack( db.color.alert ) end
	alert.OnColorChanged = function( self, r, g, b )
		db.color.alert[1] = r
		db.color.alert[2] = g
		db.color.alert[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	colors:SetHeight( earth:GetHeight() * 3 + 32 )

	--------------------------------------------------------------------

	self.refresh = function()
		posx:SetValue( db.posx )
		posy:SetValue( db.posy )
		padh:SetValue( db.padh )
		padv:SetValue( db.padv )
		face:SetValue( db.font.face )
		outline:SetValue( db.font.outline, outlines[db.font.outline] )
		large:SetValue( db.font.large )
		small:SetValue( db.font.small )
		shadow:SetChecked( db.font.shadow )
		overwrite:SetChecked( db.alert.earth.overwritten )
		earth:SetColor( unpack( db.color.earth ) )
		lightning:SetColor( unpack( db.color.lightning ) )
		water:SetColor( unpack( db.color.water ) )
		normal:SetColor( unpack( db.color.normal ) )
		overwritten:SetColor( unpack( db.color.overwritten ) )
		alert:SetColor( unpack( db.color.alert ) )
	end
end )

------------------------------------------------------------------------

optionsPanels[ #optionsPanels +1 ] = CreateOptionsPanel( L["Alerts"], ADDON_NAME, function( self )
	local db = ShieldsUpDB

	local SharedMedia = LibStub( "LibSharedMedia-3.0", true )

	local CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	local CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	local CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown

	--------------------------------------------------------------------

	local title, notes = LibStub("PhanxConfig-Header").CreateHeader( self, self.name, L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] )

	--------------------------------------------------------------------

	local elabel = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
	elabel:SetPoint( "TOPLEFT", notes, "BOTTOMLEFT", 0, -16 )
	elabel:SetPoint( "TOPRIGHT", notes, "BOTTOMRIGHT", 0, -16 )
	elabel:SetJustifyH("LEFT")
	elabel:SetText( L["Earth Shield"] )

	local epanel = CreatePanel( self )
	epanel:SetPoint( "TOPLEFT", elabel, "BOTTOMLEFT", -4, 0 )
	epanel:SetPoint( "TOPRIGHT", elabel, "BOTTOMRIGHT", 4, 0 )

	--------------------------------------------------------------------

	local etext = CreateCheckbox( self, L["Text Alert"] )
	etext.desc = L["Show a text message when %s expires."]:format( L["Earth Shield"] )
	etext:SetPoint( "TOPLEFT", epanel, 8, -8 )
	etext.OnClick = function( self, checked )
		db.alert.earth.text = checked
	end

	--------------------------------------------------------------------

	local esound = CreateCheckbox( self, L["Sound Alert"] )
	esound.desc = L["Play a sound when %s expires."]:format( L["Earth Shield"] )
	esound:SetPoint( "TOPLEFT", etext, "BOTTOMLEFT", 0, -8 )
	esound.OnClick = function( self, checked )
		db.alert.earth.sound = checked
	end

	local esoundfile
	do
		local function OnClick( self )
			PlaySoundFile( SharedMedia:Fetch( "sound", self.value ) )
			db.alert.earth.soundFile = self.value
			esoundfile:SetValue( self.value, self.text )
		end

		local info = { } -- UIDropDownMenu_CreateInfo()

		esoundfile = CreateDropdown( self, L["Sound File"], function( self )
			local selected = db.alert.earth.soundFile

			for i, sound in ipairs( ShieldsUp.sounds ) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton( info )
			end
		end )
	end
	esoundfile.desc = L["Select the sound to play when %s expires."]:format( L["Earth Shield"] )
	esoundfile:SetPoint( "BOTTOMLEFT", epanel, "BOTTOM", 8, 8 )
	esoundfile:SetPoint( "BOTTOMRIGHT", epanel, -8, 8 )

	--------------------------------------------------------------------

	epanel:SetHeight( 8 + etext:GetHeight() + 8 + esound:GetHeight() + 8 )

	--------------------------------------------------------------------

	local wlabel = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
	wlabel:SetPoint( "TOPLEFT", epanel, "BOTTOMLEFT", 4, -8 )
	wlabel:SetPoint( "TOPRIGHT", epanel, "BOTTOMRIGHT", -4, -8 )
	wlabel:SetJustifyH("LEFT")
	wlabel:SetText( L["Water Shield"] )

	local wpanel = CreatePanel( self )
	wpanel:SetPoint( "TOPLEFT", wlabel, "BOTTOMLEFT", -4, 0 )
	wpanel:SetPoint( "TOPRIGHT", wlabel, "BOTTOMRIGHT", 4, 0 )

	--------------------------------------------------------------------

	local wtext = CreateCheckbox( self, L["Text Alert"] )
	wtext.desc = L["Show a text message when %s expires."]:format( L["Water Shield"] )
	wtext:SetPoint( "TOPLEFT", wpanel, 8, -8 )
	wtext.OnClick = function( self, checked )
		db.alert.water.text = checked
	end

	--------------------------------------------------------------------

	local wsound = CreateCheckbox( self, L["Sound Alert"] )
	wsound.desc = L["Play a sound when %s expires."]:format( L["Water Shield"] )
	wsound:SetPoint( "TOPLEFT", wtext, "BOTTOMLEFT", 0, -8 )
	wsound.OnClick = function( self, checked )
		db.alert.water.sound = checked
	end

	--------------------------------------------------------------------

	local wsoundfile
	do
		local function OnClick( self )
			PlaySoundFile( SharedMedia:Fetch( "sound", self.value ) )
			db.alert.water.soundFile = self.value
			wsoundfile:SetValue( self.value, self.text )
		end

		local info = { }

		wsoundfile = CreateDropdown( self, L["Sound File"], function()
			local selected = db.alert.water.soundFile

			for i, sound in ipairs( ShieldsUp.sounds ) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton( info )
			end
		end )
	end
	wsoundfile.desc = L["Select the sound to play when %s expires."]:format( L["Water Shield"] )
	wsoundfile:SetPoint( "BOTTOMLEFT", wpanel, "BOTTOM", 8, 8 )
	wsoundfile:SetPoint( "BOTTOMRIGHT", wpanel, -8, 8 )

	--------------------------------------------------------------------

	wpanel:SetHeight( 8 + wtext:GetHeight() + 8 + wsound:GetHeight() + 8 )

	--------------------------------------------------------------------

	local sinkOptions, outputNames, olabel, opanel, output, scrollarea, sticky, UpdateOutputPanel
	if ShieldsUp.Pour then
		sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

		outputNames = { }
		for k, v in pairs( sinkOptions.args ) do
			if k ~= "Default" and k ~= "Sticky" and k ~= "Channel" and v.type == "toggle" then
				outputNames[k] = v.name
			end
		end

		function UpdateOutputPanel()
			output:SetValue( db.alert.output.sink20OutputSink, outputNames[db.alert.output.sink20OutputSink] )

			sinkOptions.set( db.alert.output.sink20OutputSink, true ) -- hax!
			for i, v in ipairs( sinkOptions.args.ScrollArea.validate ) do
				if v == db.alert.output.sink20ScrollArea then
					scrollarea:SetValue( db.alert.output.sink20ScrollArea )
				end
			end

			sticky:SetChecked( db.alert.output.sink20Sticky )

			if sinkOptions.args.ScrollArea.disabled then
				scrollarea:Hide()
			else
				scrollarea:Show()

				local valid
				local current = db.alert.output.sink20ScrollArea
				for i, scrollArea in ipairs( sinkOptions.args.ScrollArea.validate ) do
					if scrollArea == current then
						valid = true
						break
					end
				end
				if not valid then
					scrollarea.valueText:SetText()
				end
			end

			if sinkOptions.args.Sticky.disabled then
				sticky:Hide()
				opanel:SetHeight( 8 + output:GetHeight() + 8 + 8 ) -- Why the extra 8? I don't know!
			else
				sticky:Show()
				opanel:SetHeight( 8 + output:GetHeight() + 8 + sticky:GetHeight() + 8 + 8 )
			end
		end

		olabel = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
		olabel:SetPoint( "TOPLEFT", wpanel, "BOTTOMLEFT", 4, -8 )
		olabel:SetPoint( "TOPRIGHT", wpanel, "BOTTOMRIGHT", -4, -8 )
		olabel:SetJustifyH("LEFT")
		olabel:SetText( L["Text Output"] )

		opanel = CreatePanel( self )
		opanel:SetPoint( "TOPLEFT", olabel, "BOTTOMLEFT", -4, 0 )
		opanel:SetPoint( "TOPRIGHT", olabel, "BOTTOMRIGHT", 4, 0 )

		do
			local function OnClick( self )
				sinkOptions.set( self.value, true )
				sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

				UpdateOutputPanel()

				output:SetValue( self.value, self.text )
			end

			local info = { }

			output = CreateDropdown( self, sinkOptions.name, function()
				local selected = db.alert.output.sink20OutputSink
				for k, v in pairs( sinkOptions.args ) do
					if k ~= "Default" and k ~= "Sticky" and k ~= "Channel" and v.type == "toggle" and not ( v.hidden and v:hidden() ) then
						info.text = v.name
						info.value = k
						info.func = OnClick
						info.checked = v.name == selected
						UIDropDownMenu_AddButton( info )
					end
				end
			end )
		end
		output.desc = sinkOptions.desc
		output:SetPoint( "TOPLEFT", opanel, 8, -8 )
		output:SetPoint( "TOPRIGHT", opanel, "TOP", -4, -8 )

		--------------------------------------------------------------

		do
			local function OnClick( self )
				sinkOptions.set( "ScrollArea", self.value )
				sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

				scrollarea:SetValue( self.value, self.text )
			end

			local info = { }

			scrollarea = CreateDropdown( self, sinkOptions.args.ScrollArea.name, function()
				local selected = db.alert.output.sink20ScrollArea

				for i, v in ipairs( sinkOptions.args.ScrollArea.validate ) do
					info.text = v
					info.value = v
					info.func = OnClick
					info.checked = v == selected
					UIDropDownMenu_AddButton( info )
				end
			end )
		end
		scrollarea.desc = sinkOptions.args.ScrollArea.desc
		scrollarea:SetPoint( "TOPLEFT", opanel, "TOP", 4, -8 )
		scrollarea:SetPoint( "TOPRIGHT", opanel, -8, -8 )

		--------------------------------------------------------------

		sticky = CreateCheckbox( self, sinkOptions.args.Sticky.name )
		sticky.desc = sinkOptions.args.Sticky.desc
		sticky:SetPoint( "TOPLEFT", scrollarea, "BOTTOMLEFT", 0, -8 )
		sticky.OnClick = function( self, checked )
			sinkOptions.set( "Sticky", checked )
			sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output
		end

		--------------------------------------------------------------

		UpdateOutputPanel()
	end

	--------------------------------------------------------------------

	self.refresh = function()
		etext:SetChecked( db.alert.earth.text )
		esound:SetChecked( db.alert.earth.sound )
		esoundfile:SetValue( db.alert.earth.soundFile )

		wtext:SetChecked( db.alert.water.text )
		wsound:SetChecked( db.alert.water.sound )
		wsoundfile:SetValue( db.alert.water.soundFile )

		if UpdateOutputPanel then
			UpdateOutputPanel()
		end
	end
end )

------------------------------------------------------------------------

optionsPanels[ #optionsPanels +1 ] = CreateOptionsPanel( L["Visibility"], ADDON_NAME, function( self )
	local db = ShieldsUpDB.show

	local CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	local CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox

	local function OnClick( self, checked )
		db[ self.tbl ][ self.key ] = checked
		ShieldsUp:UpdateVisibility()
	end

	--------------------------------------------------------------------

	local title, notes = LibStub("PhanxConfig-Header").CreateHeader( self, self.name, L["Use these settings to control when the ShieldsUp display should be shown or hidden."] )

	--------------------------------------------------------------------

	local glabel = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
	glabel:SetPoint( "TOPLEFT", notes, "BOTTOMLEFT", 0, -8 )
	glabel:SetPoint( "TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8 )
	glabel:SetJustifyH("LEFT")
	glabel:SetText( L["Group Size"] )

	local gpanel = CreatePanel( self )
	gpanel:SetPoint( "TOPLEFT", glabel, "BOTTOMLEFT", -4, 0 )
	gpanel:SetPoint( "TOPRIGHT", glabel, "BOTTOMRIGHT", 4, 0 )

	local gsolo = CreateCheckbox( self, L["Solo"] )
	gsolo.desc = L["Show the display while you are not in a group"]
	gsolo:SetPoint( "TOPLEFT", gpanel, 8, -8 )
	gsolo.OnClick = OnClick
	gsolo.tbl, gsolo.key = "group", "solo"

	local gparty = CreateCheckbox( self, L["Party"] )
	gparty.desc = L["Show the display while you are in a party group"]
	gparty:SetPoint( "TOPLEFT", gsolo, "BOTTOMLEFT", 0, -8 )
	gparty.OnClick = OnClick
	gparty.tbl, gparty.key = "group", "party"

	local graid = CreateCheckbox( self, L["Raid"] )
	graid.desc = L["Show the display while you are in a raid group"]
	graid:SetPoint( "TOPLEFT", gpanel, "TOP", 8, -16 - gsolo:GetHeight() )
	graid.OnClick = OnClick
	graid.tbl, graid.key = "group", "raid"

	gpanel:SetHeight( gsolo:GetHeight() * 2 + 24 )

	--------------------------------------------------------------------

	local zlabel = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
	zlabel:SetPoint( "TOPLEFT", gpanel, "BOTTOMLEFT", 4, -8 )
	zlabel:SetPoint( "TOPRIGHT", gpanel, "BOTTOMRIGHT", -4, -8 )
	zlabel:SetJustifyH("LEFT")
	zlabel:SetText( L["Zone Type"] )

	local zpanel = CreatePanel( self )
	zpanel:SetPoint( "TOPLEFT", zlabel, "BOTTOMLEFT", -4, 0 )
	zpanel:SetPoint( "TOPRIGHT", zlabel, "BOTTOMRIGHT", 4, 0 )

	local zworld = CreateCheckbox( self, L["World"] )
	zworld.desc = L["Show the display while you are in the outdoor world"]
	zworld:SetPoint( "TOPLEFT", zpanel, 8, -8 )
	zworld.OnClick = OnClick
	zworld.tbl, zworld.key = "zone", "none"

	local zparty = CreateCheckbox( self, L["Dungeon"] )
	zparty.desc = L["Show the display while you are in a party dungeon"]
	zparty:SetPoint( "TOPLEFT", zworld, "BOTTOMLEFT", 0, -8 )
	zparty.OnClick = OnClick
	zparty.tbl, zparty.key = "zone", "party"

	local zraid = CreateCheckbox( self, L["Raid Dungeon"] )
	zraid.desc = L["Show the display while you are in a raid dungeon"]
	zraid:SetPoint( "TOPLEFT", zpanel, "TOP", 8, -16 - zworld:GetHeight() )
	zraid.OnClick = OnClick
	zraid.tbl, zraid.key = "zone", "raid"

	local zarena = CreateCheckbox( self, L["Arena"] )
	zarena.desc = L["Show the display while you are in a PvP arena"]
	zarena:SetPoint( "TOPLEFT", zparty, "BOTTOMLEFT", 0, -8 )
	zarena.OnClick = OnClick
	zarena.tbl, zarena.key = "zone", "arena"

	local zpvp = CreateCheckbox( self, L["Battleground"] )
	zpvp.desc = L["Show the display while you are in a PvP battleground"]
	zpvp:SetPoint( "TOPLEFT", zraid, "BOTTOMLEFT", 0, -8 )
	zpvp.OnClick = OnClick
	zpvp.tbl, zpvp.key = "zone", "pvp"

	zpanel:SetHeight( zworld:GetHeight() * 3 + 32 )

	--------------------------------------------------------------------

	local xlabel = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
	xlabel:SetPoint( "TOPLEFT", zpanel, "BOTTOMLEFT", 4, -8 )
	xlabel:SetPoint( "TOPRIGHT", zpanel, "BOTTOMRIGHT", -4, -8 )
	xlabel:SetJustifyH("LEFT")
	xlabel:SetText( L["Exceptions"] )

	local xpanel = CreatePanel( self )
	xpanel:SetPoint( "TOPLEFT", xlabel, "BOTTOMLEFT", -4, 0 )
	xpanel:SetPoint( "TOPRIGHT", xlabel, "BOTTOMRIGHT", 4, 0 )

	local xdead = CreateCheckbox( self, L["Dead"] )
	xdead.desc = L["Hide the display while you are dead"]
	xdead:SetPoint( "TOPLEFT", xpanel, 8, -8 )
	xdead.OnClick = OnClick
	xdead.tbl, xdead.key = "except", "dead"

	local xnocombat = CreateCheckbox( self, L["Out Of Combat"] )
	xnocombat.desc = L["Hide the display while you are out of combat"]
	xnocombat:SetPoint( "TOPLEFT", xpanel, "TOP", 8, -8 )
	xnocombat.OnClick = OnClick
	xnocombat.tbl, xnocombat.key = "except", "nocombat"

	local xresting = CreateCheckbox( self, L["Resting"] )
	xresting.desc = L["Hide the display while you are in an inn or major city"]
	xresting:SetPoint( "TOPLEFT", xdead, "BOTTOMLEFT", 0, -8 )
	xresting.OnClick = OnClick
	xresting.tbl, xresting.key = "except", "resting"

	local xvehicle = CreateCheckbox( self, L["Vehicle"] )
	xvehicle.desc = L["Hide the display while you are controlling a vehicle"]
	xvehicle:SetPoint( "TOPLEFT", xnocombat, "BOTTOMLEFT", 0, -8 )
	xvehicle.OnClick = OnClick
	xvehicle.tbl, xvehicle.key = "except", "vehicle"

	xpanel:SetHeight( xdead:GetHeight() * 2 + 24 )

	--------------------------------------------------------------------

	self.refresh = function()
		gsolo:SetChecked( db.group.solo )
		gparty:SetChecked( db.group.party )
		graid:SetChecked( db.group.raid )

		zworld:SetChecked( db.zone.none )
		zparty:SetChecked( db.zone.party )
		zraid:SetChecked( db.zone.raid )
		zarena:SetChecked( db.zone.arena )
		zpvp:SetChecked( db.zone.pvp )

		xdead:SetChecked( db.except.dead )
		xnocombat:SetChecked( db.except.nocombat )
		xresting:SetChecked( db.except.resting )
		xvehicle:SetChecked( db.except.vehicle )
	end
end )

------------------------------------------------------------------------

optionsPanels[ #optionsPanels +1 ] = LibStub("LibAboutPanel").new( ADDON_NAME, ADDON_NAME )

------------------------------------------------------------------------

SLASH_SHIELDSUP1 = "/sup"
SLASH_SHIELDSUP2 = "/shieldsup"
SlashCmdList.SHIELDSUP = function()
	InterfaceOptionsFrame_OpenToCategory( optionsPanels[ #optionsPanels ] )
	InterfaceOptionsFrame_OpenToCategory( optionsPanels[1] )
end

------------------------------------------------------------------------

local LibDataBroker = LibStub( "LibDataBroker-1.1", true )
if LibDataBroker then
	LibDataBroker:NewDataObject( ADDON_NAME, {
		type = "launcher",
		icon = "Interface\\Icons\\Spell_Nature_SkinOfEarth",
		label = ADDON_NAME,
		OnClick = SlashCmdList.SHIELDSUP,
		OnTooltipShow = function( tooltip )
			tooltip:AddLine( ADDON_NAME, 1, 1, 1 )
			tooltip:AddLine( L["Click for options."] )
			tooltip:Show()
		end,
	} )
end

------------------------------------------------------------------------