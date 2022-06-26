#!/usr/bin/env node

const { osa } = require("../utils/shell");
const { setSketchybarItem } = require("../utils/shell");
const { getNowPlaying, isSpotifyRunning } = require("../utils/spotify");

const MAX_WIDTH = 30;

const { NAME, INFO, SENDER } = process.env;

const isRunning = isSpotifyRunning();

if (SENDER === "mouse.entered") {
  if (isRunning) {
    setSketchybarItem(NAME, { "popup.drawing": "on" });
  }
  process.exit(0);
}

if (SENDER === "mouse.exited") {
  setSketchybarItem(NAME, { "popup.drawing": "off" });
  process.exit(0);
}

if (!isRunning || INFO?.includes('"Player State" : "Stopped"')) {
  setSketchybarItem(NAME, {
    click_script: "open -a Spotify",
    icon: "",
    "label.drawing": "off",
  });
  process.exit(0);
}

const isPlaying =
  osa(
    'if application "Spotify" is running then tell application "Spotify" to get player state as string'
  ) === "playing";

setSketchybarItem(NAME, {
  click_script: "osascript -e 'tell application \"Spotify\" to playpause'",
  icon: isPlaying ? "􀊆" : "􀊄",
  label: getNowPlaying(MAX_WIDTH),
  "label.drawing": "on",
});
