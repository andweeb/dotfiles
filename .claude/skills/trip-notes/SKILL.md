---
name: trip-notes
description: Fill an Obsidian trip note (created from the Trip Notes template) with flights, lodging, and a day-by-day outline. Use when populating a trip-notes note with booking details or an itinerary.
argument-hint: "<trip-note-path> [source files: flight/lodging PDFs]"
---

# Trip Notes Filler

Populate a trip note (frontmatter `type: trip-notes`) with the non-deterministic
content the template leaves blank: flights, lodging, and a rough outline. Read
the note's frontmatter (`start-date`, `end-date`, `destinations`) as the input
contract, and always show proposed Markdown before writing into the note.

## Invocation modes

- **Targeted:** a specific sub-task — "fill flights", "format this lodging
  confirmation", "draft the outline". Run only that piece.
- **End-to-end:** source material and no specific sub-task — run flights →
  lodging → outline in sequence.

## Flights

Delegate to the `flight-extract` skill for each PDF/email confirmation. Insert
the returned Markdown under the note's `### Flights` heading (one `####` block
per leg). Do not re-implement extraction — call `flight-extract`.

## Lodging

Format each lodging confirmation into a block under `### Lodging`:

```markdown
:fab_airbnb: [[Property Name]]
:luc_map_pin: [Full Address](maps-url-if-available)
- [Email Confirmation](url-if-available)
- Booking ID: **[id]**
- Check in: **[Full Day Name] [Month] [Date], [Year]** (after [time])
- Check out: **[Full Day Name] [Month] [Date], [Year]** (before [time])
```

Group multiple stays under `### Lodging`, one block each, in date order. Omit
lines whose data is absent (no placeholders).

## Rough Outline

Draft a day-by-day scaffold under `## Rough Outline` spanning `start-date` to
`end-date`, one bullet per day, seeded from the destinations and any context the
user pastes (group chat, ideas). Leave each day light for the user to fill:

```markdown
## Rough Outline
- **[Month] [Date]:** arrival — [city]
- **[Month] [Date]:** [activity placeholder]
```

## Conventions

Match `flight-extract`: **bold** confirmation codes and date/times, 12-hour time
with AM/PM, full day names, omit absent fields. Always present proposed Markdown
in a fenced ```markdown block first, then ask before writing into the note.
