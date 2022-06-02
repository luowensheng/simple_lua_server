```lua
local app = Server.new()


app.get("/", function()
    return "Hello world"
end
)

app.get("/home", function()
    return  "home"
end
)

app.get("/about", function()
    return "about"
end
)
```