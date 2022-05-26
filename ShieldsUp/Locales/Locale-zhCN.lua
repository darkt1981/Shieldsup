--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Localization for zhCN / Simplified Chinese / 简体中文
	Last updated 2009-07-15 by www.wowui.cn
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...; if not namespace then namespace = { } _G.ShieldsUpNamespace = namespace end
namespace.L = {

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

	["%s faded!"] = "%s 已消失",
	["%s faded from %s!"] = "%s 在 %s 上消失!",
	["YOU"] = "自身",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

--	["Click for options."] = "",

	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp是一个萨满护盾的监视器。使用这些设定来配置插件的外观和行为.",

	["Horizontal Position"] = "水平位置",
	["Set the horizontal distance from the center of the screen to place the display."] = "设定插件显示的相对于屏幕中间的水平位置.",

	["Vertical Position"] = "垂直位置",
	["Set the vertical distance from the center of the screen to place the display."] = "设定插件显示的相对于屏幕中间的水平位置.",

	["Horizontal Padding"] = "水平间距",
	["Set the horizontal space between the charge counters."] = "设定计数器的水平距离.",

	["Vertical Padding"] = "垂直间距",
	["Set the vertical space between the target name and charge counters."] = "设定目标名字和计数器的垂直距离.",

	["Opacity"] = "不透明度",
	["Set the opacity level for the display."] = "设定显示的不透明度等级.",

--	["Overwrite Alert"] = "",
--	["Print a message in the chat frame alerting you who overwrites your %s."] = "",

------------------------------------------------------------------------

	["Font Face"] = "字体",
	["Set the font face to use for the display text."] = "设定显示文字的字体.",

	["Outline"] = "描边",
	["Select an outline width for the display text."] = "设定显示文字的描边宽度",
	["None"] = "无",
	["Thin"] = "细描边",
	["Thick"] = "粗描边",

	["Shadow"] = "阴影效果",
	["Add a drop shadow effect to the display text."] = "为显示文字增加一个阴影效果.",

	["Counter Size"] = "计数器大小",
	["Set the text size for the charge counters."] = "设定计数器的文字大小.",

	["Name Size"] = "名字大小",
	["Set the text size for the target name."] = "设定目标名字的文字大小.",

------------------------------------------------------------------------

	["Colors"] = "颜色",
	["Set the color for the %s charge counter."] = "设定 %s 计数器的颜色.",

	["Active"] = "激活",
	["Set the color for the target name while your %s is active."] = "设定当你的 %s 已激活时目标名字的颜色.",

	["Overwritten"] = "覆盖",
	["Set the color for the target name when your %s has been overwritten."] = "设定当你的 %s 被其他人覆盖时目标名字的颜色",

	["Inactive"] = "未激活",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "设定当你的护盾过期，被驱散或者其他未被激活的情况下的颜色.",

	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "当你的 %s 被其他人覆盖时除了改变颜色外, 还为目标名字增加 * 号.",

------------------------------------------------------------------------

	["Alerts"] = "警报",
	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "使用这些警报来配置当一个护盾过期或者被移除时发出 ShieldsUp 警报.",

	["Text Alert"] = "文字警报",
	["Show a text message when %s expires."] = "当 %s 到期时显示一个文本讯息.",

	["Sound Alert"] = "音效警报",
	["Play a sound when %s expires."] = "当 %s 到期时播放一个音效警报.",

	["Sound File"] = "音效文件",
	["Select the sound to play when %s expires."] = "选择当 %s 到期时音效警报的文件",

	["Text Output"] = "文字输出",

------------------------------------------------------------------------

	["Visibility"] = "能见度",
	["Use these settings to control when ShieldsUp should be shown or hidden."] = "使用这些设定来控制 ShieldsUp 什么时候显示或隐藏.",
	["Enable"] = "开启",

	["Group Size"] = "队伍大小",
	["Solo"] = "独自战斗",
	["Show the display while you are not in a group"] = "当你不在一个队伍时显示",
	["Party"] = "小队",
	["Show the display while you are in a party group"] = "当你在一个小队时显示",
	["Raid"] = "团队",
	["Show the display while you are in a raid group"] = "当你在团队时显示",

	["Zone Type"] = "区域类型",
	["World"] = "户外",
	["Show the display while you are in the outdoor world"] = "当你在户外世界时显示.",
	["Dungeon"] = "小队副本",
	["Show the display while you are in a party dungeon"] = "当你在小队副本时显示.",
	["Raid Dungeon"] = "团队副本",
	["Show the display while you are in a raid dungeon"] = "当你在团队副本时显示",
	["Arena"] = "竞技场",
	["Show the display while you are in a PvP arena"] = "当你在一个PvP竞技场时显示",
	["Battleground"] = "战场",
	["Show the display while you are in a PvP battleground"] = "当你在一个PvP战场时显示.",

	["Exceptions"] = "排除",
	["Dead"] = "死亡",
	["Hide the display while you are dead"] = "当你死亡时隐藏",
	["Out Of Combat"] = "脱离战斗状态",
	["Hide the display while you are out of combat"] = "当你脱离战斗状态时隐藏",
	["Resting"] = "休息状态",
	["Hide the display while you are in an inn or major city"] = "当你在旅馆或者在主城时隐藏",
	["Vehicle"] = "载具",
	["Hide the display while you are controlling a vehicle"] = "当你正在控制一个载具时隐藏",

------------------------------------------------------------------------

}