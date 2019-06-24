# 2019/6/25 교육

# A) Rstudio를 통한 cpu버젼의 keras설치
1. 
R은 https://cran.r-project.org/bin/windows/base/에서 R-3.6를 다운로드하여 설치합니다.

R Studio는 https://download1.rstudio.org/RStudio-1.2.1335.exe 에서 Windows용을 다운/설치합니다.

RTools는 https://cran.r-project.org/bin/windows/Rtools/Rtools34.exe에서 3.4를 다운/설치합니다.

[R Studio에서 연동되는 R 버젼확인 필요 ]


2.
install.packages('devtools')
devtools::install_github("rstudio/keras")

3. Anaconda를 설치
https://www.anaconda.com/download/
window 탭 클릭
python 3.7 version
-64bit(632MB)와 32bit(546MB)에서 선택

4.
library('keras')
install_keras() 

5. mnist <- datastset_mnist()

###############################
#python을 윈도우 앱에서 제거
#uninstall anaconda를 검색함
#Rstudio제거
#2. https://www.python.org/downloads/windows/
#에서 3.7.3설치
#Windows x86 executable installer

참고: https://belitino.tistory.com/257 [belitino]

##########################################
# B) XOR 분류
# XOR 분류(입력2개) 예제

library(neuralnet)
AND <- c(rep(0,3),1)
OR <- c(0,rep(1,3))

xx <- matrix(0,4,2)
xx[,1] <- c(0,0,1,1)
xx[,2] <- c(0,1,0,1)

# 1.
binary.data <- data.frame(xx, AND, OR)
colnames(binary.data) <- c("Var1", "Var2")
print(net <- neuralnet(AND+OR~Var1+Var2, binary.data, hidden=0, rep=10,err.fct="ce", linear.output=FALSE))
plot(net)

# 2.
XOR <- c(0,1,1,0)
xor.data <- data.frame(expand.grid(c(0,1), c(0,1)), XOR)
print(net.xor <- neuralnet(XOR~Var1+Var2, xor.data, hidden=2, rep=5))
plot(net.xor, rep="best")

