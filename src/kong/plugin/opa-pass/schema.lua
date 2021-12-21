return {
    name = "opa-pass",
    fields = {
        {
            config = {
                type = "record",
                fields = {
                    {
                        server = {
                            type = "record",
                            fields = {
                                {
                                    url = {
                                        type = "string",
                                        required = true,
                                    },
                                },
                                {
                                    keepalive_timeout = {
                                        type = "number",
                                        default = 60,
                                    },
                                },
                                {
                                    keepalive_pool = {
                                        type = "number",
                                        default = 100,
                                    },
                                },
                            },
                        }
                    },
                    {
                        request = {
                            type = "record",
                            fields = {
                                {
                                    headers_to_forward = {
                                        type = "array",
                                        elements = {
                                            type = "string",
                                        },
                                        default = {
                                            "host",
                                            "authorization",
                                            "x-forwarded-for",
                                            "x-forwarded-proto",
                                            "x-real-ip",
                                            "x-forwarded-host",
                                            "x-forwarded-server",
                                            "x-forwarded-port",
                                            "x-forwarded-prefix",
                                            "x-forwarded-scheme",
                                            "x-forwarded-uri",
                                        },
                                    },
                                },
                                {
                                    body = {
                                        type = "boolean",
                                        default = false,
                                    },
                                },
                            },
                        },
                    },
                    {
                        policy = {
                            type = "record",
                            fields = {
                                {
                                    base_path = {
                                        type = "string",
                                        default = "v1/data",
                                        required = true,
                                    },
                                },
                                {
                                    resource = {
                                        type = "string",
                                        required = true,
                                    },
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}