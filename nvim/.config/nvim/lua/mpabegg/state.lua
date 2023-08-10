local M = {}

M.state = {
  inlay_hint = false,
}

---Toggles the value of @prop
---@param prop string
function M.toggle(prop)
  if M.state[prop] == nil then
    M.state[prop] = true
  else
    M.state[prop] = not M.state[prop]
  end
end

---Get value of @prop
---@param prop string
---@return any
function M.get(prop)
  return M.state[prop]
end

return M
