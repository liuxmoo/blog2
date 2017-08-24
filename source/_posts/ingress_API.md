---
title: "Ingress_API"
date: 2017-08-23T15:55:33+08:00
tags: k8s
description: daocloud实习维护的模块
toc: true
---



### Ingresses API使用

#### Ingress 写操作
* 创建 ingress API

      POST /apis/extensions/v1beta1/namespaces/{namespace}/ingresses
* 创建 ingress API 调用示例


```json
    请求：

    curl -X POST -H 'Content-Type: application/yaml' --data '
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: test2
      namespace: kube-system
    spec:
      rules:
      - host: www.for.com
        http:
          paths:
          - backend:
              serviceName: kubernetes-dashboard
              servicePort: 19090
            path: /fooo12
    ' http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses

    返回：

    {
        "kind": "Ingress",
        "apiVersion": "extensions/v1beta1",
        "metadata": {
          "name": "test",
          "namespace": "kube-system",
          "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test",
          "uid": "ebc3e999-87d7-11e7-9381-0242ac130006",
          "resourceVersion": "135888",
          "generation": 1,
          "creationTimestamp": "2017-08-23T07:51:50Z"
        },
        "spec": {
          "rules": [
            {
              "host": "www.foryung.com",
              "http": {
                "paths": [
                  {
                    "path": "/fooo",
                    "backend": {
                      "serviceName": "kubernetes-dashboard",
                      "servicePort": 19090
                    }
                  }
                ]
              }
            }
          ]
        },
        "status": {
          "loadBalancer": {}
        }
    }
```

* 更新已有 ingress的局部信息 API


        PATCH /apis/extensions/v1beta1/namespaces/{namespace}/ingresses/{name}
* 更新已有 ingress的局部信息 API 调用示例(把host改为 www.for.com)

```json

      请求：

      curl --request PATCH -H 'Content-Type: application/strategic-merge-patch+json' --data '
      {
        "metadata": {
          "name":"test"
          },
          "spec": {
            "rules": [
              {
                "host": "www.for.com",
                "http": {
                  "paths": [
                    {
                      "path": "/fooo",
                      "backend": {
                        "serviceName": "kubernetes-dashboard",
                        "servicePort": 19090
                      }
                    }
                  ]
                }
              }
            ]
      }
    }
      ' http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test


      返回：

      {
        "kind": "Ingress",
        "apiVersion": "extensions/v1beta1",
        "metadata": {
          "name": "test",
          "namespace": "kube-system",
          "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test",
          "uid": "ebc3e999-87d7-11e7-9381-0242ac130006",
          "resourceVersion": "145533",
          "generation": 4,
          "creationTimestamp": "2017-08-23T07:51:50Z"
        },
        "spec": {
          "rules": [
            {
              "host": "www.for.com",
              "http": {
                "paths": [
                  {
                    "path": "/fooo",
                    "backend": {
                      "serviceName": "kubernetes-dashboard",
                      "servicePort": 19090
                    }
                  }
                ]
              }
            }
          ]
        },
        "status": {
          "loadBalancer": {
            "ingress": [
              {
                "ip": "192.168.2.80"
              }
            ]
          }
        }
}
```

* 替换 已有 ingress API


      PUT /apis/extensions/v1beta1/namespaces/{namespace}/ingresses/{name}
* 替换 已有 ingress API 调用示例

