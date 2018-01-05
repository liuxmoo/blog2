---
title: fluent使用入门
date: 2017-09-04 10:23:32
tags: fluent
description: fluent 使用笔记
toc: ture
author: zihua
avatar: /images/me.jpeg
---

### docker 运行
* docker run -d   -p 9880:9880 -v /home/zihua/test:/fluentd/etc -e FLUENTD_CONF=fluentd.conf   fluent/fluentd

* curl -X POST -d 'json={"json":"message"}' http://localhost:9880/sample.test
点击更多可以编辑7层负载均衡
上两页中的

编辑不能修改7层负载均衡名称
用到"更新Ingress" API
添加

域名只能填一个
路径也只能填一个
选择器默认加载当前应用的第一个服务
端口默认是80
应用界面
高级设置
选择器和端口默认
绿色字段为由选择器和端口默认创建的Server
高级设置字段
默认名字
名称默认为:应用名_ingress

默认创建的Server 名字规则为 ingress名字-ingress-default-server
值和Server名字相同

默认名字规则为：应用名-ingress-default-server
应用名-镜像名



requirements = ['wget', 'git', 'net-tools', 'bind-utils', 'iptables-services', 'bridge-utils', 'bash-completion',
                    'kexec-tools', 'sos', 'psacct', 'chrony', 'device-mapper-persistent-data', 'lvm2', 'audit',
                    'systemd-journal', 'socat', 'ipvsadm']
RUN yum install -y --setopt=obsoletes=0 wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct ntp chrony device-mapper-persistent-data lvm2 audit systemd-journal socat yum-utils  telnet tcpdump keepalived ipvsadm --downloadonly --downloaddir=/app/repo/packages


requirements = ['apt-transport-https', 'ca-certificates', 'lsb-release', 'software-properties-common', 'ntp','ipvsadm']
RUN apt-get update  && \
    apt-get install -y curl apt-transport-https ca-certificates lsb-release software-properties-common ntp keepalived ipvsadm
