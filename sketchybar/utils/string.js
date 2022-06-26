function truncate(str, maxWidth) {
  if (!str || str.length <= maxWidth) {
    return str;
  }

  return `${str.substring(0, maxWidth - 3)}...`;
}

module.exports = { truncate };
