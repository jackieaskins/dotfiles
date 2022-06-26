const { truncate } = require("./string");
const { osa } = require("./shell");

function isSpotifyRunning() {
  return osa('if application "Spotify" is running then return 1') === "1";
}

function getNowPlaying(maxWidth) {
  const artist = osa(
    'tell application "Spotify" to get artist of current track as string'
  );
  const track = osa(
    'tell application "Spotify" to get name of current track as string'
  );

  const nowPlaying = `${artist} - ${track}`;

  return maxWidth ? truncate(nowPlaying, maxWidth) : nowPlaying;
}

module.exports = { getNowPlaying, isSpotifyRunning };
