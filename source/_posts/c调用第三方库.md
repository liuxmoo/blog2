---
title: c调用第三方库
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



