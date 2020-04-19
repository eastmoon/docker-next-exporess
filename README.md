# docker-next-express

本專案基本資訊與知識參考[分散運算研究](https://github.com/eastmoon/Research-DistributionCalculation)

此專案為 Node.js 主從應用程式，其伺服器架構如下：

+ Server : next.js + express.js
+ Database : No-SQL MongoDB

軟體框架

+ JS Framework : React
+ CSS Framework : Bootstrap-React

## 執行專案

本專案設有 dockerw 作為操作 docker 介面層，並將部分系統初始、運作流程封裝其中，若無特殊需求請勿任意更改。

此介面層有 .bat ( for windows ) 與 .sh ( for mac, linux ) 請依據作業系統環境使用，後續統一使用 dockerw 作為操作說明

+ windows
```
dockerw -h
```

+ mac, linux
```
. dockerw.sh -h
```

#### 操作主機環境

+ 啟動
```
dockerw up
```
> 開啟此專案於背景模式

+ 關閉
```
dockerw down
```
> 關閉啟動中的容器

#### 參考

開發環境在 docker 啟動中會存在相關問題，參考文獻如下：
> + [react next.js Troubleshooting](https://github.com/pedromagalhaes/react-nextjs#troubleshooting)
> + [Updating Files Does not Cause HMR Reload](https://github.com/facebook/create-react-app/issues/659)
