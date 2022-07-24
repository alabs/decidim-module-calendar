import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
import interactionPlugin from '@fullcalendar/interaction';

const calendarEl = document.getElementById('calendar');
const events = JSON.parse(calendarEl.dataset.events);
const locale = calendarEl.dataset.locale;
let hide = [];

const calendar = new Calendar(calendarEl, {
	// plugins: ["interaction", "timeGrid", "dayGrid"],
  plugins: [ interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin ],
	defaultView: "dayGridMonth",
	locale: locale || "en",
	header: {
		left: "prev,next today",
		center: "title",
		right: "dayGridMonth,dayGridWeek,dayGridDay"
	},
	eventTimeFormat: {
		hour: "2-digit",
		minute: "2-digit",
		hour12: false,
		omitZeroMinute: false
	},
	events: events,
	eventClassNames: (info) => {
		if(hide.includes(info.event.extendedProps.resourceId)) {
			return [ "hide" ]
		}
	},
	eventContent: (info) => {
		if ("subtitle" in info.event.extendedProps) {
			return { 
				html: `<span class="fc-title"><b>${info.event.title}</b> - ${info.event.extendedProps.subtitle}</span>`
			};
		}
	}
});

$(() => {
	calendar.render();

	$(".cal-filter").on("click", (e) => {
		e.preventDefault();
		const $this = $(e.currentTarget);
	  $this.toggleClass("hollow").blur();
	  hide = [];
	  $(".cal-filter").each((_idx, el) => {
	  	if($(el).hasClass("hollow")) {
	  		hide.push(el.id);
	  	}
	  });
	  calendar.render()
	});
});