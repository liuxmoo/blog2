---
title: Dockerfile
date: 2017-12-10 21:22:05
tags: docker
description: Dockerfile使用总结
toc: true
author: zihua
avatar: /images/me.jpeg
---
> 好久没写博客了，去七牛实习了一个月，写了快一个月的Dockerfile,我个人是docker的脑残粉，现在的情况是，不管什么东西我都会想着docker化，所以想结合自己这一段时间的使用做一次总结吧。

### 非Linux命令行
 > 写Dockerfile命令时千万要记住，你在写dockerfile不是在写linux命令,所以一般我们在Dockerfile中建议把多条命令合在一起，这样防止最后生成的镜像过于庞大。

 ### 容器的本质
 > docker中的每一个容器的本质是Linux上的一个进程，所以不要把docker当做虚拟机使用

 ### 在容器中控制宿主机上的docker
 > 之前在Daocloud实习，我一直非常困惑DCE(Daocloud的一款产品)是如何做到在容器中控制宿主机上的docker,一段时间的研究发现通过挂载 unix:///var/run/docker.sock 到容器中，就可以实现容器中控制宿主机上的docker