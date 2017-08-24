---
title: 单机文件系统之Linux文件系统
date: 2017-04-15 22:27:36
tags: 系统结构
description: 系统结构研讨资料
toc: true
---
## <center>单机文件系统之Linux文件系统</center>
##### <center>袁子华 14122260</center>
### 目录
* 引入
* 硬盘的组成回顾
* 分区的概念
* Linux 文件系统 (VFS 虚拟文件系统)
* 基于Linux 虚拟文件系统的一些验证性实验
* 参考文献

### 引入
* 在安装多系统的情况下，为什么Linux　系统能够直接访问其他系统的文件？
* ｕ盘在Linux 下被当作什么看待？
* 如何有效的把云服务器的硬盘用起来？

#### 演示
##### 系统挂载设备操作
* 查看系统已挂载设备　sudo df -h
* 查看系统支持的文件系统　ls -l /lib/modules/$(uname -r)/kernel/fs
* 系统已经加载到内存的文件系统　cat /proc/filesystems
* 挂载设备　sudo mount /dev/xxx xxx目录
* 强制卸载设备　sudo umount /dev/xxx

##### nfs文件系统配置脚本使用说明(服务器端 需要 root 权限) [代码地址](https://github.com/yahaa/path_script)

* git clone git@github.com:yahaa/path_script.git
* cd path_script
* sudo su
* python nfs_service.py
* 停止服务 python nfs_umount.py

##### nfs 客户端配置(需要 root 权限)
* git clone git@github.com:yahaa/path_script.git
* cd path_script
* sudo su
* python nfs_client.py
* 卸载 nfs python nfs_umount.py

### 硬盘的组成
* 磁盘由一个一个盘片组成如下图，图中灰色同心圆为磁道。
* 绿色部分为扇区，扇区是最小的存储单位，每个扇区为 512 bytes 。



