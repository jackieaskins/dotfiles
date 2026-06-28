import json
import os
import subprocess

from functools import reduce
from kitty.boss import Boss  # type: ignore
from kittens.tui.handler import kitten_ui  # type: ignore

HOME_DIR = os.environ["HOME"]
SESSION_DIR = f"{HOME_DIR}/.config/kitty/sessions/"
SESSION_EXT = ".kitty-session"
ICONS = {
    "zoxide": {"text": "", "color": "36"},
    "saved": {"text": "", "color": "33"},
}


def get_sessions(active_session_names):
    session_keys = []
    active_sessions = []
    inactive_sessions = []

    directories = (
        subprocess.run(["zoxide", "query", "--list"], text=True, capture_output=True)
        .stdout.strip()
        .splitlines()
    )

    for file in os.listdir(SESSION_DIR):
        workspace = file.replace(SESSION_EXT, "")
        session_keys.append(workspace)

        is_active = workspace in active_session_names
        session = {
            "type": "saved",
            "workspace": workspace,
            "display": f"Active: {workspace}" if is_active else workspace,
            "session_file": f"{SESSION_DIR}{file}",
        }

        if is_active:
            active_sessions.append(session)
        else:
            inactive_sessions.append(session)

    for directory in directories:
        replaced_directory = directory.replace(HOME_DIR, "~")
        workspace = os.path.basename(directory)
        if workspace not in session_keys:
            inactive_sessions.append(
                {
                    "type": "zoxide",
                    "workspace": workspace,
                    "display": replaced_directory,
                    "directory": replaced_directory,
                }
            )

    return active_sessions + inactive_sessions


def render_icon(icon):
    return icon["text"]


def get_fzf_input(sessions):
    choices = []

    for session in sessions:
        icon = ICONS[session["type"]]
        choices.append(f"{render_icon(icon)} {session["display"]}")

    return "\n".join(choices)


def get_fzf_choice(sessions):
    choice = subprocess.run(
        [
            "fzf",
            "--no-multi",
            "--ansi",
            "--no-preview",
            "--no-sort",
            "--list-border=none",
        ],
        input=get_fzf_input(sessions),
        text=True,
        capture_output=True,
    ).stdout

    return os.path.basename(
        reduce(
            (lambda accum, icon: accum.replace(render_icon(icon), "")),
            ICONS.values(),
            choice,
        ).strip()
    )


def create_session_file(session, session_file):
    if session["type"] == "zoxide":
        with open(session_file, "x") as f:
            f.write(
                "\n".join(
                    [
                        "new_tab",
                        f"cd {session["directory"]}",
                        "launch",
                        "",
                        "focus_tab 0",
                        "focus_os_window",
                    ]
                )
            )


def get_active_session_names(ls_output):
    active_session_names = set()

    for os_window in ls_output:
        for tab in os_window["tabs"]:
            for window in tab["windows"]:
                active_session_names.add(window["session_name"])

    return active_session_names


@kitten_ui(allow_remote_control=True)
def main(_: list[str]) -> str:
    try:
        cp = main.remote_control(["ls"], capture_output=True)  # type: ignore
        output = json.loads(cp.stdout.decode())

        active_session_names = get_active_session_names(output)
        sessions = get_sessions(active_session_names)
        choice = get_fzf_choice(sessions)

        session = next(filter(lambda session: session["workspace"] == choice, sessions))
        session_file = (
            session["session_file"]
            if session["type"] == "saved"
            else f"{SESSION_DIR}{session["workspace"]}{SESSION_EXT}"
        )

        create_session_file(session, session_file)

        return session_file
    except:
        print("Something went wrong")

    return ""


def handle_result(
    _: list[str], session_file: str, target_window_id: int, boss: Boss
) -> None:
    w = boss.window_id_map.get(target_window_id)
    if w and session_file != "":
        boss.call_remote_control(w, ("action", "goto_session", session_file))
