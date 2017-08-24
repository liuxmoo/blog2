---
title: Ubuntu16.04 软件源
date: 2017-08-24 16:06:37
tags: Linux
description: ubuntu16.04软件源配置
toc: true
---

之前一直用ubuntu14.04,那时安装软件基本没什么问题，但是到了ubuntu16.04各种问题都出现了，比如通过deb包安装搜狗输入法，docker等时依赖无法下载，经过一番折腾，发现是软件源不正常导致，所以想把这一折腾结构记录一下以免下次自己又得去折腾。

### 配置
* sudo cp /etc/apt/source.list /etc/apt/backup_source.list 备份
* vim /ete/apt/source.list 把原来的全删了，改为下面软件源

```shell
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

* sudo apt update 更新一下即可
