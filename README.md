## kong-opa-pass

[Kong](https://konghq.com/) plugin that forwards request to Open Policy Agent and process the request only if the authorization policy allows for it.

## Description

TODO: describe what this plugin for

## Configuration

TODO: add detailed information about how to install and configure this plugin

### OPA Payload Request

    TODO: add an example of the input request object 

```json
{
    "attributes": {
        "request": {
            "http": {
                "headers": {
                    "accept": "*/*",
                    "authorization": "Basic YWxpY2U6c2VjcmV0Cg==",
                    "content-length": "0",
                    "user-agent": "curl/7.68.0-DEV",
                    "x-forwarded-proto": "http",
                    "x-request-id": "1455bbb0-0623-4810-a2c6-df73ffd8863a"
                },
                "host": "example",
                "method": "POST",
                "path": "/documents",
                "protocol": "HTTP/1.1"
            }
        }
    }
}

```

## Example

TODO: provide an example how to configure KONG + OPA using this plugin. Perhaps reference to another repo.

## Author

Eugene Brodsky

