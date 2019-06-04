// this sets the background color of the master UIView (when there are no windows/tab groups on it)

Titanium.UI.setBackgroundColor('#000');
// create tab group
var tabGroup = Titanium.UI.createTabGroup();

//
// create base UI tab and root window
//
var win = require('main.js').getMain();

var tab1 = Titanium.UI.createTab({
	window: win
});
tabGroup.bottom = -100;


tabGroup.addTab(tab1);

// open tab group
setTimeout(function () {
	win.open()

}, 3000);
