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
gem "decidim-calendar"
```

Run this rake tasks:

```bash
bundle exec rake decidim_calendar:install:migrations
bundle exec rake db:migrate
```

To keep the gem up to date, you can use the commands above to also update it.

## Contributing

For instructions how to setup your development environment for Decidim, see
[Decidim](https://github.com/decidim/decidim). Also follow Decidim's general
instructions for development for this project as well.

## Developing

Clone this repository or fork and run:

```bash
bundle install
rake development_app
```

### Localization

If you would like to see this module in your own language, you can help with
its translation at Crowdin:

[https://crowdin.com/project/decidim-calendar](https://crowdin.com/project/decidim-calendar)
