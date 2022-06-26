#!/usr/bin/env node

const { spawnSync } = require("child_process");
const { setSketchybarItem } = require("../utils/shell");

const { NAME, SENDER } = process.env;

function show() {
  setSketchybarItem(NAME, { drawing: "on" });
}

function hide() {
  setSketchybarItem(NAME, { drawing: "off" });
}

if (SENDER === "dnd_disabled") {
  hide();
} else if (SENDER === "dnd_enabled") {
  show();
} else {
  // TODO: Figure out a more reliable way to get DND status

  // This requires DND to be included in menu bar
  const { stdout } = spawnSync("defaults", [
    "read",
    "com.apple.controlcenter",
    "'NSStatusItem Visible FocusMode'",
  ]);

  stdout.toString().trim() === "1" ? show() : hide();
}
