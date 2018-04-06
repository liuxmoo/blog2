---
title: ubuntu 上的 ufw 
date: 2017-08-26 21:13:08
tags: linux
author: zihua
categories: "linux"
avatar: /images/me.jpeg
---

> 最近在使用学校的云服务器，真心烦，各种端口限制，不过还好，在被限制的情况下逼迫自己学会使用nginx做反向代理，同时会用ufw。
面是记录自己使用ufw的一些记录，防止自己忘掉。


![uwf](http://p1teq0wgy.bkt.clouddn.com/ufw.png)

<!--more-->
### 1.安装ufw
* sudo apt-get install ufw

### 2.使用
* sudo ufw status   //查看开放的状态
* sudo ufw allow 8000      //开放8000
* sudo ufw deny 8000      //关闭 8000
* ufw -h       //具体查看使用帮助


