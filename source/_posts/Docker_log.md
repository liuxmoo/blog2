---
title: Docker 容器主机磁盘耗尽的问题的解决方案
date: 2017-12-10 21:22:05
tags: docker
toc: true
author: zihua
categories: "docker"
avatar: http://p1teq0wgy.bkt.clouddn.com/1514707487WechatIMG13.jpeg
---

> docker 有毒，你看又把服务器磁盘快耗尽了。。。
![iterm](http://p1teq0wgy.bkt.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-04-06%20%E4%B8%8B%E5%8D%889.18.02.png)

<!--more-->




#### docker log 真确的使用姿势

> docker log 支持的驱动请看 [docker log driver](https://docs.docker.com/config/containers/logging/configure/#supported-logging-drivers)。
> docker 默认的日志驱动是 json-file,所以上面这条命令会收集容器的终端输出保留最新的日志，保留三份，每份50M。这点和 supervisor 滚动保存日志的方式是一致的。


```bash
docker run -d -p 27017:27017 --log-opt max-file=3 --log-opt max-size=50M mongo
```
> 自己有毒。。。
![docker](http://p1teq0wgy.bkt.clouddn.com/docker.jpg?imageMogr2/thumbnail/!50p)





