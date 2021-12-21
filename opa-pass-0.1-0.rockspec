rockspec_format = "3.0"

package = "opa-pass"

version = "0.1-0"

source = {
    url = "git@github.com:fupslot/kong-opa-pass.git",
}

description = {
    summary = "Integrate the Open Policy Engine with the Kong Gateway API",
    
    homepage = "https://github.com/fupslot/kong-opa-pass"
}

build = {
    type = "builtin",

    modules = {
        ["kong.plugins.opa-pass.access"] = "src/kong/plugins/opa-pass/access.lua",
    }
}