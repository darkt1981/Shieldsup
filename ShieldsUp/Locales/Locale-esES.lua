--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Spanish / Español (EU) + Latin American Spanish / Español (AL)
	Last updated 2010-12-22 by Akkorian
----------------------------------------------------------------------]]

if not (GetLocale() == "esES" or GetLocale() == "esMX") or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

	["%s faded!"] = "%s desapareció!",
	["%s faded from %s!"] = "%s desapareció de %s!",
	["YOU"] = "TÚ MISMO",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

	["Click for options."] = "Haz clic para abrir las opciones.",

	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "Estas opciones te permiten modificar la configuración de ShieldsUp, un addon para seguir tus Escudos elementales.",

	["Horizontal Position"] = "Posición horizontal",
	["Set the horizontal distance from the center of the screen to place the display."] = "Ajustar la distancia horizontal desde el centro de la pantalla para colocar el marco.",

	["Vertical Position"] = "Posición vertical",
	["Set the vertical distance from the center of the screen to place the display."] = "Ajustar la distancia vertical desde el centro de la pantalla para colocar el marco.",

	["Horizontal Padding"] = "Espaciado horizontal",
	["Set the horizontal space between the charge counters."] = "Ajustar el espacio horizontal entre los números de cargas.",

	["Vertical Padding"] = "Espaciado vertical",
	["Set the vertical space between the target name and charge counters."] = "Ajustar el espacio vertical entre el nombre objetivo y los números de cargas.",

	["Opacity"] = "Opacidad",
	["Set the opacity level for the display."] = "Ajustar la opacidad del marco.",

	["Overwrite Alert"] = "Aviso en sobrescrito",
	["Print a message in the chat frame alerting you who overwrites your %s."] = "Mostrar una aviso en la ventana de chat cuando otro chamán sobrescribe tu %s.",

------------------------------------------------------------------------

	["Font Face"] = "Fuente",
	["Set the font face to use for the display text."] = "Cambiar la fuente.",

	["Outline"] = "Perfil de fuente",
	["Select an outline width for the display text."] = "Ajustar el perfil de la fuente.",
	["None"] = "Ninguno",
	["Thin"] = "Fino",
	["Thick"] = "Grueso",

	["Shadow"] = "Sombra de fuente",
	["Add a drop shadow effect to the display text."] = "Mostrar la sombra de la fuente.",

	["Counter Size"] = "Tamaño de números",
	["Set the text size for the charge counters."] = "Ajustar el tamaño de los números de cargas.",

	["Name Size"] = "Tamaño de nombre",
	["Set the text size for the target name."] = "Ajustar el tamaño de la fuente del nombre objetivo.",

------------------------------------------------------------------------

	["Colors"] = "Colores",
	["Set the color for the %s charge counter."] = "Ajustar el color del número de cargas en tu %s.",

	["Active"] = "Activo",
	["Set the color for the target name while your %s is active."] = "Ajustar el color del nombre objetivo, mientras que tu %s está activo.",

	["Overwritten"] = "Sobrescrito",
	["Set the color for the target name when your %s has been overwritten."] = "Ajustar el color del nombre objetivo, mientras que tu %s se ha sobrescrito.",

	["Inactive"] = "Inactivo",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Ajustar el color de los números de cargas, mientras que tu Escudo está inactivo.",

	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Añadir asteriscos alrededor del nombre objetivo cuando otro chamán sobrescribe tu %s, además de cambiar el color.",

------------------------------------------------------------------------

	["Alerts"] = "Alertas",
	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Estas opciones te permiten cambiar la forma en ShieldsUp te avisa en un Escudo expira o se quita.",

	["Text Alert"] = "Alertas de texto",
	["Show a text message when %s expires."] = "Mostrar un mensaje de alerta cuando expira tu %s.",

	["Sound Alert"] = "Alertas de sonido",
	["Play a sound when %s expires."] = "Reproducir un sonido cuando expira tu %s.",

	["Sound File"] = "Sonido",
	["Select the sound to play when %s expires."] = "Establecer el sonido a reproducir cuando expira su %s.",

	["Text Output"] = "Salida de alertas de texto",

------------------------------------------------------------------------

	["Visibility"] = "Visibilidad",
	["Use these settings to control when ShieldsUp should be shown or hidden."] = "Estas opciones le permiten controlar cuando el marco de ShieldsUp se muestran o se ocultan.",
	["Enable"] = "Activar",

	["Group Size"] = "Tamaño de grupo",
--	["Solo"] = "",
	["Show the display while you are not in a group"] = "Mostrar el marco mientras estás solo.",
	["Party"] = "Grupo",
	["Show the display while you are in a party group"] = "Mostrar el marco mientras estás en un grupo de 5.",
	["Raid"] = "Banda",
	["Show the display while you are in a raid group"] = "Mostrar el marco mientras estás en un banda.",

	["Zone Type"] = "Tipo de Zona",
	["World"] = "Mundo",
	["Show the display while you are in the outdoor world"] = "Mostrar el marco mientras estás en el mundo, no una mazmorra.",
	["Dungeon"] = "Mazmorra",
	["Show the display while you are in a party dungeon"] = "Mostrar el marco mientras estás en una mazmorra.",
	["Raid Dungeon"] = "Mazmorra de banda",
	["Show the display while you are in a raid dungeon"] = "Mostrar el marco mientras estás en una mazmorra de banda.",
--	["Arena"] = "",
	["Show the display while you are in a PvP arena"] = "Mostrar el marco mientras estás en una arena JcJ.",
	["Battleground"] = "Campo de batalla",
	["Show the display while you are in a PvP battleground"] = "Mostrar el marco mientras estás en un campo de batalla JcJ.",

	["Exceptions"] = "Excepciones",
	["Dead"] = "Muerto",
	["Hide the display while you are dead"] = "Ocultar el marco mientras estás muerto.",
	["Out Of Combat"] = "Fuera de combate",
	["Hide the display while you are out of combat"] = "Ocultar el marco mientras estás fuera de combate.",
	["Resting"] = "Reposo",
	["Hide the display while you are in an inn or major city"] = "Ocultar el marco mientras estás en una fonda o gran ciudad (reposo).",
	["Vehicle"] = "Vehículo",
	["Hide the display while you are controlling a vehicle"] = "Ocultar el marco mientras estás manejando un vehículo.",

------------------------------------------------------------------------

}