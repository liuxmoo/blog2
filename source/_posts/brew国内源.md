---
title: brew国内源
date: 2018-04-29 11:01:45
tags: network
toc: ture
author: zihua
categories: "network"
avatar: /images/me.jpeg
---

> 网上随手抄的 brew 国内源修改，

![brew](http://p1lpgmbe0.bkt.clouddn.com/homebrew.png)

<!--more-->

* 修改 brew 源为清华大学源

```bash
cd "$(brew --repo)"

git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"

git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

```

* 修改 bash_profile

```bash
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.bash_profile

source ~/.bash_profile
```

* 验证

```bash
brew update
```

> brew update 如果长时间没反应，课重启电脑看看



