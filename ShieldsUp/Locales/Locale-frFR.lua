--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Localization for frFR / French / Français
	Last updated 2009-11-15 by krukniak < curse.com >
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

	["%s faded!"] = "%s a disparu!",
	["%s faded from %s!"] = "%s a disparu de %s!",
	["YOU"] = "VOUS",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

	["Click for options."] = "Clic pour afficher la fenêtre d'options.",

	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp est un addon permettant de surperviser vos boucliers de chamans. Utilisez ces paramètres pour configurer l'apparence et le comportement de cet addon.",

	["Horizontal Position"] = "Position Horizontale",
	["Set the horizontal distance from the center of the screen to place the display."] = "Défini le positionnement horizontal de l'affichage par rapport au centre de l'écran.",

	["Vertical Position"] = "Position Verticale",
	["Set the vertical distance from the center of the screen to place the display."] = "Défini le positionnement vertical de l'affichage par rapport au centre de l'écran.",

	["Horizontal Padding"] = "Espacement horizontal",
	["Set the horizontal space between the charge counters."] = "Défini l'espacement horizontal entre les compteurs de charges.",

	["Vertical Padding"] = "Espacement vertical",
	["Set the vertical space between the target name and charge counters."] = "Défini l'espacement vertical entre le nom de la cible et les compteurs de charges.",

	["Opacity"] = "Opacité",
	["Set the opacity level for the display."] = "Défini le niveau d'opacité de l'affichage.",

--	["Overwrite Alert"] = "",
--	["Print a message in the chat frame alerting you who overwrites your %s."] = "",

------------------------------------------------------------------------

	["Font Face"] = "Police de caractère",
	["Set the font face to use for the display text."] = "Défini la police de caractère utilisée pour l'affichage du texte.",

	["Outline"] = "Contour",
	["Select an outline width for the display text."] = "Défini l'épaisseur du contour utilisé sur les caractères.",
	["None"] = "Aucun",
	["Thin"] = "Fin",
	["Thick"] = "Epais",

	["Shadow"] = "Ombre",
	["Add a drop shadow effect to the display text."] = "Ajoute une ombre portée au texte affiché.",

	["Counter Size"] = "Taille du compteur",
	["Set the text size for the charge counters."] = "Défini la taille du texte du compteur de charges.",

	["Name Size"] = "Taille du nom",
	["Set the text size for the target name."] = "Défini la taille du texte du nom de la cible.",

------------------------------------------------------------------------

	["Colors"] = "Couleur",
	["Set the color for the %s charge counter."] = "Défini la couleur pour le compteur de charges du %s.",

	["Active"] = "Actif",
	["Set the color for the target name while your %s is active."] = "Défini la couleur du  nom de la cible quand %s est actif.",

	["Overwritten"] = "Ecrasé",
	["Set the color for the target name when your %s has been overwritten."] = "Défini la couleur du nom de la cible quand votre %s a été écrasé par un autre chaman.",

	["Inactive"] = "Inactif",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Défini la couleur pour les boucliers expirés, dissipés ou inactifs.",

	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Ajoute des astérisques de chaque coté du nom de la cible quand votre %s est écrasé (en plus du changement de couleur).",

------------------------------------------------------------------------

	["Alerts"] = "Alertes",
	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Utilisez ces paramètres pour configurer comment ShieldsUp vous alertera quand vos boucliers expirent ou sont écrasés.",

	["Text Alert"] = "Texte d'alerte",
	["Show a text message when %s expires."] = "Affiche un message texte quand le %s expire.",

	["Sound Alert"] = "Alerte sonore",
	["Play a sound when %s expires."] = "Joue un son quand le %s expire.",

	["Sound File"] = "Fichier son",
	["Select the sound to play when %s expires."] = "Selectionnez le fichier son à jouer quand %s expire.",

	["Text Output"] = "Affichage du texte",

------------------------------------------------------------------------

	["Visibility"] = "Visibilité",
	["Use these settings to control when ShieldsUp should be shown or hidden."] = "Utiliser ces paramètres pour configurer quand l'affichage de ShieldsUp doit être actif ou non.",
	["Enable"] = "Activé",

	["Group Size"] = "Taille du groupe",
--	["Solo"] = "",
	["Show the display while you are not in a group"] = "Conserver l'affichage quand vous n'êtes pas groupé.",
	["Party"] = "Groupe",
	["Show the display while you are in a party group"] = "Afficher ShieldsUp quand vous êtes dans un groupe de 5.",
--	["Raid"] = "",
	["Show the display while you are in a raid group"] = "Afficher ShieldsUp quand vous êtes dans un groupe de raid.",

	["Zone Type"] = "Type de Zone",
	["World"] = "Monde",
	["Show the display while you are in the outdoor world"] = "Conserver l'affichage quand vous êtes à l'extérieur (hors instance).",
	["Dungeon"] = "Instance",
	["Show the display while you are in a party dungeon"] = "Afficher ShieldsUp quand vous êtes en instance 5 joueurs.",
	["Raid Dungeon"] = "Raid",
	["Show the display while you are in a raid dungeon"] = "Afficher ShieldsUp quand vous êtes en instance de raid.",
	["Arena"] = "Arène",
	["Show the display while you are in a PvP arena"] = "Afficher ShieldsUp quand vous êtes en arène PvP.",
	["Battleground"] = "Champ de bataille (PvP)",
	["Show the display while you are in a PvP battleground"] = "Afficher ShieldsUp quand vous êtes sur un champ de bataille PvP.",

--	["Exceptions"] = "",
	["Dead"] = "Mort",
	["Hide the display while you are dead"] = "Cacher l'affichage quand vous êtes mort.",
	["Out Of Combat"] = "Hors combat",
	["Hide the display while you are out of combat"] = "Cacher l'affichage quand vous hors combat.",
	["Resting"] = "Repos",
	["Hide the display while you are in an inn or major city"] = "Cacher l'affichage quand vous êtes dans une capitale ou une auberge (statut repos).",
	["Vehicle"] = "Véhicule",
	["Hide the display while you are controlling a vehicle"] = "Cacher l'affichage quand vous contrôlez un véhicule.",

------------------------------------------------------------------------

}