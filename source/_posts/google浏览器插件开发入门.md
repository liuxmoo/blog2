---
title: chrome 插件开发
date: 2017-03-22 23:22:55
tags: chrome
toc: true
author: zihua
categories: "乱搞"
avatar: /images/me.jpeg
---
> 基于划词翻译插件实现的生词本。

![chrome](http://p1teq0wgy.bkt.clouddn.com/chrome.jpg)
<!-- more -->

英语学习小工具
==========

### 项目来源
* 平时自己在chrome使用划词翻译遇到了很多陌生的单词，但是每次都是翻译完就完了，没能及时地把自己遇到过生词记录下来。
* 如果能在每次使用翻译的时候把自己不会的单词默默地记录下来那么我们可以有针对性的复习自己不会的单词。

### 实现思路
* 在开源项目 **划词翻译** 的基础上做修改，把每次或多次翻译的单词或句子发送到配套服务器上。
* 服务器用负责收集单词
