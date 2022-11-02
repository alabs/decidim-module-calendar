import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";
import interactionPlugin from "@fullcalendar/interaction";
import allLocales from "@fullcalendar/core/locales-all";

const calendarEl = document.getElementById("calendar");
const events = JSON.parse(calendarEl.dataset.events);
let currentLocale = allLocales.find((lng) => lng.code === calendarEl.dataset.locale); 
let hide = [];

const calendar = new Calendar(calendarEl, {
  plugins: [interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin],
  defaultView: calendarEl.dataset.defaultView || "dayGridMonth",
  locale: currentLocale,
  firstDay: calendarEl.dataset.firstDay || 1,
  headerToolbar: {
    left: "prev,next today",
    center: "title",
    right: calendarEl.dataset.views || "dayGridMonth,dayGridWeek,dayGridDay,listWeek"
  },
  buttonIcons: false,
  eventTimeFormat: {
    hour: "2-digit",
    minute: "2-digit",
    hour12: Boolean(calendarEl.dataset.hour12),
    omitZeroMinute: false
  },
  events: events,
  eventClassNames: (info) => {
    if (hide.includes(info.event.extendedProps.resourceId)) {
      return ["hide"]
    }
    return [];
  },
  eventContent: (info) => {
    if ("subtitle" in info.event.extendedProps) {
      return { 
        html: `<span class="fc-title"><b>${info.event.title}</b> - ${info.event.extendedProps.subtitle}</span>`
      };
    }
    return { 
      html: `<span class="fc-title">${info.event.title}</span>`
    };
  }
});

$(() => {
  calendar.render();

  $(".cal-filter").on("click", (evt) => {
    evt.preventDefault();
    const $this = $(evt.currentTarget);
    $this.toggleClass("hollow").blur();
    hide = [];
    $(".cal-filter").each((_idx, el) => {
      if ($(el).hasClass("hollow")) {
        hide.push(el.id);
      }
    });
    calendar.render()
  });
});
