function drawTimeline()
{
data.push(
{ "start": new Date(1874,0,1), "content": "Launched", "group": "Events", "className": "no-pointer" },
{ "start": new Date(1929,4,3), "content": "Decommissioned", "group": "Events", "className": "no-pointer" },
{ "start": new Date(1963,2,19), "content": "Foundered", "group": "Events", "className": "no-pointer" },

{ "start": new Date(1884,0,28), "content": "Purchased by US Navy", "url": "USS_Bear.htm", "group": "Events" },
{ "start": new Date(1885,3,1), "content": "Transferred to US Revenue Cutter Service", "url": "USRC_Bear.htm", "group": "Events" },

{ "start": new Date(1884,2,17), "end": new Date(1884,9,19), "content": "March to October 1884", "url": "USS_Bear-1884.htm", "group": "Logs" },
{ "start": new Date(1886,4,5), "end": new Date(1887,9,1), "content": "May 1886 to October 1887", "url": "USRC_Bear-1886-1887.htm", "group": "Logs" },
{ "start": new Date(1888,4,26), "end": new Date(1889,10,2), "content": "May 1888 to November 1889", "url": "USRC_Bear-1888-1889.htm", "group": "Logs", },
{ "start": new Date(1890,4,3), "end": new Date(1891,11,12), "content": "May 1890 to December 1891", "url": "USRC_Bear-1890-1891.htm", "group": "Logs" }
);

initTimeline();
if (timeline !== undefined) { timeline.draw(data); if (timelineZoomIn !== undefined) { timelineZoomIn(); } }
}
