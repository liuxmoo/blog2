---
title: '关于http,https流量转socks5流量的一些笔记'
date: 2017-10-28 16:12:58
tags: network
---

### 前言
在linux（ubuntu）上使用过ssr的同学都知道，ssr使用的是socks5协议，并且在本地默认监听的是1080端口，我们需要在浏览器中使用 SwitchyOmega 插件才能正常FQ，那么问题来了，我们平时在命令行下使用wget，go get,mvn等走的都是http/https，所以我们是无法直接使用127.0.0.1:1080做代理的。怎么办？我们需要把http/https流量转发都1080端口即可
#### 解决方案
* 安装polipo
          sudo apt-get install polipo

* 修改配置文件

          sudo vim /etc/polipo/config   #修改为如下

          # This file only needs to list configuration variables that deviate
          # from the default values.  See /usr/share/doc/polipo/examples/config.sample
          # and "polipo -v" for variables you can tweak and further information.

          logSyslog = true
          logFile = /var/log/polipo/polipo.log
          proxyAddress = "127.0.0.1"
          proxyPort = 8118

          socksParentProxy = "127.0.0.1:1080"
          socksProxyType = socks5
* 重启 polipo

          sudo /etc/init.d/polipo restart

* 测试

          export http_proxy="http://127.0.0.1:8118/"
          curl ifconfig.me

          //稍等片刻可以看到终端显示代理服务器ip地址

* 完成上面步骤那么我们就可以通过 127.0.0.1:8118把http/https流量转发到127.0.0.1:1080端口的socks5上了

### 应用
上面的记录主要是我在使用go get命令下载三方依赖的时候老是被xxxxx,那么完成了上面步骤，我就可以通过走8118端口用go get 下载到我需要的依赖了，我怎么做？看下面步骤......

### 给go get 命令走socks5下载到我想要的东西
* 修改环境变量

        vim .bashrc
        //在后面追加下面配置
        alias  goo='http_proxy=127.0.0.1:8118 https_proxy=127.0.0.1:8118 go'

        //使.bashrc生效
        source .bashrc

* 使用

        goo get <xxxxxxxxxx>      //




###### 以上纯属个人笔记，难免有不当之处
