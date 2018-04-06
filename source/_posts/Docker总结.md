---
title: Docker使用总结
date: 2017-12-10 21:22:05
tags: docker
description: Docker使用总结
toc: true
author: zihua
avatar: /images/me.jpeg
---

> 

 > 写Dockerfile命令时千万要记住，你在写dockerfile不是在写linux命令,所以一般我们在Dockerfile中建议把多条命令合在一起，这样防止最后生成的镜像过于庞大。

 > docker中的每一个容器的本质是Linux上的一个进程，所以不要把docker当做虚拟机使用

 > 之前在Daocloud实习，我一直非常困惑DCE(Daocloud的一款产品)是如何做到在容器中控制宿主机上的docker,一段时间的研究发现通过挂载 unix:///var/run/docker.sock 到容器中，就可以实现容器中控制宿主机上的docker