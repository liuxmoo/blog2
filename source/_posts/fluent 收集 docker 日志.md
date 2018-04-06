---
title: fluentd 收集 docker 容器终端输出的日志
date: 2017-09-04 10:23:32
tags: fluent
toc: ture
author: zihua
categories: "docker"
avatar: /images/me.jpeg
---

> fluentd 是一款强大的日志收集工具，docker log driver 也支持 fluentd,那么为什么不搞点大新闻呢？

![fluentd](http://p1teq0wgy.bkt.clouddn.com/fluentd.gif)

<!--more-->



### 1.在服务器上安装部署 fluentd (Ubuntu16.04)

#### 1.1 安装 fluentd

> fluentd 安装过程请看 [fluentd 官网](https://docs.fluentd.org/v0.12/articles/install-by-deb)

#### 1.2 安装 mongodb plugin

```bash
sudo td-agent-gem install fluent-plugin-mongo
```

#### 1.3 修改 fluentd 配置文件

> 用 vim 打开 td-agent.conf

```bash
sudo vim  /etc/td-agent/td-agent.conf

```
> 修改 td-agent.conf 为下面的配置文件

```conf
<source>
	type forward
	port 24224
	bind 0.0.0.0
	tag docker.access
</source>

<match **>
	@type mongo
	database apache
	collection access
	host localhost
	port 27017
	<buffer>
		flush_interval 3s
	</buffer>
	<inject>
		time_key time
	</inject>
</match>
```

#### 1.4 重启 td-agent

```bash
sudo /etc/init.d/td-agent restart
```

#### 1.5 检测 td-agent 运行状态

```bash
sudo /etc/init.d/td-agent status

```
> 有下面输出表示 td-agent 运行成功
```bash
 * td-agent is running
```






