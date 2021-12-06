if [ -n "$(docker network ls -f name=my-bridge-demo -q)" ]; then
    docker network rm $(docker network ls -f name=my-bridge-demo -q)
fi

# $ docker network create --help
# Usage:  docker network create [OPTIONS] NETWORK
# Create a network
# Options:
#       --attachable           Enable manual container attachment
#       --aux-address map      Auxiliary IPv4 or IPv6 addresses used by Network driver (default map[])
#       --config-from string   The network from which to copy the configuration
#       --config-only          Create a configuration only network
#   -d, --driver string        Driver to manage the Network (default "bridge")
#       --gateway strings      IPv4 or IPv6 Gateway for the master subnet
#       --ingress              Create swarm routing-mesh network
#       --internal             Restrict external access to the network
#       --ip-range strings     Allocate container ip from a sub-range
#       --ipam-driver string   IP Address Management Driver (default "default")
#       --ipam-opt map         Set IPAM driver specific options (default map[])
#       --ipv6                 Enable IPv6 networking
#       --label list           Set metadata on a network
#   -o, --opt map              Set driver specific options (default map[])
#       --scope string         Control the network's scope
#       --subnet strings       Subnet in CIDR format that represents a network segment

# 在创建network时候当然也有很多可选项
docker network create -d bridge --gateway 172.200.0.1 --subnet 172.200.0.0/16 my-bridge-demo 
echo "------------------------------------------------------------"
docker network ls
echo "------------------------------------------------------------"
docker network inspect my-bridge-demo 
# 可以在看到demo的子网和网关的设定变为我们指定的内容
# [
#     {
#         "Name": "my-bridge-demo",
#         ........
#         "IPAM": {
#             ........
#             "Config": [
#                 {
#                     "Subnet": "172.200.0.0/16",
#                     "Gateway": "172.200.0.1"
#                 }
#             ]
#         },
#         ........
#     }
# ]
