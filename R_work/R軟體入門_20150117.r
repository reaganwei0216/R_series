#################################################
#			第一章
#			基本運算規則
#################################################

## 簡單的數字與字串運算
1+2
3-4
5*6
7/8
9^0  # 等同於9**0
1+2*(3/4)^5  # 先乘除後加減，有括號先運算
sqrt(2)
abs(-1)

## 基本向量運算
x = c(1, 2, 3, 4, 5)  # 等同於1:5
y = x + 1
x*y
length(x)  # 向量長度
sum(y)  # 加總
prod(x)  # 累乘
mean(y)  # 平均
z = c(x, y)

## 向量及矩陣的指標用法
x[1]
y[c(2, 4)]
z[4:6]  # 等同於z[c(4, 5, 6)]
x >= 3
y[x >= 3]
x[x <= 2 | y == 5]  # 且(&, &&)，或(|, ||)
length(x[x < 4])
sum(y[y != 6])  # 不等號!=
x[-1]
y[-(2:4)]
X = rbind(x, y)  # row bind
Y = cbind(x, y)  # column bind
X[1, 5]
X[, 2]
Y[2 ,]
X[, c(1, 3)]
Y[2:4, -1]
Y[-1, -2]

## 多種指標用法
iris  ## iris dataset
iris[, 5]
iris[, "Species"]
iris$Species
iris[["Species"]]
iris["Species"]  # 等同於iris[5]
names(iris)
names(iris) = c("A","B","C","D","E")
iris$A
iris[18, c("B","D")]
iris[iris$E == "setosa", 1:4]


#################################################
#			第二章
#			變數型態
#################################################

## R軟體資料屬性: 邏輯真假值(logical,T,F), 整數(integer),
##  雙倍精確度數字(double, real, numeric),
##  複數(complex), 文字字串(character, string), 二進位資料(raw)

1; 20.0; 3e2  # 數值
class(1)
"stat"  # 文字
class("stat")
TRUE; T; FALSE; F  # 邏輯真假值
class(T)

## R軟體變數種類: 向量(vector), 矩陣(matrix), 陣列(array),
##  因子(factor), 資料框架(data-frame), 串列(list), 時間數列(ts)

## 向量(vector) ##
x = c(1, 3, 5, 7, 9)  # 建立向量，或聯結不同的向量
is.vector(x)  # 查詢x是否為向量變數
y = c(2, "stat", T)  # 元素屬性需相同
x[1]; y[-2]  # 向量指標
x[c(1, 3, 5)] = c(2, 4, 6)
c(x, y[1])
length(x)  # 算出元素個數
names(x)  # 查詢或建立向量的元素名稱
names(x) = c("a", "b", "c", "d", "e")
x[c(3, 5)]; x[c("c", "e")]

## 陣列(array), 矩陣(matrix) ##
X = array(1:6, c(3, 2))  # matrix(1:6, 3, 2) # 建立陣列變數
Y = array(1:12, c(2, 3, 2))
is.array(X); is.matrix(X)  # 查詢X是否為陣列及矩陣變數
rbind(x, x); cbind(x, x)  # 使用rbind及cbind來建立array變數
nrow(X)  # 查詢陣列的列數
ncol(X)  # 查詢陣列的行數
dim(Y)  # 查詢Y陣列的維度
rownames(X) = c("R1", "R2", "R3")
colnames(X) = c("C1", "C2")

## 矩陣(Matrix) ##
X = matrix(1:6, 3, 2)
Y = t(X)  # 轉置
Z = X %*% Y  # 矩陣相乘
diag(Z)  # 對角線函數
det(Z)  # 行列式
A = matrix(1:4, 2, 2)
b = c(2,2)
solve(A)  # 反矩陣
solve(A, b)  # 線性聯立方程式
eigen(Z)  # 特徵值與特徵向量

## 因子(Factor) ##
x = c(1, 1, 1, 2, 2, 2)
y = factor(x)  # 等同於 as.factor(x)
y - 1
levels(y)  # 查詢或設定分類資料
levels(y) = c("一", "二")
nlevels(y)  # 查詢分類數目

## 串列(List) ##
l = list(L1 = x, L2 = y, L3 = Z)
names(l)
l$L1  # 等同於 l[[1]] 或 l[["L1"]]
l[2]  # 等同於 l["L2"]
l$L3[1, 2]
l$L4 = 1:5
c(l, list(L5 = 1:10))

## 資料框架(Data-Frame) ##
D = as.data.frame(Z)  # 將變數類型轉為data-frame
D[, 4] = c(T, F, T)
names(D) = c("D1", "D2", "D3", "D4")


#################################################
#			第三章
#			資料的輸入與輸出
#################################################

setwd("D:/R_work/")  # 設定工作目錄

## 文字檔輸入 ##
babies = read.table("babies.txt", header=T)
babies = na.exclude(babies)  # 刪除具有遺失值的資料
Iris = read.table("iris_dataset.txt", header=F, sep=",")
IRIS = read.csv("iris.csv", header=F)

## 文字檔輸出 ##
cat(babies$smoke, file="smoke1.txt", sep="")
write(babies$smoke, file="smoke2.txt", sep=",")
weight = babies[babies$weight < 100,]
height = babies[babies$height > 70,]
write.table(weight, file="weight.txt", sep=",", row.names=F)
write.csv(height, file="height.csv", row.names=F)