<center>![盘片结构](http://pic002.cnblogs.com/images/2012/295881/2012052117213095.gif)</center>

<center>图 1

---
* 将扇区组成一个圆，即构成柱面，柱面是分区的最小单位


###### 名称
* 磁头（head）
* 磁道（track）
* 柱面（cylinder）
* 扇区（sector）
* 圆盘（platter）
###### 容量
*  存储容量 ＝ 磁头数 × 磁道(柱面)数 × 每道扇区数 × 每扇区字节数
* 例如　图2中磁盘是一个 3个圆盘6个磁头，7个柱面（每个盘片7个磁道） 的磁盘，图2中每条磁道有12个扇区，所以此磁盘的容量为　6*7*12*512　字节。


<center>![磁盘的整体结构](http://pic002.cnblogs.com/images/2012/295881/2012052117224297.gif)


<center> 图 ２

### 分区
* 为什么要分区？

1. 一整块磁盘很大，就像一个没与分层的衣柜，所有衣服都仍在里面很乱 ．
2. 把每个分区分开能一定程度确保数据安全
3. 分区有助于系统性能提升


<center>![磁盘分区表作用示意图](http://pic002.cnblogs.com/images/2012/427480/2012120616273565.jpg)

<center>图 ３

* 传统的分区方案，是将分区信息保存到磁盘的第一个扇区(MBR扇区)中的64个字节中，每个分区项占用16个字节，这16个字节中存有活动状态标志、文件系统标识、起止柱面号、磁头号、扇区号、隐含扇区数目(4个字节)、分区总扇区数目(4个字节)等内容。由于MBR扇区只有64个字节用于分区表，所以只能记录4个分区的信息。这就是硬盘主分区数目不能超过4个的原因。后来为了支持更多的分区，引入了扩展分区及逻辑分区的概念。但每个分区项仍用16个字节存储。
* 假设硬盘的设备名为 /dev/hda　那么在Linux 系统中设备文件如下：
1. /dev/hda1
2. /dev/hda2
3. /dev/hda3
4. /dev/hda4


### Linux 文件系统

* “一切皆是文件”　是 Unix/Linux 的基本哲学之一．不仅普通的文件，目录、字符设备、块设备、 套接字等在 Unix/Linux 中都是以文件被对待；它们虽然类型不同，但是对其提供的却是同一套操作界面。
* Linux 中允许众多不同的文件系统共存，如 ext2, ext3, vfat 等。通过使用同一套文件 I/O 系统 调用即可对 Linux 中的任意文件进行操作而无需考虑其所在的具体文件系统格式；更进一步，对文件的 操作可以跨文件系统而执行。
* 为了实现以上两点，Linux 引入虚拟文件系统（VFS),缩略图如图４

<center>![VFS缩略图](http://www.ibm.com/developerworks/cn/linux/l-cn-vfs/3.jpg)

<center>图 4

#### VFS 思想
* VFS 定义了所有文件系统都支持的基本的、概念上的接口和数据 结构；同时实际文件系统也提供 VFS 所期望的抽象接口和数据结构，与VFS的定义保持一致。(也就是说，一个文件系统要想被 Linux系统支持，那么该文件系统必须实现VFS所提供的接口)


#### VFS 数据结构  ([参考博客](http://blog.csdn.net/kickxxx/article/details/9471069))
1. 超级块(struct super_block {...} )

    超级块是记录整个文件系统相关信息的地方,没有超级块，也就没有文件系统的说法．
2. inode结构( struct inode {...} )

    该结构中存储的是一个特定文件的一般信息，对于一个基于磁盘的文件系统，该结构对应磁盘上的"文件数据控制块"。每一个inode结构都对应一个inode节点号，这个节点号是唯一的，它也唯一标识一个文件系统中的文件。
3. dentry结构( struct dentry {...} )

    该结构存储的是目录实体和对应的文件的关联信息。
4. file结构( struct file {...} )

      该结构中存储的是一个打开的文件和打开这个文件的进程间的交互信息。该结构保存在kernel的内存区，在打开文件时被创建，关闭文件时被释放。

#### Linux 的Ｅxt2 文件系统(索引式文件系统)
* Ext2与分区示意图如图５

<center>![详情](http://img.blog.csdn.net/20160725203432673)
<center>图 5


* 详情对照

<center>![详情](/img/201704161.jpg)

<center>图 6

* inode 结构图如图７

<center>![inode](http://img.blog.csdn.net/20160725172858726)

<center>图 7

##### Ext2 的相关说明
* 因为一个分区可能很大，可能会分成很多很多个block，为了便于管理，系统将这些block分成多个block组，每个block组中存储当前组的信息和当前block组的block　．

* inode中存储文件的一些属性信息，block中存储文件真正的内容，一个block的大小有1k、4k等大小，一个block中只能存储一个文件，比如现在有一个文件占据了一个block的1B大小，那么这个block剩余的大小也无法分配给其他文件使用。
##### Ext2 相关名称
* super block

    超级块，它记录的是整个文件系统的信息，文件系统的类型，inode数量，block数量等，每个分区的super block是相同的
* 文件系统描述

    描述每个block group 的开始与结束的block号码。
* 块对应表(block bitmap)

    用bit位记录了每一个block目前的状态，如果有数据就置为1，没有数据置为0。如果需要分配block，那么就找目前状态为0的。
* inode 对应表(inode bitmap)

    和块对应表相似，记录的是inode的分配和未分配的号码。
* inode table

    详细记录了每一个inode的信息。
* data block

    详细记录文件数据的地方，每一个block都有block号码。

#### FAT 文件系统　(详情参考操作系统教材)
* 大家都知道
* u 盘使用的文件系统一般是FAT格式
* 链式索引

#### NFS 文件系统
* NFS 是Ｎetwork File System 的缩写，其功能是通过网络，让不同的机器，不同的操作系统可以共享彼此的文件．
* 工作原理示意图

<center>![NFS工作原理图](http://linux.vbird.org/linux_server/0330nfs//nfs_server_client.png)

<center>图 8

* 服务端配置


    import os
    cmd = ['apt-get update', 'apt-get install nfs-kernel-server nfs-common',
       'mkdir /home/public', 'chmod -R 777 /home/public',
       'echo "/home/public  *(rw,sync,no_root_squash)" >>/etc/exports'
       , 'service rpcbind start', 'service nfs-kernel-server start']


    def install():
    for item in cmd:
        os.system(item)


    if __name__ == '__main__':
    install()



* 客户端配置


    import os
    cmd = ['apt-get update', 'apt-get install rcpbind',
           'apt-get install nfs-client', 'service rpcbind start',
           'mkdir /home/nfsshare', 'mount -t nfs 115.29.146.79:/home/public /home/nfsshare',
           'chmod -R 777 /home/nfsshare']


    def install():
        for item in cmd:
            os.system(item)


    if __name__ == '__main__':
        install()


* 卸载　NFS


    import os
    cmd = ['umount 115.29.146.79:/home/public',
           'service rpcbind stop', 'service nfs-kernel-server stop']


    def shudown():
        for item in cmd:
            os.system(item)


    if __name__ == '__main__':
        shudown()


### 参考文献
* [1] 鸟哥.鸟哥的Linux私房菜基础篇.北京：人民邮电出版社，2017年３月:197-247.
* [２] 鸟哥.鸟哥的Linux私房菜服务篇.北京：人民邮电出版社，2017年３月:393-420.
* [3] Michael Beck,Harald Bohme.Linux内核编程指南．北京：清华大学出版社，2005年７月：108-135.
