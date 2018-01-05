---
title: "Ingress Controller"
date: 2017-08-23T14:41:12+08:00
tags: k8s
description: Ingress Controller使用
toc: true
author: zihua
avatar: /images/me.jpeg
---


### Ingress Controller 配置文件

* curl get 请求


    curl -X GET http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses


* curl post 请求


    curl -X POST -H 'Content-Type: application/yaml' --data '
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: test
      namespace: kube-system
    spec:
      rules:
      - host: www.foryung.com
        http:
          paths:
          - backend:
              serviceName: kubernetes-dashboard
              servicePort: 19090
            path: /fooo
    ' http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses
