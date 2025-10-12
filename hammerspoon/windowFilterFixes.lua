-- https://github.com/Hammerspoon/hammerspoon/issues/2943#issuecomment-2105644391
function _wf_timed_allWindows()
  local r = {}
  for _, app in ipairs(hs.application.runningApplications()) do
    local starttime = hs.timer.secondsSinceEpoch()
    local _, name = app:allWindows(), string.format('%s (%s)', app:name() or 'N/A', app:bundleID() or 'N/A')
    r[name] = (r[name] or 0) + hs.timer.secondsSinceEpoch() - starttime
  end
  for app, time in pairs(r) do
    if time > 0.05 then
      print(string.format('took %.2fs for %s', time, app))
    end
  end
  return r
end

function _wf_ignoreWebContent()
  for _, app in pairs(hs.application.runningApplications()) do
    local name = app:name()
    if name and (name:match(' Web Content$') or app:bundleID() == 'com.apple.WebKit.WebContent') then
      hs.window.filter.ignoreAlways[name] = true
    end
  end
end

hs.timer.doEvery(15, _wf_ignoreWebContent)
_wf_ignoreWebContent()
