-- hyprdnd-for-yazi.yazi
-- Async plugin: hakee cwd+valinnat sync-osiosta, ja spawn:aa ctl-komennon Command()-APIlla.

local function collect()
  local tab = cx.active
  local cwd = tostring(cx.active.current.cwd)

  local selected = tab.selected
  if #selected == 0 then
    local h = tab.current.hovered
    if h and h.url then
      selected = { h.url }
    end
  end

  local out = {}
  for _, u in ipairs(selected) do
    out[#out + 1] = tostring(u)
  end

  return cwd, out
end

return {
  entry = function()
    local cwd, paths = ya.sync(function()
      return collect()
    end)

    local cmd = Command("hyprdnd-for-yazi")
      :arg({ "ctl", "toggle", "--cwd", cwd })

    if #paths > 0 then
      cmd = cmd:arg(paths)
    end

    local _, err = cmd
      :stdout(Command.NULL)
      :stderr(Command.NULL)
      :spawn()

    if err then
      ya.notify({
        title = "hyprdnd-for-yazi",
        content = "Failed to run ctl toggle: " .. tostring(err),
        timeout = 3,
      })
    end
  end,
}
