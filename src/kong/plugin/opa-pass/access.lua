local http = require "resty.http"
local cjson = require "cjson"

local _M = {}

local function getPayload(conf)
    local original_url = kong.request.get_path()

    local headers = {}
    for _, header in ipairs(conf.request.headers_to_forward) do
        local value = ngx.req.get_headers()[header]
        if value then
            headers[header] = value
        end
    end

    local origin_host = ngx.req.get_headers()["Host"]
    local origin_path = ngx.var.request_uri
    local origin_method = ngx.req.get_method()
    local origin_protocol = ngx.req.get_protocol()
    
    -- this is the payload that will be sent to the OPA server
    local payload = {
        attributes = {
            request = {
                http = {
                    url = original_url,
                    headers = headers,
                    host = origin_host,
                    method = origin_method,
                    path = origin_path,
                    protocol = origin_protocol,
                }
            }
        }
    }

    -- todo: parse jwt token on condition if conf.jwt_token_parse is true

    if conf.request.body then
        if ngx.req.get_headers()["Content-Type"] == "application/json" then
            payload.attributes.request.body = cjson.decode(ngx.req.get_body_data())
        end
    end

    return payload
end

local function getDocument(conf, payload)
    local httpc = require("resty.http").new()
    
    -- todo: support tls connections

    local headers = {
        charset = "utf-8",
        ["Content-Type"] = "application/json"
    }

    -- todo: support authentication=token scheme
    -- see https://www.openpolicyagent.org/docs/latest/security/#authentication-and-authorization

    local res, err = httpc:request_uri(conf.server.url, {
        method = "POST",
        body = cjson.encode(payload),
        headers = headers,
        keepalive_timeout = conf.server.keepalive_timeout,
        keepalive_pool = conf.server.keepalive_pool,
    })

    if err then
        return error(err)
    end

    return assert(cjson.decode(res.body))
end

function _M.execute(conf)
    local ok, payload = pcall(getPayload, conf)
    if not ok then
        return kong.response.exit(500, { message = "Something went wrong" })
    end

    local ok, res = pcall(getDocument, conf, payload)
    if not ok then
        return kong.response.exit(500, { message = "Something went wrong" })
    end

    -- todo: when the policy is not found, the OPA server returns a 404
    if res.status == 404 then
        return kong.response.exit(404, { message = "Policy not found" })
    end
    -- todo: when the authorization fails, the OPA server returns a 403
    if res.status > 299 then
        return kong.response.exit(res.status, { message = "Unexpected error occurred" })
    end
    -- todo: when the policy is found but the authorization fails, the OPA server returns a 200

end

return _M