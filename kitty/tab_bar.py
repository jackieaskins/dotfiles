# pyright: reportMissingImports=false

import socket
import subprocess

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
)
from kitty.utils import color_as_int


opts = get_options()


def get_color(opt):
    return as_rgb(color_as_int(opt))


class Colors:
    pink = get_color(opts.color5)
    base = get_color(opts.background)
    green = get_color(opts.color2)
    mauve = get_color(opts.mark2_background)


colors = Colors()


def _get_git_branch_text():
    tm = get_boss().active_tab_manager

    if not tm or not tm.active_window or not tm.active_window.cwd_of_child:
        return ""

    cwd = tm.active_window.cwd_of_child
    result = subprocess.run(
        ["git", "-C", cwd, "branch", "--show-current"],
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        return ""

    branch = result.stdout.strip()
    return f"  {branch} " if branch else ""


def _draw_left_status(screen: Screen, tab: TabBarData):
    draw_attributed_string(Formatter.reset, screen)
    screen.cursor.fg = colors.base
    screen.cursor.bg = colors.pink
    screen.cursor.bold = True

    session_text = tab.active_session_name if tab.active_session_name else "-"
    screen.draw(f"  {session_text} ")


def _draw_right_status(screen: Screen):
    draw_attributed_string(Formatter.reset, screen)

    git_branch_text = _get_git_branch_text()
    host_text = f" 󰍹 {socket.gethostname()} "
    text_length = len(f"{git_branch_text}{host_text}")

    num_spaces = screen.columns - screen.cursor.x - text_length
    screen.draw(" " * num_spaces)

    screen.cursor.bold = True

    screen.cursor.fg = colors.base
    screen.cursor.bg = colors.mauve
    screen.draw(git_branch_text)

    screen.cursor.fg = colors.base
    screen.cursor.bg = colors.green
    screen.draw(host_text)


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
):
    tab_fg, tab_bg = screen.cursor.fg, screen.cursor.bg

    if index == 1:
        _draw_left_status(screen, tab)

    draw_attributed_string(Formatter.reset, screen)
    screen.cursor.fg = tab_fg
    screen.cursor.bg = tab_bg
    screen.draw(f" {index} {tab.title} ")

    if is_last:
        _draw_right_status(screen)

    return screen.cursor.x
