var timeline;
var data = [
{ "start": new Date(1861,3,12), "end": new Date(1865,3,9), "content": "American Civil War", "group": "Period", "className": "period" },
{ "start": new Date(1865,3,10), "end": new Date(1898,3,24), "content": "Arctic Frontier", "group": "Period", "className": "period" },
{ "start": new Date(1898,3,25), "end": new Date(1898,7,12), "content": "American-Spanish War", "group": "Period", "className": "period" },
{ "start": new Date(1898,7,13), "end": new Date(1917,3,5), "content": "Arctic Frontier",
  "group": "Period", "className": "period" },
{ "start": new Date(1917,3,6), "end": new Date(1918,10,11), "content": "War in the Arctic (WW1)", "group": "Period", "className": "period" },
{ "start": new Date(1918,10,12), "end": new Date(1941,11,6), "content": "Arctic Frontier", "group": "Period", "className": "period" },
{ "start": new Date(1941,11,7), "end": new Date(1945,8,2), "content": "War in the Arctic (WW2)", "group": "Period", "className": "period" },
{ "start": new Date(1945,8,3), "content": "Cold Science", "group": "Period", "type": "floatingRange", "className": "period" }
];

function initTimeline()
{
var options = {
"width":  "100%",
"minHeight": 100,
"editable": false,
"eventMargin": 5,
"eventMarginAxis": 8,
"zoomMin": 1000 * 60 * 60 * 24 * 365,
"showNavigation": true,
"style": "box",
"groupsDontStack": [ "Logs", "Period" ],
"groupMinHeight": 20,
"groupsOrder": false
};
var container = document.getElementById("timeline");
if (container !== null) {
timeline = new links.Timeline(container, options);
timeline.options.min = new Date(1850,0,1);
timeline.options.max = new Date(1999,11,31);
links.events.addListener(timeline, "select", onSelect);
var instructions = document.createElement("p");
instructions.className = "timeline-instruction";
instructions.innerHTML = "Move the timeline by clicking and dragging, or by sliding on touch screens. Zoom by turning your mouse wheel or by clicking (or tapping) the controls in the top right corner.<br>Click <span class='timeline-blue'>blue</span> and <span class='timeline-green'>green</span> coloured events to open relevant pages.";
container.appendChild(instructions);
}
function onSelect() {
var sel = timeline.getSelection();
if (sel.length) {
if (sel[0].row !== undefined) {
var row = sel[0].row;
if (row < data.length) {
if (data[row].url !== undefined) { window.location = data[row].url; }
}}}
timeline.setSelection([]);
}
}
