dependency "vrp"

client_scripts {
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua",
  "config.lua"
}

server_scripts{
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "@vrp/lib/utils.lua",
  "server.lua",
  "config.lua"
}