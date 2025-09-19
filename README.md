<p align="center">
  <h1 align="center">Greenplum distributed database</h1>
  <p align="center">
    <a href="README_ZH.md"><strong>简体中文</strong></a> | <strong>English</strong>
  </p>
</p>

## Table of Contents

- [Repository Introduction](#repository-introduction)
- [Prerequisites](#prerequisites)
- [Image Specifications](#image-specifications)
- [Getting Help](#getting-help)
- [How to Contribute](#how-to-contribute)

## Repository Introduction

‌[Green‌plum](https://greenplum.org/) is an advanced, Massively Parallel Processing (MPP) data warehouse specifically designed for large-scale data analytics, machine learning, and business intelligence (BI) scenarios. Built on the PostgreSQL open-source database, it inherits robust SQL support and a powerful ecosystem of features.

**Core Features:**
At the heart of Greenplum is its "massively parallel" architecture, which distributes computational tasks across hundreds of nodes to enable ultra-fast analytical queries on petabyte-scale datasets. It delivers a powerful, efficient, and cost-effective modern data warehouse and analytics platform for processing vast amounts of structured and semi-structured data.

This project offers pre-configured [**Greenplum distributed database**](!!) images with Greenplum and its runtime environment pre-installed, along with deployment templates. Follow the guide to enjoy an "out-of-the-box" experience.

> **System Requirements:**
>
> - CPU: 2GHz or higher
> - RAM: 4GB or more
> - Disk: At least 40GB

## Prerequisites

[Register a Huawei account and activate Huawei Cloud](https://support.huaweicloud.com/usermanual-account/account_id_001.html)

## Image Specifications


| Image Version                                                                                                   | Description                                                     | Notes |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- | ----- |
| [Greenplum-7.1.0-kunpeng](https://github.com/HuaweiCloudDeveloper/greenplum-image/tree/Greenplum-7.1.0-kunpeng) | Deployed on Kunpeng servers with Huawei Cloud EulerOS 2.0 64bit |       |

## Getting Help

- Submit an [issue](https://github.com/HuaweiCloudDeveloper/greenplum-image/issues)
- Contact Huawei Cloud Marketplace product support

## How to Contribute

- Fork this repository and submit a merge request.
- Update README.md synchronously based on your open-source mirror information.
