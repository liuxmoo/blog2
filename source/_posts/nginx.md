---
title: "nginx 使用笔记"
date: 2017-08-17T23:12:44+08:00
tags: nginx
description: nginx使用的一些笔记
toc: true
---

### nginx 使用笔记
#### 安装 (ubuntu)
* sudo apt-get update
* sudo apt-get install nginx

#### 卸载
* sudo apt-get remove nginx nginx-common # 卸载删除除了配置文件以外的所有文件。
* sudo apt-get purge nginx nginx-common # 卸载所有东东，包括删除配置文件。
* sudo apt-get autoremove # 在上面命令结束后执行，主要是卸载删除Nginx的不再被使用的依赖包。
* sudo apt-get remove nginx-full nginx-common #卸载删除两个主要的包。
* [参考博文](http://blog.csdn.net/yypsober/article/details/51792363)



#### 启动
* sudo /etc/init.d/nginx start

#### 停止
* ps -ef | grep nginx
* kill -QUIT pid
* kill -TERM pid
* pkill -9 nginx

#### 重启 （必须实在启动情况下）
* nginx -s reload

#### 检查修改后的配置文件
* nginx -t -c /xxx/nginx/config/nginx.conf
