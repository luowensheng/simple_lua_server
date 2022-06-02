```lua
local app = Server.new()


app.get("/", function()
    return (
        "<ul>"..
        "<li> <a href=\"/home\">Home</a></li>"..
        "<li> <a href=\"/about\">About</a></li>"..
        "<li><a href=\"/index\">Index</a></li>"..
        "</ul>"
    )
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

app.get("/index", function()
    return "index"
end
)

app.run(8080)

```
