<p align="center">
  <h1 align="center">Greenplum分布式数据库</h1>
  <p align="center">
    <a href="README.md"><strong>English</strong></a> | <strong>简体中文</strong>
  </p>
</p>

## 目录

- [仓库简介](#项目介绍)
- [前置条件](#前置条件)
- [镜像说明](#镜像说明)
- [获取帮助](#获取帮助)
- [如何贡献](#如何贡献)

## 项目介绍

‌[Green‌plum](https://greenplum.org/) 是一个先进的大规模并行处理（MPP）数据仓库，专为大规模数据分析、机器学习与商业智能（BI）场景而设计。它基于 PostgreSQL 开源数据库构建，继承了其丰富的 SQL 支持和强大的功能生态。
**核心特性：**
Greenplum 的核心在于其“大规模并行”架构，能够将海量数据的计算任务分散到数百个节点上并行执行，从而实现对 PB 级别数据的极速分析查询。为企业提供一个强大、高效且经济实惠的现代化数据仓库和数据分析平台，用于处理海量结构化与半结构化数据。

本项目提供的开源镜像商品 [**Grenplum分布式数据库**](待更新链接)，已预先安装Greenplum软件及其相关运行环境，并提供部署模板。快来参照使用指南，轻松开启“开箱即用”的高效体验吧。

> **系统要求如下：**
>
> - CPU: 2GHz 或更高
> - RAM: 4GB 或更大
> - Disk: 至少 40GB

## 前置条件

[注册华为账号并开通华为云](https://support.huaweicloud.com/usermanual-account/account_id_001.html)

## 镜像说明


| 镜像规格                                                                                                 | 特性说明                                                  | 备注 |
| -------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | ---- |
| [Greenplum-7.1.0-kunpeng](https://github.com/HuaweiCloudDeveloper/flink-image/tree/Flink-1.13.0-kunpeng) | 基于 鲲鹏服务器 + Huawei Cloud EulerOS 2.0 64bit 安装部署 |      |

## 获取帮助

- 更多问题可通过 [issue](https://github.com/HuaweiCloudDeveloper/greenplum-image/issues) 或 华为云云商店指定商品的服务支持 与我们取得联系
- 其他开源镜像可看 [open-source-image-repos](https://github.com/HuaweiCloudDeveloper/open-source-image-repos)

## 如何贡献

- Fork 此存储库并提交合并请求
- 基于您的开源镜像信息同步更新 README.md
