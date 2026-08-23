---
name: flight-ics
description: Generate an .ics calendar file for flights that imports cleanly into Fantastical (or any calendar). Use when the user wants flight legs added to their calendar, an ics/ical file for a flight, or a booking put on Fantastical.
argument-hint: "[trip-note-path | flight details]"
---

# Flight Calendar (.ics) Generator

Turn flight legs into an `.ics` file the user can double-click to import into Fantastical. Fantastical (Flexibits) has no remote MCP URL / stdio command to register with `claude mcp add` — its connector is Claude Desktop-only — so an `.ics` import is the reliable path from Claude Code.

## Input

Flight details from any source:
- A trip note path (frontmatter `type: trip-notes`) — pull legs from its `### Flights` section
- A pasted confirmation, or details given inline in the conversation

Extract per leg: origin city + IATA code, destination city + IATA code, airline name + flight number, confirmation code, date, departure/arrival times, duration, and baggage. Omit anything absent (no placeholders).

## Conventions

One `VEVENT` per leg. Match this exactly:

- **SUMMARY (title):** `[ORIGIN] to [DEST] ✈️ Flight [AIRLINE_CODE] [NUMBER] ([Airline Full Name])`
  - e.g. `LGB to SJC ✈️ Flight WN 2712 (Southwest)` — airport **codes** only in the title
- **LOCATION:** full street address of the **departing** airport (look it up if not known)
- **DESCRIPTION (notes):** route line, blank line, then one detail per line:
  ```
  [Origin City] ([ORIGIN]) to [Destination City] ([DEST])

  Confirmation Code [CODE]
  Flight [AIRLINE_CODE] [NUMBER] ([Airline Full Name])
  [Full Day Name], [Month] [Date], [DepTime] to [ArrTime]
  Duration: [X]h [Y]m
  [Baggage line, e.g. "1 carryon + 1 personal item (Basic fare)"]
  ```
- **Times:** 12-hour with AM/PM in the notes; full day names.
- **Timezone:** set `DTSTART`/`DTEND` with `TZID` for the **departing** airport's zone, and include a matching `VTIMEZONE` block. Arrival time is in the destination's local zone — for a single-leg VEVENT, use the departing zone for both start/end and let the notes carry the true arrival time (calendars show wall-clock at the departure location, which is what travelers expect for a same-region hop). For legs crossing timezones, set `DTEND` in the arrival zone with its own `VTIMEZONE`.

## ICS escaping (easy to get wrong)

In `TEXT` values (SUMMARY, LOCATION, DESCRIPTION):
- Escape commas as `\,` and semicolons as `\;`
- Line breaks in DESCRIPTION are literal `\n`
- The ✈️ emoji is fine inline (UTF-8)

## Template

```ics
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Claude Code//Trip Flights//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VTIMEZONE
TZID:America/Los_Angeles
BEGIN:DAYLIGHT
TZOFFSETFROM:-0800
TZOFFSETTO:-0700
TZNAME:PDT
DTSTART:19700308T020000
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=2SU
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:-0700
TZOFFSETTO:-0800
TZNAME:PST
DTSTART:19701101T020000
RRULE:FREQ=YEARLY;BYMONTH=11;BYDAY=1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
UID:[unique-slug]@[user]
DTSTAMP:[YYYYMMDDT000000Z]
SUMMARY:LGB to SJC ✈️ Flight WN 2712 (Southwest)
DTSTART;TZID=America/Los_Angeles:20260912T113000
DTEND;TZID=America/Los_Angeles:20260912T124000
LOCATION:Long Beach Airport (LGB)\, 4100 Donald Douglas Dr\, Long Beach\, CA 90808
DESCRIPTION:Long Beach (LGB) to San Jose (SJC)\n\nConfirmation Code BY35EU\nFlight WN 2712 (Southwest)\nSaturday\, September 12\, 11:30AM to 12:40PM\nDuration: 1h 10m\n1 carryon + 1 personal item (Basic fare)
END:VEVENT
END:VCALENDAR
```

Include one `VTIMEZONE` per distinct zone used; add a `VEVENT` per leg. For zones other than `America/Los_Angeles`, swap `TZID`, offsets, and the DST `RRULE`s to match (US zones share the 2nd-Sunday-March / 1st-Sunday-November rule; other regions differ).

## Output

- Write to `~/Downloads/[Trip Name] Flights.ics` (spaces are fine).
- Tell the user they can double-click it, or run `! open ~/Downloads/"...ics"` to send it straight to Fantastical.
- If a trip note was the source, do **not** modify the note — this skill only produces the `.ics`.

## Common Mistakes

- Forgetting to escape commas in dates/addresses (`September 12` → `September\, 12`) — breaks parsing or truncates the field.
- Using real newlines instead of `\n` inside DESCRIPTION.
- Omitting `VTIMEZONE`, which makes calendars guess the zone and shift times.
- Putting the full airport name in the title — use the IATA code there; the full address goes in LOCATION.
- Adding seat numbers when the airline assigns them at check-in (leave them out unless known).
