import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";
import interactionPlugin from "@fullcalendar/interaction";
import allLocales from "@fullcalendar/core/locales-all";

const calendarEl = document.getElementById("calendar");
const events = JSON.parse(calendarEl.dataset.events);
let currentLocale = allLocales.find((lng) => lng.code === calendarEl.dataset.locale); 
let hide = [], 
    firstRender = true;

const updateHash = (date, type) => {
  let dates = `year=${date.getFullYear()}&month=${date.getMonth()}&day=${date.getDate()}`;
  if (type) {
    dates += `&view=${type}`;
  }
  let filters = $(".calendar-filters .cal-filter:not(.hollow)").map((_, el) => el.id).toArray();
  window.location.hash = `${dates}&filters=${filters.join(",")}`
};

const getInitialDate = () => {
  let today = new Date();
  let year = today.getFullYear();
  let month = today.getMonth();
  let day = today.getDate();
  window.location.hash.substring(1).split("&").forEach((v) => {
    if (v.match("^year")) {
      year = v.substring(5);
    }
    if (v.match("^month")) {
      month = v.substring(6);
    }
    if (v.match("^day")) {
      day = v.substring(4);
    }
  });
  return new Date(year, month, day, 0, 0, 0);
};

const getInitialView = () => {
  let view = calendarEl.dataset.defaultview || "dayGridMonth"
  const isMobile = window.innerWidth < 576;

  if (isMobile) {
    view = "dayGridWeek"; 
  } else {
    window.location.hash.substring(1).split("&").forEach((v) => {
      if (v.match("^view")) {
        view = v.substring(5);
      }
    });
  }
  return view;
};

const getInitialFilters = () => {
  let filters = false;
  window.location.hash.substring(1).split("&").forEach((v) => {
    if (v.match("^filters")) {
      filters = v.substring(8).split(",");
    }
  });
  return filters;
};

const calendar = new Calendar(calendarEl, {
  plugins: [interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin],
  initialView: getInitialView(),
  dayMaxEvents: 3,
  locale: currentLocale,
  firstDay: calendarEl.dataset.hasOwnProperty("firstday") // eslint-disable-line no-prototype-builtins
    ? parseInt(calendarEl.dataset.firstday)
    : 1,
  initialDate: getInitialDate(),
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
    const subtitle = "subtitle" in info.event.extendedProps
      ? ` - ${info.event.extendedProps.subtitle}`
      : "";
    const hour = "hour" in info.event.extendedProps
      ? `${info.event.extendedProps.hour}  `
      : "";
    return {
      html: `<span class="fc-title" >${hour}<b>${info.event.title}</b>${subtitle}</span>`
    };
  },
  eventClick: (info) => {
    if (calendarEl.dataset.openinnewwindow) {
      info.jsEvent.preventDefault(); // don't let the browser navigate

      if (info.event.url) {
        window.open(info.event.url);
      }
    }
  },
  // This ensures to store the hash when changing the view type
  viewClassNames: (info) => {
    if (firstRender) {
      firstRender = false;
      return;
    }
    updateHash(info.view.calendar.getDate(), info.view.calendar.view.type);
  },
  // This ensures to store the hash when changing dates from the buttons
  viewDidMount: (info) => {
    $(calendarEl).find(".fc-prev-button,.fc-next-button,.fc-today-button").on("click", () => {
      updateHash(info.view.calendar.getDate(), info.view.calendar.view.type);
    });
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
    updateHash(calendar.getDate());
    calendar.render()
  });

  // Initial filter values from hash
  let filters = getInitialFilters();
  if (filters !== false) {
    $(".cal-filter").each((_, el) => {
      if (!filters.includes(el.id)) {
        $(el).click();
      }
    });
  }
});