```json

    请求：
    curl -X PUT -H 'Content-Type: application/yaml' --data '
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: test
      namespace: kube-system
    spec:
      rules:
      - host: www.forasdfdfasdf.com
        http:
          paths:
          - backend:
              serviceName: kubernetes-dashboard
              servicePort: 19090
            path: /fooo
    ' http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test



    返回：

    {
        "kind": "Ingress",
        "apiVersion": "extensions/v1beta1",
        "metadata": {
          "name": "test",
          "namespace": "kube-system",
          "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test",
          "uid": "ebc3e999-87d7-11e7-9381-0242ac130006",
          "resourceVersion": "145714",
          "generation": 5,
          "creationTimestamp": "2017-08-23T07:51:50Z"
        },
        "spec": {
          "rules": [
            {
              "host": "www.forasdfdfasdf.com",
              "http": {
                "paths": [
                  {
                    "path": "/fooo",
                    "backend": {
                      "serviceName": "kubernetes-dashboard",
                      "servicePort": 19090
                    }
                  }
                ]
              }
            }
          ]
        },
        "status": {
          "loadBalancer": {
            "ingress": [
              {
                "ip": "192.168.2.80"
              }
            ]
          }
        }
    }
```

* 删除某个已经存在的 ingress API


      DELETE /apis/extensions/v1beta1/namespaces/{namespace}/ingresses/{name}

* 删除某个已经存在的 ingress API 调用示例

```json
      请求：

      curl -X DELETE  http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test

      返回：

      {
        "kind": "Status",
        "apiVersion": "v1",
        "metadata": {},
        "status": "Success",
        "code": 200
      }

```

* 批量删除 ingress API


        DELETE /apis/extensions/v1beta1/namespaces/{namespace}/ingresses
* 批量删除 ingress API 调用示例
```json

    请求：

    curl -X DELETE  http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses

    返回：

    {
      "kind": "IngressList",
      "apiVersion": "extensions/v1beta1",
      "metadata": {
        "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses",
        "resourceVersion": "147599"
      },
      "items": [
        {
          "metadata": {
            "name": "test",
            "namespace": "kube-system",
            "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test",
            "uid": "a7e900c0-87e9-11e7-9381-0242ac130006",
            "resourceVersion": "147347",
            "generation": 1,
            "creationTimestamp": "2017-08-23T09:58:47Z"
          },
          "spec": {
            "rules": [
              {
                "host": "www.for.com",
                "http": {
                  "paths": [
                    {
                      "path": "/fooo",
                      "backend": {
                        "serviceName": "kubernetes-dashboard",
                        "servicePort": 19090
                      }
                    }
                  ]
                }
              }
            ]
          },
          "status": {
            "loadBalancer": {
              "ingress": [
                {
                  "ip": "192.168.2.80"
                }
              ]
            }
          }
        },
        {
          "metadata": {
            "name": "test1",
            "namespace": "kube-system",
            "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test1",
            "uid": "b45329b4-87e9-11e7-9381-0242ac130006",
            "resourceVersion": "147395",
            "generation": 1,
            "creationTimestamp": "2017-08-23T09:59:08Z"
          },
          "spec": {
            "rules": [
              {
                "host": "www.for.com",
                "http": {
                  "paths": [
                    {
                      "path": "/fooo1",
                      "backend": {
                        "serviceName": "kubernetes-dashboard",
                        "servicePort": 19090
                      }
                    }
                  ]
                }
              }
            ]
          },
          "status": {
            "loadBalancer": {
              "ingress": [
                {
                  "ip": "192.168.2.80"
                }
              ]
            }
          }
        },
        {
          "metadata": {
            "name": "test2",
            "namespace": "kube-system",
            "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test2",
            "uid": "bedf2884-87e9-11e7-9381-0242ac130006",
            "resourceVersion": "147443",
            "generation": 1,
            "creationTimestamp": "2017-08-23T09:59:25Z"
          },
          "spec": {
            "rules": [
              {
                "host": "www.for.com",
                "http": {
                  "paths": [
                    {
                      "path": "/fooo12",
                      "backend": {
                        "serviceName": "kubernetes-dashboard",
                        "servicePort": 19090
                      }
                    }
                  ]
                }
              }
            ]
          },
          "status": {
            "loadBalancer": {
              "ingress": [
                {
                  "ip": "192.168.2.80"
                }
              ]
            }
          }
        }
      ]
    }
```



#### Ingress 读操作

