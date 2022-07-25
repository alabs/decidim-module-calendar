/* eslint-disable camelcase, no-new */

import Gantt from "frappe-gantt";
const tasks = JSON.parse(document.getElementById("gantt").dataset.tasks);

new Gantt("#gantt", tasks, {
  view_modes: ["Quarter Day", "Half Day", "Day", "Week", "Month"],
  view_mode: "Month",
  custom_popup_html: null
});
