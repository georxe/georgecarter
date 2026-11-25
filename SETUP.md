# Before the assessment day - setup check

Please do this before you arrive. It takes about 10 minutes and makes sure
your laptop is ready. You do **not** need to clone the challenge or read
anything - you will get the code on the day.

## 1. Install Python 3

Download from https://www.python.org/downloads/ and run the installer.
On Windows, tick "Add Python to PATH" during installation.

## 2. Install Git

Download from https://git-scm.com/downloads and run the installer. Add Git to
your PATH if asked.

## 3. Check both are installed

Open a terminal (Terminal on Mac/Linux, PowerShell on Windows) and run:

```
python --version
git -v
```

You should see version numbers for both. If either says "command not found",
Python or Git is not on your PATH - reinstall it and make sure the PATH option
is ticked, then try again.

That's all you need to do before the day. You will clone the repo and start the
server when you arrive.

## Troubleshooting (for the day)

- **`python` or `git` not found**: reopen the terminal after installing; if it
  still fails, the program is not on your PATH - reinstall and tick the PATH
  option.
- **`port 8000 already in use`**: something else is using port 8000. Find and
  stop it, or ask a monitor for help.
- **Start script errors after a failed first run**: delete the `venv` folder
  (it may be inside `backend`) and run the start script again.
- **Other laptop/environment problems**: ask a monitor. They can help with
  your laptop and setup, but not with the code.
