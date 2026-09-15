> Source: https://wiki.servarr.com/radarr/calendar



# <a href="#calendar" class="toc-anchor">¶</a> Calendar

The calendar tab allows you to see any upcoming films (or recently released) that is presently monitored in your library.

## <a href="#views" class="toc-anchor">¶</a> Views

The calendar can be displayed in several views, selectable from the calendar header:

- Day
- Week
- Month
- Forecast
- Agenda

## <a href="#legend" class="toc-anchor">¶</a> Legend

Events on the calendar are color coded to indicate their status:

- Downloaded and Monitored
- Downloaded but not Monitored
- Missing, Monitored, and Considered Available
- Missing, not Monitored
- Queued
- Unreleased

> The cutoff-unmet icon is only shown when the **Icon for Cutoff Unmet** calendar option is enabled.

## <a href="#calendar-options" class="toc-anchor">¶</a> Calendar Options

The calendar options (the gear/options modal) let you control what is displayed:

- **Show Movie Information** - Show movie information such as title and year
- **Show Cinema Release** - Show the cinema/theatrical release date
- **Show Digital Release** - Show the digital release date
- **Show Physical Release** - Show the physical release date
- **Icon for Cutoff Unmet** - Show an icon for files when the quality cutoff has not been met
- **Full Color Events** - Make the entire event background the status color rather than a colored edge

Global display options (shared with the rest of the UI) such as **First Day of Week**, **Week Column Header**, **Time Format**, and **Enable Color-Impaired Mode** are also available here.

# <a href="#ical-feed" class="toc-anchor">¶</a> iCal Feed

Radarr can provide your calendar as an iCal feed at `/feed/v3/calendar/Radarr.ics`. By default the feed contains the previous <a href="https://github.com/Radarr/Radarr/blob/develop/src/Radarr.Api.V3/Calendar/CalendarFeedController.cs" class="is-external-link">7 days</a> (`pastDays`) and the next <a href="https://github.com/Radarr/Radarr/blob/develop/src/Radarr.Api.V3/Calendar/CalendarFeedController.cs" class="is-external-link">28 days</a> (`futureDays`).

The feed link can be generated in the calendar via the iCal feed button, where you can choose:

- **Include Unmonitored** - Include unmonitored movies in the feed (`unmonitored`)
- **Show as All-Day Events** - Display releases as all-day events
- **Release Types** - Which release dates to include: Cinema Release, Digital Release, and/or Physical Release (`releaseTypes`)
- **Tags** - Limit the feed to movies with the selected tag(s) (`tags`)

> Google Calendar has internal issues that result in it no longer updating. This is a Google issue and not a Radarr issue. It can often be resolved by removing and re-adding the calendar.


