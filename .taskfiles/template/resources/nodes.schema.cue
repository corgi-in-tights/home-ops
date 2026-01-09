package config

import (
	"net"
	"list"
)

#Config: {
	nodes: [...#Node]
	_nodes_check: {
		name: list.UniqueItems() & [for item in nodes {item.name}]
		address: list.UniqueItems() & [for item in nodes {item.address}]
		mac_addr: list.UniqueItems() & [for item in nodes {item.mac_addr}]
	}
}

#Node: {
	name:          =~"^[a-z0-9][a-z0-9\\-]{0,61}[a-z0-9]$|^[a-z0-9]$" & !="global" & !="controller" & !="worker"
	address:       net.IPv4
	controller:    bool
	mac_addr:      =~"^([0-9a-f]{2}[:]){5}([0-9a-f]{2})$"
}

#Config
