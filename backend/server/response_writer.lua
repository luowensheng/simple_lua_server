local ResponseWriter = {}

ResponseWriter.new = function ()

    local this = {
        protocol = "HTTP/1.1",
        status_code = 200,
        status="OK",
        content_type = "text/html",
        content = "No Content",
        headers = {}
    }

    this.set_json_content = function (tab)
        this.content_type = "application/json"
        local json = {}
        for key, value in pairs(tab) do
            table.insert(json, key .. ": ".. value)
        end
        local jsonStr =  "{" .. table.concat(json, ", ") .."}"
        this.set_content(jsonStr)
    end

    this.set_content = function (str)
        this.content =  assert(str)
    end


    this.get_response = function ()

        local headers = ""
        for key, value in pairs(this.headers) do
            headers = headers + (key .. ": ".. value .. "\r\n")
        end
        return (
            this.protocol .. " " .. this.status_code .. " " .. this.status .. "\r\n" ..
            "Content-Type: " .. this.content_type ..
            headers .. "\r\n\r\n" ..
            this.content
        )
    end
    
    return this

end


return ResponseWriter
