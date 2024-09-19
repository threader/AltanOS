function xoopsGetElementById(id) {
if (document.getElementById(id)) {
	return document.getElementById(id);
	} else if (document.all[id]) {
		return document.all[id];
		} else if (document.layers && document.layers[id]) {
			return (document.layers[id]);
			} else {
				return false;
			}
}
function $(id) { return xoopsGetElementById(id);}


function toggle_visibility(id, flag)  {

if ($(id)) {
	$(id).style.visibility = (flag) ? 'visible' : 'hidden';
	}
}


function justReturn() {
	return;
}


function openWithSelfMain(url,name,width,height) {
var options = "width=" + width + ",height=" + height + "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no";

new_window = window.open(url, name, options);
window.self.name = "main";
new_window.moveTo(((screen.availWidth/2)-(width/2)),((screen.availHeight/2)-(height/2)))
new_window.focus();
}


function setElementColor(id, color) {
	$(id).style.color = "#" + color;
}


function setElementFont(id, font) {$(id).style.fontFamily = font;}


function setElementSize(id, size) {$(id).style.fontSize = size;}


function changeDisplay(id) {
var elestyle = $(id).style;

if (elestyle.display == "") {
	elestyle.display = "none";
	} else {
		elestyle.display = "block";
	}
}

function toggleDisplay(id) {
var elestyle = $(id).style;

if (elestyle.display == "block" || elestyle.display == "") {
	elestyle.display = 'none';
	} else {
		elestyle.display = "block";
	}
}

function setVisible(id) {$(id).style.visibility = "visible";}

function setHidden(id) {$(id).style.visibility = "hidden";}


function makeBold(id) {
var eleStyle = $(id).style;

if (eleStyle.fontWeight != "bold") {
	eleStyle.fontWeight = "bold";
	} else {
		eleStyle.fontWeight = "normal";
	}
}


function makeItalic(id) {
var eleStyle = $(id).style;

if (eleStyle.fontStyle != "italic") {
	eleStyle.fontStyle = "italic";
	} else {
		eleStyle.fontStyle = "normal";
	}
}


function makeUnderline(id) {
var eleStyle = $(id).style;

if (eleStyle.textDecoration != "underline") {
	eleStyle.textDecoration = "underline";
	} else {
		eleStyle.textDecoration = "none";
	}
}


function appendSelectOption(selectMenuId, optionName, optionValue) {
var selectMenu = $(selectMenuId);
var newoption  = new Option(optionName, optionValue);

selectMenu.options[selectMenu.length] = newoption;
selectMenu.options[selectMenu.length].selected = true;
}


function disableElement(target) {
var targetDom = $(target);

if (targetDom.disabled != true) {
	targetDom.disabled = true;
	} else {
		targetDom.disabled = false;
	}
}


function xoopsCheckAll(formname, switchid) {
var ele = document.forms[formname].elements;
var switch_cbox = $(switchid);

for (var i=0; i<ele.length; i++) {
	var e = ele[i];
	if ( (e.name != switch_cbox.name) && (e.type == 'checkbox') ) {
		e.checked = switch_cbox.checked;
	}
}
}