## 存取其他軟體的資料檔 ##
library(gdata)
babies_xls = read.xls("babies.xls", sheet=1)  # 讀取xls檔
library(xlsx)
babies_xlsx = read.xlsx("babies.xlsx", sheetIndex=2)  # 讀取xlsx檔
write.xlsx(iris, "iris.xlsx", sheetName="iris")  # 匯出xlsx檔
library(sas7bdat)
babies_sas = read.sas7bdat("babies.sas7bdat")  # 讀取sas資料檔
library(foreign)
babies_spss = read.spss("babies.sav", to.data.frame=T)  # 讀取spss資料檔

## 存取R物件 ##
save(weight, height, file="babies.RData")
save.image()  # 儲存工作空間
load("babies.RData")


#################################################
#			第四章
#			程式流程控制
#################################################

## 邏輯判斷式 ##
## 運算子優先性：
##  括弧 => 乘除 => 加減 => 比較 => 邏輯 => 指派
x = 1
x == 3
x != 1 + 2
!(x <= 3)
x %in% 1:5
x < 0 || x > 5
(is.matrix(x) || x >= 0) & (1 < 2)

## 條件執行 ##
x = 1
if (x == 3) y = 10 else y = 20
if (x >= 5) {
	y = 15
} else {
	y=0
}  # 建議寫法
if (x < 0) {
	y = x - 1
} else if (x > 0) {
	y = x + 1
} else {
	y = x
}

## for迴圈 ##
y = vector()  # 宣告變數
for (x in 1:5) {
	y[x] = sqrt(x)
}
z = 1
for (i in c(2,4,6,8,10)) {
	z = z * i
}  # 2*4*6*8*10

## while迴圈 ##
x = 1; y = vector()
while (x <= 5) {
	y[x] = sqrt(x)
	x = x + 1
}
z = 1; i = 2
while (i <= 10) {
	z = z * i
	i = i + 2
}

## repeat迴圈 ##
x = 1; y = vector()
repeat {
	y[x] = sqrt(x)
	x = x + 1
	if (x > 5) break  # 跳離迴圈
}
z = 1; i = 1
repeat {
	i = i + 1
	if (i > 10) {break} else if (i %% 2 != 0) {next}
	z = z * i
}  # next: 跳過一次迴圈


#################################################
#			第五章
#			自訂函數
#################################################

## R的自訂函數 ##
# 函數的定義語法：
# 自訂function名稱 = function(參數1, 參數2, ...)
# {
# 	完整運算式...
# }

func1 = function(a, b)
{
	x = 1+2*3/4
	y <<- a + b
	return(y)  # 預設傳回最後一個運算值，或使用return函數
}
func1(7, 6)
func1(b=3, a=2)

## 參數的預設值 ##
func2 = function(x=0)
{
	sum(x)/length(x)
}
func2(1:5)
func2()  # 參數x的預設值為0

## ...參數 ##
func3 = function(x, ...)
{
	y = mean(x, ...) + 1
	return(y)
}
x = c(2,4,6,NA,10)
func3(x, trim=0.1)
func3(x, trim=0, na.rm=TRUE)

## 二元運算子 ##
"%p%" = function(a, b)
{
	factorial(a)/factorial(a-b)
}
5 %p% 2


#################################################
#			第六章
#			程式撰寫技巧
#################################################

## apply函數 ##
apply(iris[-5], 2, max)
func = function(x) x[x < mean(x)]
apply(iris[,1:4], 2, func)

## tapply函數 ##
tapply(iris[,1], iris[,5], min)
index2 = rep(1:2, length=150)
tapply(iris[,2], list(iris[,5],index2), median)

## sapply, lapply函數 ##
sapply(iris, length)
lapply(iris, length)
sapply(iris[-5], function(x) { which(x > mean(x)) })

## 各方法計算時間比較 ##
x = rnorm(50000)  # 以標準常態分配生成隨機樣本
y1 = y2 = y3 = y4 = vector()
t0 = proc.time()  # 起始時間
for (i in 1:length(x)) {
	if (x[i] <= 0) y1[i] = -1 else y1[i] = 1
}
t1 = proc.time() - t0                 # y1的計算時間
y2 = ifelse(x <= 0, -1, 1)
t2 = proc.time() - t0 - t1            # y2的計算時間
y3[x <= 0] = -1; y3[x > 0] = 1
t3 = proc.time() - t0 - t1 - t2       # y3的計算時間
y4 = sapply(x, function(x) {if (x <= 0) -1 else 1})
t4 = proc.time() - t0 - t1 - t2 - t3  # y4的計算時間

## Which is better? ##
aa=read.table("babies.txt",header=TRUE)
bb=na.exclude(aa$smoke);cc=vector()
for(i in 1:length(bb)){if(bb[i]==1) cc[i]="是" else cc[i]="否"}

## 讀入babies資料檔、宣告smoke及new_var變數 ##
babies = read.table("babies.txt", header=TRUE)
smoke = na.exclude(babies$smoke)
new_var = vector()

## 使用迴圈將smoke變數重新編碼並存入new_var變數 ##
for (i in 1:length(smoke)) {
	if (smoke[i] == 1) {
		new_var[i] = "是"
	} else {
		new_var[i] = "否"
	}
}
