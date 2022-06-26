#!/usr/bin/env node

const { getNowPlaying, isSpotifyRunning } = require("../utils/spotify");
const { setSketchybarItem } = require("../utils/shell");

const { NAME, INFO } = process.env;

if (
  isSpotifyRunning() &&
  (!INFO || !INFO.includes('"Player State" : "Stopped"'))
) {
  setSketchybarItem(NAME, { label: getNowPlaying() });
}
