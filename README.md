# Decidim::Calendar

![Build](https://github.com/alabs/decidim-module-calendar/workflows/Ruby/badge.svg)
[![Coverage](https://img.shields.io/codeclimate/coverage/alabs/decidim-module-calendar.svg)](https://codeclimate.com/github/alabs/decidim-module-calendar)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/alabs/decidim-module-calendar.svg)](https://codeclimate.com/github/alabs/decidim-module-calendar/maintainability)

This [Decidim](https://github.com/decidim/decidim) module enable a multitenant
global calendar for Consultations, Debates, External Events, Meetings and
Participatory Processes. Giving a snapshot of all current activities in a
calendar view form.

![decidim-calendar](docs/decidim-calendar.png)

## Features

- Display past and future events in from of calendar and agenda.
- Display gantt graph of participatory processes
- Download ICAL for import

## Instalation

Edit the Gemfile and add this lines:

```ruby
gem "decidim-calendar", git: "https://github.com/openpoke/decidim-module-calendar"
```

Run this rake tasks:

```bash
bundle exec rake decidim_calendar:install:migrations
bundle exec rails decidim_calendar:webpacker:install
bundle exec rake db:migrate
```

To keep the gem up to date, you can use the commands above to also update it.

## Configuration

You don't need to do anything if you are happy with the default colors and configuration of the calendar.

If you want to customize some of the aspects, create an initializer (ie: `config/initializer/decidim_calendar.rb`), paste the default configuration and modify according to your needs:


```ruby
Decidim::Calendar.configure do |config|
  # Colors per type of event
  # You can generate a nice color palette here: https://coolors.co
  # Just remove any event type that you don't want in your calendar
  config.events = {
    "Decidim::ParticipatoryProcessStep" => {
      color: "#3A4A9F",
      fontColor: "#fff", # used when "color" is used as background
      id: :participatory_step
    },
    "Decidim::Meetings::Meeting" => {
      color: "#ed1c24",
      fontColor: "#fff",
      id: :meeting
    },
    "Decidim::Calendar::ExternalEvent" => {
      color: "#ed650b",
      fontColor: "#fff",
      id: :external_event
    },
    "Decidim::Debates::Debate" => {
      color: "#099329",
      fontColor: "#fff",
      id: :debate
    },
    # optional events, it is save to define it here even if not installed (will be ignored)
    "Decidim::Consultation" => {
      color: "#92278f",
      fontColor: "#fff",
      id: :consultation
    }
  }

  config.calendar_options = {
    # 0 for sunday, 1 for monday, etc
    firstDay: 1,
    # one of: dayGridMonth,dayGridWeek,dayGridDay,listWeek,listMonth,list
    defaultView: "dayGridMonth",
    # use "true" to get a am/pm format
    hour12: false,
    # several of: dayGridMonth,dayGridWeek,dayGridDay,listWeek,listMonth,listYear
    views: "dayGridMonth,dayGridWeek,dayGridDay,listWeek",
    # Forces to open all event links in a new window
    openInNewWindow: true
  }
end
```

### Advanced configuration

You can also make use of your custom event models. For that you only need to ensure that these propoerties are returned by the module:

- `id`: the unique ID of the event
- `title`: the title of the event
- `start_date`: the start date of the event (can also be named `start_time`)
- `end_date`: the end date of the event (can also be named `end_time`)
- `subtitle`: (optional) the subtitle of the event
- `url`: (optional) the url of the event

By default the model is queried using the default scope of the model.
You can customized the amount of rows extracted by creating a new object and defining a `default_scope`:

```ruby
# /app/models/recent_meetings
class RecentMeetings < Decidim::Meetings::Meeting
  default_scope -> { where("start_time > ?", 1.years.ago) }

  # You can customize the title for instance
  def title
    "Recent Event: #{super}"
  end
end
```

Then, in your initializer:

```ruby
Decidim::Calendar.configure do |config|
  config.events = {
...,
    "RecentMeetings" => {
      color: "#ed1c24",
      fontColor: "#fff",
      id: :recent_meeting
    },
...
  }
end
```

## Contributing

For instructions how to setup your development environment for Decidim, see
[Decidim](https://github.com/decidim/decidim). Also follow Decidim's general
instructions for development for this project as well.

## Developing

Clone this repository or fork and run:

```bash
bundle install
bundle exec rake development_app
```

### Localization

If you would like to see this module in your own language, you can help with
its translation at Crowdin:

[https://crowdin.com/project/decidim-calendar](https://crowdin.com/project/decidim-calendar)
