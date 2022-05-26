--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Localization for ruRU / Russian / Русский
	Last updated 2008-11-08 by XisRaa < xisraa AT gmail DOT com >
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

	["%s faded!"] = "%s спал!",
	["%s faded from %s!"] = "%s спал с %s!",
	["YOU"] = "ВАС",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

	["Click for options."] = "Клик - открывает окно настроек.",

--	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "",

	["Horizontal Position"] = "Горизонтальная позиция",
	["Set the horizontal distance from the center of the screen to place the display."] = "Установить горизонтальную позицию относительно центра экрана.",

	["Vertical Position"] = "Вертикальная позиция",
	["Set the vertical distance from the center of the screen to place the display."] = "Установить вертикальную позицию относительно центра экрана.",

	["Horizontal Padding"] = "Горизонтальный отступ",
	["Set the horizontal space between the charge counters."] = "Установить горизонтальный отступ между элементами текста.",

	["Vertical Padding"] = "Вертикальный отступ",
	["Set the vertical space between the target name and charge counters."] = "Установить вертикальный отступ между элементами текста.",

	["Opacity"] = "Прозрачность",
	["Set the opacity level for the display."] = "Установить уровень прозрачности.",

--	["Overwrite Alert"] = "",
--	["Print a message in the chat frame alerting you who overwrites your %s."] = "",

------------------------------------------------------------------------

	["Font Face"] = "Шрифт",
	["Set the font face to use for the display text."] = "Установить размер шрифта для имени.",

	["Outline"] = "Обрисовка",
--	["Select an outline width for the display text."] = "",
--	["None"] = "",
--	["Thin"] = "",
--	["Thick"] = "",

--	["Shadow"] = "",
--	["Add a drop shadow effect to the display text."] = "",

	["Counter Size"] = "Размер числа",
	["Set the text size for the charge counters."] = "Установить размер шрифта для счетчиков.",

	["Name Size"] = "Размер имени",
	["Set the text size for the target name."] = "Установить размер шрифта для имени.",

------------------------------------------------------------------------

	["Colors"] = "Цвета",
	["Set the color for the %s charge counter."] = "Использовать этот цвет для счетчика зарядов %s.",

	["Active"] = "Обычные",
	["Set the color for the target name while your %s is active."] = "Использовать этот цвет для цели, на которой %s.",

	["Overwritten"] = "Перебит",
	["Set the color for the target name when your %s has been overwritten."] = "Использовать этот цвет для цели, на которой %s, в случае если чужой щит перебил ваш на этой цели.",

	["Inactive"] = "Предупреждение",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Использовать этот цвет, когда счечик зарядов на нуле.",

	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
--	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "",

------------------------------------------------------------------------

	["Alerts"] = "Предупреждения",
--	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "",

	["Text Alert"] = "Текст",
	["Show a text message when %s expires."] = "Показывать предупреждение, когда спадает %s.",

	["Sound Alert"] = "Звук",
	["Play a sound when %s expires."] = "Проигрывать звук, когда спадает %s.",

	["Sound File"] = "Звуковой файл",
--	["Select the sound to play when %s expires."] = "",

--	["Text Output"] = "",

------------------------------------------------------------------------

	["Visibility"] = "Видимость",
	["Use these settings to control when the ShieldsUp display should be shown or hidden."] = "Настройка отображения в зависимости от следующих условий.",
--	["Enable"] = "",

	["Group Size"] = "Размер группы",
	["Solo"] = "Соло",
	["Show the display while you are not in a group"] = "Показывать, когда не в группе.",
	["Party"] = "Группа",
	["Show the display while you are in a 5-man party"] = "Показывать, когда в группе из 5 человек.",
	["Raid"] = "Рейд",
	["Show the display while you are in a raid group"] = "Показывать, когда в рейд.е",

	["Zone Type"] = "Тип зоны",
	["World"] = "Мир",
	["Show the display while you are in the outdoor world"] = "Показывать, когда в мире.",
	["Dungeon"] = "Подземелье",
	["Show the display while you are in a party dungeon"] = "Показывать, когда в подземелье на 5 человек.",
	["Raid Dungeon"] = "Инстанс-рейд",
	["Show the display while you are in a raid dungeon"] = "Показывать, когда в инстансе-рейде.",
	["Arena"] = "Арена",
	["Show the display while you are in a PvP arena"] = "Показывать, когда на арене(PvP).",
	["Battleground"] = "Поле боя",
	["Show the display while you are in a PvP battleground"] = "Показывать, когда на поле боя(PvP).",

--	["Exceptions"] = "",
--	["Dead"] = "",
--	["Hide the display while you are dead"] = "",
--	["Out Of Combat"] = "",
--	["Hide the display while you are out of combat"] = "",
--	["Resting"] = "",
--	["Hide the display while you are in an inn or major city"] = "",
--	["Vehicle"] = "",
--	["Hide the display while you are controlling a vehicle"] = "",

------------------------------------------------------------------------

}