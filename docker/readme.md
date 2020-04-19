# Docker 環境設置

執行此範例，請先安裝完 [Docker](https://www.docker.com/)

+ [Docker for Window](https://docs.docker.com/docker-for-windows/)
+ [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

## 執行專案

#### 1、映像檔 (Image) 初始化

```
docker build --rm -t php:custom ./dockerfile/node
```
> 初始化 node 映像檔

```
docker build --rm -t mysql:custom ./dockerfile/mongo
```
> 初始化 mongo 映像檔

#### 2、開啟容器

```
docker-compose up -d
```
> 透過 docker compose 機制執行腳本設定，將複數容器建立後執行於背景

```
docker-compose ps
```
> 確認各容器執行狀況

```
docker-compose down
```
> 停止並關閉容器；關閉容器會將 MySQL 內容清空，下次啟動會需要重新設置內容。

#### 3、專案程式

```
Project directory
  └ dockerfile
  └ app
```

+ dockerfile
> 此為放置 Docker 相關主機設定

+ app
> 此為放置伺服器應用程式原始碼
