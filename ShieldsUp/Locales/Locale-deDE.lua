--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Localization for deDE / German / Deutsch
	Last updated 2009-07-14 by Søøm < graninibanane AT gmx DOT de >
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

	["%s faded!"] = "%s aufgebraucht!",
	["%s faded from %s!"] = "%s von %s aufgebraucht!",
	["YOU"] = "DIR",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

	["Click for options."] = "Linksklick für Optionen.",

	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp is eine einfache Anzeige für die verschiedenen Schilde des Schamanen. Benutze diese Optionen um das Erscheinungsbild und Verhalten zu konfigurieren.",

	["Horizontal Position"] = "Horizontale Position",
	["Set the horizontal distance from the center of the screen to place the display."] = "Einstellen des horizontalen Abstandes von der Mitte(des Bildschirms) zum gewünschten Platz von ShieldsUp.",

	["Vertical Position"] = "Vertikale Position",
	["Set the vertical distance from the center of the screen to place the display."] = "Einstellen des vertikalen Abstandes von der Mitte(des Bildschirms) zum gewünschten Platz von ShieldsUp.",

	["Horizontal Padding"] = "Horizontale Abstimmung",
	["Set the horizontal space between the charge counters."] = "Wähle den Abstand zwischen den Aufladungen der Schilde.",

	["Vertical Padding"] = "Vertikale Abstimmung",
	["Set the vertical space between the target name and charge counters."] = "Wähle den Abstand zwischen dem Zielnamen und den Aufladungen.",

	["Opacity"] = "Durchsichtigkeit",
	["Set the opacity level for the display."] = "Konfiguriere die Durchsichtigkeit der Anzeige.",

--	["Overwrite Alert"] = "",
--	["Print a message in the chat frame alerting you who overwrites your %s."] = "",

------------------------------------------------------------------------

	["Font Face"] = "Textfont",
	["Set the font face to use for the display text."] = "Wähle den Font für den angezeigten Text.",

	["Outline"] = "Umrandung",
	["Select an outline width for the display text."] = "Wähle eine Umrandung für den angezeigten Text",
	["None"] = "Keine",
	["Thin"] = "Dünn",
	["Thick"] = "Dick",

	["Shadow"] = "Schatten",
	["Add a drop shadow effect to the display text."] = "Füge einen Schatteneffekt hinzu.",

	["Counter Size"] = "Zahlengröße",
	["Set the text size for the charge counters."] = "Wähle die Textgröße für die Zahlen.",

	["Name Size"] = "Namensgröße",
	["Set the text size for the target name."] = "Wähle die Textgröße des Zielnamens.",

------------------------------------------------------------------------

	["Colors"] = "Farben",
	["Set the color for the %s charge counter."] = "Wähle die Textgröße der Aufladungen von %s.",

	["Active"] = "Aktiv",
	["Set the color for the target name while your %s is active."] = "Wähle die Farbe für den Namen deines Ziels während %s ist aktiv.",

	["Overwritten"] = "Überschrieben",
	["Set the color for the target name when your %s has been overwritten."] = "Wähle die Farbe für den Zielnamen, falls dein %s von einem anderen Schamanen überzaubert wurde",

	["Inactive"] = "Inaktiv",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Wähe die Farbe für abgelaufene, entzauberte oder inaktive Schilde.",

	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Fügt * um den Zielnamen, falls dein %s auf dem Ziel überzaubert wurde, zusätzlich zum Farbenwechsel.",

------------------------------------------------------------------------

	["Alerts"] = "Warnungen",
	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Verwende diese Optionen um ShieldsUp zu konfigurieren wie es dich bei abgelaufenen oder entzauberten Schilden informieren soll.",

	["Text Alert"] = "Textwarnungen",
	["Show a text message when %s expires."] = "Zeigt eine Nachricht, wenn %s abläuft.",

	["Sound Alert"] = "Akustische Warnungen",
	["Play a sound when %s expires."] = "Spielt einen Ton ab, wenn %s abläuft.",

	["Sound File"] = "Musikdatei",
	["Select the sound to play when %s expires."] = "Wähle eine Musikdatei zum abspielen, wenn %s abläuft",

	["Text Output"] = "Textausgabe",

------------------------------------------------------------------------

	["Visibility"] = "Sichtbarkeit",
	["Use these settings to control when ShieldsUp should be shown or hidden."] = "Ändere diese Einstellungen um ShieldsUp unter bestimmten Voraussetzungen zu zeigen oder zu verstecken.",
	["Enable"] = "Aktivieren",

	["Group Size"] = "Gruppengröße",
--	["Solo"] = "",
	["Show the display while you are not in a group"] = "Zeige ShieldsUp außerhalb einer Gruppe.",
--	["Party"] = "",
	["Show the display while you are in a party group"] = "Zeige ShieldsUp in einer 5er Gruppe.",
	["Raid"] = "Schlachtzug",
	["Show the display while you are in a raid group"] = "Zeige ShieldsUp wenn man sich in einem Schlachtzug befindet",

	["Zone Type"] = "Art der Zone",
	["World"] = "Welt",
	["Show the display while you are in the outdoor world"] = "Zeige ShieldsUp außerhalb von allen Spezialgebiten (Instanz/Schlachtzug...) .",
	["Dungeon"] = "Instanz",
	["Show the display while you are in a party dungeon"] = "Zeige ShieldsUp während du dich in einer 5er Instanz befindest.",
	["Raid Dungeon"] = "Schlachtzugsinstanz",
	["Show the display while you are in a raid dungeon"] = "Zeige ShieldsUp in einer Schlachtzugsinstanz ",
--	["Arena"] = "",
	["Show the display while you are in a PvP arena"] = "Zeige ShieldsUp während du dich in einer Arena befindest.",
	["Battleground"] = "Schlachtfeld",
	["Show the display while you are in a PvP battleground"] = "Zeige ShieldsUp während du dich auf einem Schlachtfeld befindest.",

	["Exceptions"] = "Außnahmen",
	["Dead"] = "Tot",
	["Hide the display while you are dead"] = "Verstecke ShieldsUp wenn du tot bist",
	["Out Of Combat"] = "Außerhalb eines Kampfes",
	["Hide the display while you are out of combat"] = "Verstecke ShieldsUp außerhalb des Kampfes",
	["Resting"] = "Erholt",
	["Hide the display while you are in an inn or major city"] = "Verstecke ShieldsUp während du dich bei einem Gastwirt oder in einer Hauptstadt aufhälst",
	["Vehicle"] = "Fahrzeug",
	["Hide the display while you are controlling a vehicle"] = "Verstecke ShieldsUp während du ein Fahrzeug steuerst",

------------------------------------------------------------------------

}