* 获取某个Ingress 的详情数据 API


      GET /apis/extensions/v1beta1/namespaces/{namespace}/ingresses/{name}
* 获取某个Ingress 的详情数据 API 调用示例


 ``` json
      请求：
      curl -X GET http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test2

      返回：

      {
          "kind": "Ingress",
          "apiVersion": "extensions/v1beta1",
          "metadata": {
            "name": "test2",
            "namespace": "kube-system",
            "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test2",
            "uid": "21a8fb07-87eb-11e7-9381-0242ac130006",
            "resourceVersion": "148281",
            "generation": 1,
            "creationTimestamp": "2017-08-23T10:09:20Z"
          },
          "spec": {
            "rules": [
              {
                "host": "www.for.com",
                "http": {
                  "paths": [
                    {
                      "path": "/fooo12",
                      "backend": {
                        "serviceName": "kubernetes-dashboard",
                        "servicePort": 19090
                      }
                    }
                  ]
                }
              }
            ]
          },
          "status": {
            "loadBalancer": {
              "ingress": [
                {
                  "ip": "192.168.2.80"
                }
              ]
            }
          }
        }  
```

* 获取所有 Ingress 的详细数据 API


      GET /apis/extensions/v1beta1/namespaces/{namespace}/ingresses
* 获取所有 Ingress 的详细数据 API 调用示例

```json

    请求：

    curl -X GET http://127.0.0.1:18081/apis/extensions/v1beta1/namespaces/kube-system/ingresses

    返回：

        {
          "kind": "IngressList",
          "apiVersion": "extensions/v1beta1",
          "metadata": {
            "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses",
            "resourceVersion": "148289"
          },
          "items": [
            {
              "metadata": {
                "name": "test2",
                "namespace": "kube-system",
                "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test2",
                "uid": "21a8fb07-87eb-11e7-9381-0242ac130006",
                "resourceVersion": "148281",
                "generation": 1,
                "creationTimestamp": "2017-08-23T10:09:20Z"
              },
              "spec": {
                "rules": [
                  {
                    "host": "www.for.com",
                    "http": {
                      "paths": [
                        {
                          "path": "/fooo12",
                          "backend": {
                            "serviceName": "kubernetes-dashboard",
                            "servicePort": 19090
                          }
                        }
                      ]
                    }
                  }
                ]
              },
              "status": {
                "loadBalancer": {
                  "ingress": [
                    {
                      "ip": "192.168.2.80"
                    }
                  ]
                }
              }
            }
          ]
        }

```
* 获取所namespace 下的所有 Ingress API

      GET /apis/extensions/v1beta1/ingresses

* 获取所namespace 下的所有 Ingress API 调用示例


```json
    请求：
    curl -X GET http://127.0.0.1:18081/apis/extensions/v1beta1/ingresses


    返回：

    {
      "kind": "IngressList",
      "apiVersion": "extensions/v1beta1",
      "metadata": {
        "selfLink": "/apis/extensions/v1beta1/ingresses",
        "resourceVersion": "261710"
      },
      "items": [
        {
          "metadata": {
            "name": "test2",
            "namespace": "kube-system",
            "selfLink": "/apis/extensions/v1beta1/namespaces/kube-system/ingresses/test2",
            "uid": "21a8fb07-87eb-11e7-9381-0242ac130006",
            "resourceVersion": "148281",
            "generation": 1,
            "creationTimestamp": "2017-08-23T10:09:20Z"
          },
          "spec": {
            "rules": [
              {
                "host": "www.for.com",
                "http": {
                  "paths": [
                    {
                      "path": "/fooo12",
                      "backend": {
                        "serviceName": "kubernetes-dashboard",
                        "servicePort": 19090
                      }
                    }
                  ]
                }
              }
            ]
          },
          "status": {
            "loadBalancer": {
              "ingress": [
                {
                  "ip": "192.168.2.80"
                }
              ]
            }
          }
        }
      ]
    }


```
