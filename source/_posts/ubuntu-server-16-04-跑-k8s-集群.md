---
title: ubuntu server 16.04 跑 k8s 集群
date: 2018-06-16 22:44:57
tags: k8s
description: 
toc: true
author: zihua
categories: "k8s"
avatar: /images/me.jpeg
---

> 网上一大片 k8s 集群的部署教程，，，我也来写一篇吧，至少我自己能看懂自己写的。

![docker](http://p1teq0wgy.bkt.clouddn.com/docker.jpg

<!--more-->

### 1. 服务器准备
* 本次部署采用的服务器是 ubuntu server 16.04，[下载地址](http://releases.ubuntu.com/16.04/ubuntu-16.04.4-server-amd64.iso)

* 在 virtualbox 安装三份虚拟机，修改虚拟机 ip 为静态 ip 地址，hostname 分别如下表:

| ip        | hostname    |  user  |
| --------   | -----:   | :----: |
| 192.168.0.110        | master      |   zihua    |
| 192.168.0.111        | node1       |   zihua    |
| 192.168.0.112        | node2       |   zihua    |

#### 1.1 ubuntu 虚拟机节点环境准备(master 为例)

##### 1.1.1 修改 hostname

```bash
vim /etc/hostname 
```
##### 1.1.2 修改 ip 为静态 ip 地址
```bash
sudo vi /etc/network/interfaces
```
##### 1.1.3 把 /etc/network/interfaces 改为如下:

```bash
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto enp0s3
iface enp0s3 inet static
address 192.168.0.110
netmask 255.255.255.0
network 192.168.0.0
broadcast 192.168.0.255
gateway 192.168.0.1
dns-nameservers 192.168.0.1
dns-search pcat
```

##### 1.1.4 修改软件源为国内软件源 vim /etc/apt/sources.list,内容如下:
```bash
# deb cdrom:[Ubuntu 16.04 LTS _Xenial Xerus_ - Release amd64 (20160420.1)]/ xenial main restricted
deb-src http://archive.ubuntu.com/ubuntu xenial main restricted #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse #Added by software-properties
deb http://archive.canonical.com/ubuntu xenial partner
deb-src http://archive.canonical.com/ubuntu xenial partner
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse
deb http://cz.archive.ubuntu.com/ubuntu trusty main
```

#### 1.2 安装 docker （k8s 1.10.0，最高支持 docker 17.03)
##### 1.2.1 deb 方式安装docker [地址](https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce_17.03.0~ce-0~ubuntu-xenial_amd64.deb)

#### 1.3 安装 k8s

##### 1.3.1 安装 apt-https
```bash
sudo apt-get update && apt-get install -y apt-transport-https
```

##### 1.3.2 添加 k8s 软件包
```bash
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add 

# 注如果不行请自己下载 apt-key,然后再 cat apt-key | apt-key add
```

##### 1.3.3 添加 k8s deb 包
```bash
deb http://apt.kubernetes.io/ kubernetes-xenial main 
sudp apt update # 注 如果被墙 请修改 apt 走代理
sudo apt-get install -y kubelet=1.10.4-00 kubeadm=1.10.4-00 kubectl=1.10.4-00 kubernetes-cni=0.6.0-00


# apt 走代理

sudo vim /etc/apt/apt.conf

填写如下内容:
Acquire::http::proxy "http://192.168.0.100:1087/";
Acquire::https::proxy "http://192.168.0.100:1087/";
```

##### 1.3.4 准备 k8s 所需要的镜像

> 注:这个镜像在国内是无法正常下载的，需要进过中转站提前下载


##### 1.3.5 swap 关闭
```bash
sudo swapoff -a
```

##### 1.3.6 安装一定要指定版本
```bash
sudo kubeadm init --kubernetes-version=v1.10.0 --pod-network-cidr=10.244.0.0/16

# 注 不指定 --kubernetes-version=v1.10.0 的话会导致镜像无法下载
```





