---
title: daocloud实习笔记
date: 2017-07-05 22:39:56
tags: 实习
description: DaoCloud 实习笔记
toc: true
author: zihua
avatar: /images/me.jpeg
---


### 第一天
* 熟悉daocloud 设计的产品　DCE


* 安装DCE


        * bash -c "$(docker run --rm daocloud.io/daocloud/dce install)"


* 卸载DCE


    * bash -c "$(docker run --rm daocloud.io/daocloud/dce uninstall --force)"


### 第二天

#### 部属DCE开发环境

* 克隆项目到本地（dce-controller,dce-deployer)

* 在环境变量添加如下配置


    DOCKER_SELF_HOST_URL=tcp://192.168.100.177:12376
    SWARM_URL=tcp://192.168.100.177:2375
    PYTHONUNBUFFERED=1
    ETCD_URL=etcd://192.168.100.177:12379
    SSL_CERT_FILE=/home/zihua/DaoCloud/dce-deployer/certs/https/dce.crt
    SSL_PKEY_FILE=/home/zihua/DaoCloud/dce-deployer/certs/https/dce.key
    CLIENT_CERTIFICATION_PATH=/home/zihua/DaoCloud/dce-deployer/certs/client/client-cert.pem
    CLIENT_PRIVATE_KEY_PATH=/home/zihua/DaoCloud/dce-deployer/certs/client/client-key.pem
    CLIENT_CERTIFICATION_CA_PATH=/home/zihua/DaoCloud/dce-deployer/certs/client/ca.pem
    SSL_CERT_FILE=/home/zihua/DaoCloud/dce-deployer/certs/https/dce.crt



### 第三天

#### 学会重装，升级，DCE,并学会转DCE为各种模式，命令如下
* docker run -i --rm daocloud.io/daocloud/dce:2.7.6-dev
