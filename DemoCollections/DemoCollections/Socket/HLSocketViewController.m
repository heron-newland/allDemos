//
//  HLSocketViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/2/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLSocketViewController.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>

@interface HLSocketViewController ()
@property(nonatomic,weak)UIButton *sendBtn;
@property(nonatomic,weak)UITextField *tf;

@end

@implementation HLSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_queue_t queue = dispatch_queue_create("life cycle queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        startSocket();
    });
    // Do any additional setup after loading the view.
    UIButton *sendBtn_ = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 80, 44)];
    [sendBtn_ setTitle:@"发送消息" forState:UIControlStateNormal];
    [sendBtn_ setBackgroundColor:[UIColor blueColor]];
    [sendBtn_ addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn_];
    self.sendBtn = sendBtn_;
}

- (void)sendMessage {
    request();
}


int request() {
    //创建套接字
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    
    //向服务器（特定的IP和端口）发起请求
    struct sockaddr_in serv_addr;
    memset(&serv_addr, 0, sizeof(serv_addr));  //每个字节都用0填充
    serv_addr.sin_family = AF_INET;  //使用IPv4地址
    serv_addr.sin_addr.s_addr = inet_addr("127.0.0.1");  //具体的IP地址
    serv_addr.sin_port = htons(1234);  //端口
    connect(sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
    const char *msg = "dns1=1||dns2=2";
    send(sock, msg, sizeof(msg), 0);
    //读取服务器传回的数据
    char buffer[40];
    read(sock, buffer, sizeof(buffer)-1);
    
    printf("Message form server: %s\n", buffer);
    
    //关闭套接字
    close(sock);
    return 0;
}

int startSocket(){
    //创建套接字
    int serv_sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    //将套接字和IP、端口绑定
    struct sockaddr_in serv_addr;
    memset(&serv_addr, 0, sizeof(serv_addr));  //每个字节都用0填充
    serv_addr.sin_family = AF_INET;  //使用IPv4地址
    serv_addr.sin_addr.s_addr = inet_addr("127.0.0.1");  //具体的IP地址
    serv_addr.sin_port = htons(1234);  //端口
    bind(serv_sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
    //进入监听状态，等待用户发起请求
    listen(serv_sock, 20);
    //接收客户端请求
    struct sockaddr_in clnt_addr;
    socklen_t clnt_addr_size = sizeof(clnt_addr);
    int clnt_sock = accept(serv_sock, (struct sockaddr*)&clnt_addr, &clnt_addr_size);
    char *abc[100];
    recv(serv_sock, abc, sizeof(abc), 0);
    
    printf(abc);
    //向客户端发送数据
    char str[] = "Hello World!";
    write(clnt_sock, str, sizeof(str));
    //关闭套接字
//    close(clnt_sock);
//    close(serv_sock);
    return 0;
}

@end
