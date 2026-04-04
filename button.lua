local buttons = {}

function addsidebarbtn(id, name)

    buttons[id] = {id = id, name = name}
end

function addButton(id, name)


    buttons[id] = {id = id, name = name}
end

return {
    addButton = addButton
}
