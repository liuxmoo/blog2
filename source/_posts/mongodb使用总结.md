---
title: mongodb使用总结
date: 2017-06-26 00:37:08
tags: mongodb
description: mongodb 使用的一些笔记
toc: true
---

### Mongodb修改为密码登录
* 无密码登录到mongodb


        mongo
* 使用 admin这个数据库


        use admin
* 新建用户

        db.createUser(
           {
             user: "userName",
             pwd: "password",
             roles: [ { role: "userAdmin", db: "admin" } ]
           }
        )

* 停止 mongodb


        sudo service mongod stop


* 启动验证登录


        sudo mongod --auth

* 重启　


    sudo service mongod start


* 密码登录到 mongodb


    mongo --port 27017 -u "userName" -p "password" --authenticationDatabase "admin"




# 说明
1. userName,password 为你想要添加的用户名以及密码，并且指定了数据库 admin ,拥有权限: userAdmin

1. 数据库用户角色：read、readWrite;  
2. 数据库管理角色：dbAdmin、dbOwner、userAdmin；       
3. 集群管理角色：clusterAdmin、clusterManager、clusterMonitor、hostManager；
4. 备份恢复角色：backup、restore；
5. 所有数据库角色：readAnyDatabase、readWriteAnyDatabase、userAdminAnyDatabase、dbAdminAnyDatabase
6. 超级用户角色：root  
// 这里还有几个角色间接或直接提供了系统超级用户的访问（dbOwner 、userAdmin、userAdminAnyDatabase）
7. 内部角色：__system
