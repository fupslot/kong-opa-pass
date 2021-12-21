local access = require "kong.plugins.opa-pass.access"


local OpaPass = {
    PRIORITY = 900,
    VERSION = "0.1",
}

function OpaPass:access(conf) 
    access.execute(conf)
end

return OpaPass