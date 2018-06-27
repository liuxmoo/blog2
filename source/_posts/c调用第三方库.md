---
title: c 使用笔记
date: 2018-05-14 15:03:41
tags: c
toc: ture
author: zihua
categories: c
avatar: /images/me.jpeg
---

> go、java等其它高级语言调用第三方库是非常简单的，但是到了c就不一样了(其实还是简单只是我不会)。

![c](http://p1lpgmbe0.bkt.clouddn.com/c.png)

<!--more-->

#### c 使用 hiredis

> hiredis 使用

```bash
git clone https://github.com/redis/hiredis.git
make
make install
```

> 测试代码 main.c

```c
#include <stdio.h>
#include <hiredis/hiredis.h>
int main()
{
	redisContext *conn = redisConnect("127.0.0.1", 6379);
	if (conn != NULL && conn->err) {
		printf("connection error: %s\n", conn->errstr);
		return 0;
	}
	redisReply *reply;
	reply = redisCommand(conn, "SET %s %s", "foo", "bar");
	freeReplyObject(reply);
	reply = redisCommand(conn, "GET %s", "foo");
	printf("%s\n", reply->str);
	freeReplyObject(reply);
	redisFree(conn);
	return 0;
}
```

> 用 gcc 编译

```bash
gcc -o main main.c -L/usr/local/lib -lhiredis
```


#### c 静态连接库的制作

* 现有 hello.c hello.h 如何把 hello.c制作成成一个静态连接库呢？

> hello.h

```c
#ifndef HELLO_H
#define HELLO_H
 
void hello(const char *name);
 
#endif
```

> hello.c

```c
#include<stdio.h>


void hello(const char *name) {
	printf("%s\n", name);
}
```

* 制作静态连接库

```bash
gcc -o hello.o -c hello.c // 生成 .o 文件
ar -r libhello.a hello.o  // 生成 .a 文件
```

* 静态连接库使用
> c/c++使用第三方库要指定头文件所在位置，以及静态连接库，举个例子如下:

```bash
cp hello.h /usr/local/include
cp libhello.a /usr/local/bin
# 这里我 cp 到指定目录方便举例子
```
> main.c 如下
```c
#include "hello.h"

int main(){
	hello("aabbcc");
	return 0;
}
```

> 编译运行
```bash
gcc -o main -I/usr/local/include -L/usr/local/bin -lhello main.c
```








