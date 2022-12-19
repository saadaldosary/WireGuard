
# check if ipetable module is loaded, if not install iptables kernal module, load them to kernal and make them presistant.

var1=$(lsmod | grep -i ip_tables)

k_modules=("ip_tables" "wireguard" "ip6_udp_tunnel" "udp_tunnel")

for i in ${k_modules[@]};
do
        var1=$(lsmod | grep -i $i)
        if [ -n "$var1" ]; then
                modprobe $i
                echo "Kernel module: $i is loaded to the kernel"
        else
                echo "Kernel Module: $i can not be found"
        fi
done;

#podman run -d --name=wg_server --cap-add=NET_ADMIN,NET_RAW --cap-add=SYS_MODULE --sysctl=net.ipv4.conf.all.forwarding=1 --privileged -p 51820:51820/udp -v /home/saad/wgp:/config:Z -e PUID=1000 -e PGID=1000 -e TZ=Asia/Riyadh -e SERVERURL=192.168.126.128  -e SERVERPORT=51820 -e PEERS=3 -e PEERDNS=auto -e INTERNAL_SUBNET=10.10.10.100/24 -e ALLOWEDIPS=0.0.0.0/0 -e LOG_CONFS=true docker.io/linuxserver/wireguard 
