---
name: flight-extract
description: Extract flight details from PDF confirmation files and generate formatted Markdown for Obsidian trip notes. Use when processing airline booking confirmations.
argument-hint: "<pdf-path> [pdf-path-2 ...]"
---

# Flight Confirmation Extractor

Extract flight booking details from PDF confirmation files and output formatted Markdown sections for Obsidian trip notes.

## Input

One or more PDF file paths passed as arguments:
```
/flight-extract ~/Downloads/flight-confirmation.pdf
/flight-extract ~/Downloads/outbound.pdf ~/Downloads/return.pdf
```

## Processing

1. **Read each PDF** using the Read tool (it supports PDFs natively).
2. **Parse flight details** from the confirmation. These may be in any language (Spanish, English, etc.) and from any airline. Extract:
   - Airline name and IATA code
   - Flight number
   - Confirmation/reservation code
   - Departure: city, airport code, date, time, terminal (if stated)
   - Arrival: city, airport code, date, time, terminal (if stated)
   - Flight duration (calculate from times + timezone difference if not explicit)
   - Seat assignment (if available)
   - Baggage allowance (if available)
3. **Output formatted Markdown** per the template below.

## Output Format

For each flight leg, output a block like this:

```markdown
#### [ORIGIN_CODE] to [DEST_CODE]
[Origin City] ([ORIGIN_CODE]) to [Destination City] ([DEST_CODE])
- Confirmation Code **[CODE]**
- Flight [AIRLINE_CODE] [NUMBER] ([Airline Full Name])
- **[Full Day Name], [Month] [Date], [DepartureTime]** to **[ArrivalTime]**
	- [Terminal info, e.g. "Terminal 2" or "TBIT to Terminal 1"]
	- Duration: [X]h [Y]m
	- Seat: [seat] *(only if available)*
	- [Baggage info, e.g. "1 personal item + 1 carry-on"] *(only if available)*
```

If multiple flights are extracted, wrap them all under a single `### Flights` heading.

### Conventions

- Confirmation codes are always **bold**
- Departure and arrival date/times are always **bold**
- Use 12-hour time format with AM/PM (e.g. 7:00AM, 11:40PM)
- Use full day names (e.g. "Saturday", not "Sat")
- Terminal info, duration, seat, and baggage are indented sub-bullets under the date/time line
- Omit fields that are not present in the PDF (no placeholders)
- If duration is not stated, calculate it from departure/arrival times accounting for timezone differences between origin and destination
- Do not include fare class, e-ticket numbers, or other extras beyond what's listed above

### Example Output

```markdown
### Flights
#### MEX to MID
Ciudad de Mexico (MEX) to Merida (MID)
- Confirmation Code **YTUSBS**
- Flight AM 822 (Aeromexico)
- **Saturday, February 28, 7:00AM** to **9:01AM**
	- Terminal 2
	- Duration: 2h 1m

#### MID to MEX
Merida (MID) to Ciudad de Mexico (MEX)
- Confirmation Code **LBBVJC**
- Flight VB 1109 (Viva Aerobus)
- **Saturday, February 28, 9:40PM** to **11:40PM**
	- Terminal 1
	- Duration: 2h 0m
```

## After Output

**IMPORTANT: Always present the extracted flight information as raw Markdown in a fenced code block (```markdown ... ```) so the user can copy it directly.** Do not render it as formatted text.

Then ask if they'd like it inserted into a specific trip note file, or if any adjustments are needed.
