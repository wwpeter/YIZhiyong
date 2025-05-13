//
//  ConnectDeviceManager.m
//  SXProject
//
//  Created by 王威 on 2024/1/12.
//

#import "ConnectDeviceManager.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>

#define SERVER_IP "192.168.1.100"
#define SERVER_PORT 8080

@implementation ConnectDeviceManager


int mainF(void) {
    int sockfd;
    struct sockaddr_in server_addr;
    char server_ip[] = SERVER_IP;
    int server_port = SERVER_PORT;
    
    // 创建套接字
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd == -1) {
        perror("Socket creation failed");
        return -1;
    }
    
    // 设置服务器地址信息
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = inet_addr(server_ip);
    server_addr.sin_port = htons(server_port);
    
    // 连接到服务器
    if (connect(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Connection failed");
        return -1;
    }
    
    // 发送数据
    char message[] = "Hello, server!";
    if (send(sockfd, message, strlen(message), 0) < 0) {
        perror("Send failed");
        return -1;
    }
    
    // 接收数据
    char buffer[1024];
    memset(buffer, 0, sizeof(buffer));
    if (recv(sockfd, buffer, sizeof(buffer), 0) < 0) {
        perror("Receive failed");
        return -1;
    }
    
    printf("Received message from server: %s\n", buffer);
    
    // 关闭套接字
    close(sockfd);
    
    return 0;
}
@end
/*
 P2P打洞（P2P Hole Punching）是一种用于解决NAT（网络地址转换）限制下的P2P通信问题的技术。由于NAT会将局域网设备的私有IP地址转换为公共IP地址，导致设备之间无法直接建立连接。P2P打洞技术通过一系列的协商和通信步骤，使设备能够绕过NAT，直接建立点对点连接。

 下面是P2P打洞的基本原理：

 发现对等方：每个设备首先需要发现其他设备的存在。这可以通过某种发现机制（例如中央服务器、局域网广播、外部引导节点等）来实现。设备之间通过交换网络信息（如IP地址、端口号等）来相互发现。

 交换网络信息：设备之间通过一种可达的网络路径进行通信，例如通过中央服务器或外部引导节点。设备将自己的网络信息（包括私有IP地址、端口号等）发送给对方，并接收对方的网络信息。

 NAT探测：设备尝试确定自己的NAT类型和限制。通常，NAT有不同的类型，如完全锥形NAT、限制锥形NAT、端口受限锥形NAT等。设备需要确定自己的NAT类型以及是否存在限制，以便选择适当的策略进行打洞。

 打洞尝试：设备通过向对方发送数据包来尝试打洞。这些数据包通常包含特定的标识符和消息，以便对方能够识别和回复。设备在不同的端口上发送数据包，以期望能够通过NAT的映射表建立双向通信。

 确认连接：如果打洞成功，设备将能够直接建立点对点连接。它们可以通过已建立的连接进行数据传输，实现P2P通信。

 值得注意的是，P2P打洞并不是一种绝对可靠的方法，成功与否取决于NAT类型、网络环境和设备之间的通信策略等因素。在某些情况下，P2P打洞可能无法成功，这时可能需要采用其他技术手段，如中继或转发服务器，以确保设备之间的通信。

 P2P打洞技术在实际应用中得到了广泛的应用，例如P2P文件分享、实时通信应用等。它使得设备能够直接建立点对点连接，提供了更高效和低延迟的通信方式。
 */
/*
 P2P（点对点）局域网通信是指在局域网内直接建立点对点的通信连接，而无需通过中央服务器进行中转。它可以实现设备之间的直接数据传输，具有低延迟和高效率的特点。下面是P2P局域网通信的基本原理：

 局域网发现：P2P通信的第一步是设备之间的发现。设备需要在局域网中广播自己的存在，以便其他设备能够发现并建立连接。通常使用的方法是通过多播（multicast）或广播（broadcast）方式发送发现消息。

 建立连接：一旦设备发现了其他设备，它们可以尝试建立直接的点对点连接。设备之间可以通过TCP或UDP等传输协议进行连接。一种常见的方法是使用Socket编程，其中一台设备作为服务器端监听连接请求，另一台设备作为客户端发起连接。

 穿透NAT：在局域网中，设备通常位于同一个子网内，但可能会受到网络地址转换（NAT）的限制。NAT会将局域网内设备的私有IP地址转换为公共IP地址，从而导致设备之间无法直接通信。为了解决这个问题，P2P通信中常使用技术如NAT穿透、端口映射和中继等方式来允许设备直接建立连接，绕过NAT的限制。

 数据传输：一旦设备之间建立了连接，它们可以直接进行数据传输。数据可以通过已建立的连接进行双向通信，设备可以互相发送和接收数据。通常使用的协议包括TCP和UDP，具体协议的选择取决于应用的需求。

 值得注意的是，P2P局域网通信的可行性和效果受到局域网环境和设备之间的网络配置的影响。例如，防火墙、路由器设置、网络负载等因素都可能对P2P通信造成影响。在实际应用中，可能需要采用一些技术手段来处理这些问题，以确保设备之间能够稳定地进行P2P通信。

 此外，P2P局域网通信还可以结合其他技术和协议，如UPnP（通用即插即用）、Bonjour、WebSocket等，以提供更多的功能和便利性。
 */
