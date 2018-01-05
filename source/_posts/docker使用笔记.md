---
title: docker使用笔记
date: 2017-06-29 21:06:05
tags: docker
description: 关于docker 使用的一些记录
toc: true
author: zihua
avatar: /images/me.jpeg
---


### 安装docker
1. curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/intranet | sh -
2. 非root用户使用docker sudo usermod -aG docker userName
3. 重启电脑


### 在docker中部署mongodb
* docker run --name mongo3 -p 27018:27017 -d -v /home/yahaa/dockerdata:/data/db mongo --auth


    解释：
        --name mongo3 指定容器名字为　mongo3
        -p 27018:27017 指定本机端口27018和容器端口27018绑定
        -d 在后台中运行
        -v 把本地的　/home/yahaa/dockerdata挂载到　/data/db
        mongo 表示自动拉取的镜像
        --auth 表示开启授权


* docker exec -it mongo3 mongo admin


    解释：
        终端进入容器　mongo3 并且执行容器中的命令　mongo admin

* 然后创建一个user administrator:


    db.createUser({
        user:"zihua",
        pwd:"Asd123321",
        roles:[{role:"userAdminAnyDatabase",db:"admin"}
        ]}
    );


    db.createUser(
      {
        user: "yahaa",
        pwd: "Asd123321",
        roles: [ { role: "readWrite", db: "chatapi" },
                 { role: "readWrite", db: "chatapi-log" } ]
      }
    )

* 详情参考下面博文
#### docker 中mongodb 授权
* [参考博客](https://blog.igevin.info/posts/docker-mongo-auth/)


### 本地连接到阿里云mongodb


    //连接MongoDB并指定端口

    mongo 192.168.1.100:27017

    //连接到指定的MongoDB数据库

    mongo 192.168.1.100:27017/test

    //指定用户名和密码连接到指定的MongoDB数据库

    mongo 192.168.1.200:27017/test -u user -p password
