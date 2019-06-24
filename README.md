# 2019/6/25 교육
# Rstudio를 통한 cpu버젼의 keras설치

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
