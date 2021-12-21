## kong-opa-pass

[Kong](https://konghq.com/) plugin that forwards request to Open Policy Agent and process the request only if the authorization policy allows for it.

## Description

TODO: describe what this plugin for

## Configuration Example

```yml
config:
    server:
        url: http://localhost:8181/v1/data/
        keepalive_timeout: 60000
        keepalive_pool: 100
    request:
        headers_to_forward:
            - host
            - authorization
            - x-forwarded-for
            - x-forwarded-proto
            - x-real-ip
            - x-forwarded-host
            - x-forwarded-server
            - x-forwarded-port
            - x-forwarded-prefix
            - x-forwarded-scheme
            - x-forwarded-uri
        body: false
        always_pass_forward: false
```

### Parameters

This table shows a list of configuration atributes that can be used to change the plugin behaviour

Default values are shown in the example configuration above.

| Name | Default | Description |
| ---  |   ---   |     ---     |
| `server.url` | - | A path to OPA policy document including a protocl and host. Example: `http://localhost:8181/v1/data/allow` |
| `server.keepalive_timeout` | 60000 | The maximal idle timeout (ms).  |
| `server.keepalive_pool` | 100 | The maximal idle timeout (ms). |
| `request.headers_to_forward` | - | List of headers that will be forwarded to OPA as part of an input object. Above you see the default list of headers |
| `request.body` | false | When set `true` the original request body will be forwarded to OPA as part of an input object. Only when the original request `Content-Type` set to `application/json` |
| `request.always_pass_forward` | false | When set to `true` kong will forward the original request to the downstream event it OPA's decision is `false`. Helpful when the final decision needs to be made down the road. Additionaly the `X-OPA-Decision` header is passed back to the downstream service with the value set to `true` or `false` |


**server.url:** http://localhost:8181/v1/data/
__defaul:__ 

### OPA Payload Request

```json
{
    "request": {
        "http": {
            "headers": {
                "authorization": "Basic YWxpY2U6c2VjcmV0Cg==",
                "user-agent": "curl/7.68.0-DEV",
                "x-forwarded-proto": "http",
            },
            "host": "example",
            "method": "POST",
            "path": "/documents",
            "protocol": "HTTP/1.1"
        },
        "body": {}
    }
}

```

## Example

TODO: provide an example how to configure KONG + OPA using this plugin. Perhaps reference to another repo.

## Author

Eugene Brodsky

