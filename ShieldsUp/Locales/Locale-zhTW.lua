--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Localization for zhTW / Traditional Chinese / 正體中文
	Last updated 2009-07-15 by www.wowui.cn
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

	["%s faded!"] = "%s 已消失",
	["%s faded from %s!"] = "%s 在 %s 上消失!",
	["YOU"] = "自身",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

--	["Click for options."] = "",

	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp是一個薩滿護盾的監視器。使用這些設定來配置插件的外觀和行為.",

	["Horizontal Position"] = "水平位置",
	["Set the horizontal distance from the center of the screen to place the display."] = "設定插件顯示的相對于屏幕中間的水平位置.",

	["Vertical Position"] = "垂直位置",
	["Set the vertical distance from the center of the screen to place the display."] = "設定插件顯示的相對于屏幕中間的水平位置.",

	["Horizontal Padding"] = "水平間距",
	["Set the horizontal space between the charge counters."] = "設定計數器的水平距離.",

	["Vertical Padding"] = "垂直間距",
	["Set the vertical space between the target name and charge counters."] = "設定目標名字和計數器的垂直距離.",

	["Opacity"] = "不透明度",
	["Set the opacity level for the display."] = "設定顯示的不透明度等級.",

--	["Overwrite Alert"] = "",
--	["Print a message in the chat frame alerting you who overwrites your %s."] = "",

------------------------------------------------------------------------

	["Font Face"] = "字型",
	["Set the font face to use for the display text."] = "設定顯示文字的字型.",

	["Outline"] = "描邊",
	["Select an outline width for the display text."] = "設定顯示文字的描邊寬度",
	["None"] = "無",
	["Thin"] = "細描邊",
	["Thick"] = "粗描邊",

	["Shadow"] = "陰影效果",
	["Add a drop shadow effect to the display text."] = "為顯示文字增加一個陰影效果.",

	["Counter Size"] = "計數器大小",
	["Set the text size for the charge counters."] = "設定計數器的文字大小.",

	["Name Size"] = "名字大小",
	["Set the text size for the target name."] = "設定目標名字的文字大小.",

------------------------------------------------------------------------

	["Colors"] = "顏色",
	["Set the color for the %s charge counter."] = "設定 %s 計數器的顏色.",

	["Active"] = "激活",
	["Set the color for the target name while your %s is active."] = "設定當你的 %s 已激活時目標名字的顏色.",

	["Overwritten"] = "覆蓋",
	["Set the color for the target name when your %s has been overwritten."] = "設定當你的 %s 被其他人覆蓋時目標名字的顏色",

	["Inactive"] = "未激活",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "設定當你的護盾過期，被驅散或者其他未被激活的情況下的顏色.",

	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "當你的 %s 被其他人覆蓋時除了改變顏色外, 還為目標名字增加 * 號.",

------------------------------------------------------------------------

	["Alerts"] = "警報",
	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "使用這些警報來配置當一個護盾過期或者被移除時發出 ShieldsUp 警報.",

	["Text Alert"] = "文字警報",
	["Show a text message when %s expires."] = "當 %s 到期時顯示一個文本訊息.",

	["Sound Alert"] = "音效警報",
	["Play a sound when %s expires."] = "當 %s 到期時播放一個音效警報.",

	["Sound File"] = "音效檔案",
	["Select the sound to play when %s expires."] = "選擇當 %s 到期時音效警報的檔案",

	["Text Output"] = "文字輸出",

------------------------------------------------------------------------

	["Visibility"] = "能見度",
	["Enable"] = "開啟",
	["Use these settings to control when ShieldsUp should be shown or hidden."] = "使用這些設定來控制 ShieldsUp 什么時候顯示或隱藏.",

	["Group Size"] = "隊伍大小",
	["Solo"] = "獨自戰斗",
	["Show the display while you are not in a group"] = "當你不在一個隊伍時顯示",
	["Party"] = "小隊",
	["Show the display while you are in a party group"] = "當你在一個小隊時顯示",
	["Raid"] = "團隊",
	["Show the display while you are in a raid group"] = "當你在團隊時顯示",

	["Zone Type"] = "區域類型",
	["World"] = "戶外",
	["Show the display while you are in the outdoor world"] = "當你在戶外世界時顯示.",
	["Dungeon"] = "地城",
	["Show the display while you are in a party dungeon"] = "當你在小隊地城時顯示.",
	["Raid Dungeon"] = "團隊副本",
	["Show the display while you are in a raid dungeon"] = "當你在團隊副本時顯示",
	["Arena"] = "競技場",
	["Show the display while you are in a PvP arena"] = "當你在一個PvP競技場時顯示",
	["Battleground"] = "戰場",
	["Show the display while you are in a PvP battleground"] = "當你在一個PvP戰場時顯示.",

	["Exceptions"] = "排除",
	["Dead"] = "死亡",
	["Hide the display while you are dead"] = "當你死亡時隱藏",
	["Out Of Combat"] = "脫離戰斗狀態",
	["Hide the display while you are out of combat"] = "當你脫離戰斗狀態時隱藏",
	["Resting"] = "休息狀態",
	["Hide the display while you are in an inn or major city"] = "當你在旅館或者在主城時隱藏",
	["Vehicle"] = "載具",
	["Hide the display while you are controlling a vehicle"] = "當你正在控制一個載具時隱藏",

------------------------------------------------------------------------

}