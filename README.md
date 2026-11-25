# Lilly Technical Challenge - Software Engineer (Assessment Centre)

A fictional medicine tracker. A Python FastAPI backend serves data from
`data.json`; a plain HTML/CSS/JS frontend calls it. Your job is to make the
frontend work.

**Disclaimer:** all medicines in `data.json` are fictional.

## Time and rules
- You have **40 minutes** of coding time.
- This is your own work. **No AI assistants.**
- Documentation sites (MDN, FastAPI docs, etc.) are fine.
- You do not have to finish everything - do the core tasks first.

## The tasks

### Core task 1 - fetch and display `/medicines`
Call `GET http://localhost:8000/medicines` from the frontend and display the
results. The data has problems: some records have a null name, an empty name,
a missing name, a null price, a missing price, or a non-numeric price. Your
display must not crash on any of these. Show something sensible for bad values.

### Core task 2 - call `/medicines/unreliable` and handle failure
`GET http://localhost:8000/medicines/unreliable` returns the same data but
fails about 30% of the time. Call it, show a helpful error message when it
fails, and retry sensibly. **Do not hammer the server** - a few retries with a
short delay, then give up cleanly. Think about what a useful error looks like.

### Stretch (only if you have time)
Add an endpoint in `backend/main.py` that returns the average price of all
medicines, and call it from the frontend. (Ignore records with a non-numeric
or missing price.)

## What's in scope
You may edit:
- `backend/main.py`
- everything in `frontend` (`index.html`, `style.css`, `script.js`)

Do not edit:
- `backend/data.json`
- `backend/requirements.txt`
- `start.sh`, `start.ps1`, `start.bat`

## Running it
Run the start script for your OS (`start.sh` on Mac/Linux, `start.ps1` or
`start.bat` on Windows). It creates a virtual environment, installs
dependencies and starts the server on port 8000. Then open `frontend`
in a browser.

Check `http://localhost:8000/medicines` in your browser to see the raw data.

## What happens next
After the 40 minutes you will walk an interviewer through your code and your
thinking: what you did, what you'd improve, and how you'd handle larger or
messier data. Be ready to explain your choices.
