-- button.lua (legacy compat — asıl element mantığı elements.lua içinde)
local buttons = {}

function addButton(id, name)
    buttons[id] = {id = id, name = name}
end

return {
    addButton = addButton
}