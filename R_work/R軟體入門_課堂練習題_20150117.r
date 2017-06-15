########################################################
##          R 軟體系列課程(一) - R 軟體入門
##          課堂練習題參考答案
##          2015/01/17
########################################################


####################
##  基本操作環境  ##
####################

## 將工作目錄設定為"D:\R_work\"
setwd("D:/R_work/")  # 注意斜線方向

## 嘗試下載並安裝"rgl"套件
install.packages("rgl")
library(rgl)  # 載入套件

## 利用 demo 功能檢視 rgl 套件中的函數範例
demo(rgl, package="rgl")

## 利用 help 功能查看 rgl 套件中的函數說明
help(surface3d)  # 等同於 ?surface3d

## 嘗試執行 rgl 套件中的函數範例
example(plot3d)


####################
##  基本運算規則  ##
####################

## 取出 iris 資料集中鳶尾花品種為 setosa 的資料
iris_setosa = iris[iris$Species == "setosa",]
iris_setosa = iris[iris["Species"] == "setosa",]  # 亦可
iris_setosa = iris[iris[,5] == "setosa",]  # 亦可

## 將上述資料依 Sepal.Length 變數進行排序
iris_setosa[order(iris_setosa$Sepal.Length),]


######################
##  R 的變數與資料  ##
######################

## 已知 x = 1:5 以及 y = c("一", "二", "三", "四", "五")
## 將 x 的元素名稱改為甲、乙、丙、丁、戊
x = 1:5
y = c("一", "二", "三", "四", "五")
names(x) = c("甲", "乙", "丙", "丁", "戊")

## 查詢 rbind(x, y) 的維度
rxy = rbind(x, y)
dim(rxy)

## 將 y 變數的型態轉變為因子(factor)變數
y = as.factor(y)

## 將 cbind(x, y) 的型態轉變為資料框架(data-frame)
cxy = cbind(x, y)
cxy = as.data.frame(cxy)

## 建立一個 2*3*4 的三維陣列，其元素為 1:24
array(1:24, dim=c(2,3,4))

## 查詢 rbind(x, y) 的型態是否為陣列(array)
is.array(rxy)

## 將 x, y 合併為一個串列(list)，並查詢其第一個元素
lxy = list(X=x, Y=y)
lxy$X; lxy[["X"]]; lxy[[1]]  # 試試 lxy["X"] 或 lxy[1] 的結果，變數型態有何不同？


########################
##  資料的輸入與輸出  ##
########################

## 讀入外部資料檔"babies.txt"
babies = read.table("babies.txt", header=TRUE)  # 參數視資料檔內容而定

## 分別將 babies 及 iris 匯出成 csv 檔且不包含列名稱
write.csv(babies, file="babies_csv.csv", row.names=FALSE)
write.csv(iris, file="iris_csv.csv", row.names=FALSE)

## 將 babies 及 iris 儲存至同一個 RData 檔
save(babies, iris, file="datasets.RData")


####################
##  程式流程控制  ##
####################

## 有一物件 x = matrix(NA, 5, 5)
## 以迴圈逐一判斷每個元素的行列指標和是否可被 3 整除
## 若可以整除則該元素值為 1；反之為 0
## 例：因 4 + 2 = 6 可被 3 整除，故第 4 列第 2 行的元素值為 1
x = matrix(NA, 5, 5)
for (i in 1:nrow(x)) {
	for (j in 1:ncol(x)) {
		k = i + j
		if (k %% 3 == 0) {
			x[i, j] = 1
		} else {
			x[i, j] = 0
		}
	}
}  # 可嘗試以 while 或 repeat 迴圈改寫


################
##  自訂函數  ##
################

## 定義一個可計算階層數的函數
## Hint：利用遞迴呼叫，0! = 1
f = function(x)
{
	if (x <= 1) {
		return(1)
	} else {
		return(x * f(x - 1))
	}
}

## 定義一個可進行組合數計算的二元運算子
## 註：n 取 r 的組和數 = n! / r! / (n-r)!
"%c%" = function(n, r)
{
	f(n) / f(r) / f(n - r)
}


####################
##  程式撰寫技巧  ##
####################

## 計算 babies 資料集中每一個變數的遺失值個數
func = function(x)
{
	sum(is.na(x))  # 對邏輯值進行運算時，TRUE = 1；FALSE = 0
}
apply(babies, MARGIN=2, FUN=func)

## 以 smoke 為分組變數，繪製 parity 變數的次數表
tapply(babies$parity, INDEX=babies$smoke, FUN=table)

