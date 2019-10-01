
# 1. load 자료
library(magrittr)
library(dplyr)
red <- read.csv("winequality-red.csv", sep=";", header=TRUE, stringsAsFactors=FALSE)
white <- read.csv("winequality-white.csv", sep=";", header=TRUE, stringsAsFactors=FALSE)

# red or white 종속변수 생성 
red <- red %>% mutate(type="red")
white <- white %>% mutate(type="white")

# 파일 합치기
wine <- dplyr::bind_rows(red, white)

# 파일 출력
write.csv(wine, file="wine.csv")

#
wine %>% str()

# 2. 탐색적 자료분석
library(ggplot2)
## wine type: statistic
wine %>% 
  group_by(type) %>%
  summarize(m=mean(quality), s=sd(quality), min=min(quality), max=max(quality))

## histogram
### Q) 순서형 범주형 변수에 대한 그래프의 특징 파악
wine %>% 
  ggplot(mapping=aes(x=quality, color=type, fill=type)) +
  geom_histogram(binwidth=0.5, position="dodge")

### 대칭형 분포

## T-검정
### wine type에 따른 quality의 차이를 검정
### 그룹별 평균과 표준편차 
wine %>% 
  group_by(type) %>%
  summarize(m=mean(quality), s=sd(quality))

fit <- t.test(quality ~ type, data=wine)
fit
names(fit)
fit$statistic
fit$estimate
fit$p.value

### p-value가 0에 가까우므로 귀무가설 기각
### wine 품질에 차이가 있음.

## 상관계수
cor_mat <- cor(wine %>% select(fixed.acidity:quality))
#heatmap(coeff_cor)

heatmap(cor_mat, scale="none")
library(GGally)
par(las=1)
GGally::ggpairs(wine %>% select(fixed.acidity:quality),diag=list(continuous="density", alpha=0.5),axisLabels="show")


### 알콜, 이산화황, 산성도, 구연산은 품질과 양의 상관관계가 있음
### 결합산, 휘발산, 잔여설탕, 염화물, 총이산화항, 밀도는 품질과 음의 상관관계가 있음.
  
## 산점도
GGally::ggpairs(wine %>% select(alcohol,residual.sugar,quality,type),diag=list(continuous="density", alpha=0.5),axisLabels="show")
### 알콜도수의 평균과 표준편차는 비슷
### 잔여설탕의 평균과 표준편차는 화이트와인이 레드와인보다 큼

### Q) 알콜도수가 증가하면 품질이 높아지는가?
wine %>% 
  ggplot(mapping=aes(x=alcohol, y=quality, color=type)) + 
  geom_smooth() #+geom_smooth(method="lm")

### 회귀직선 적합
fit <- lm(quality ~ type + alcohol, data=wine)
summary(fit)

# 3. 예측모형 생성하기
## 학습-평가 자료 분리
set.seed(1)
tr.id <- sample(1:nrow(wine), 5000)
tr.id <- sort(tr.id)

fit <- lm(quality ~., data=wine, subset=tr.id)
summary(fit)

## 변수선택
library(MASS)
step <- stepAIC(fit, direction="both")
step$anova

##install.packages("car")
car::vif(step)
### 통상적으로 10을 기준으로 함. 
haty <- predict(step, newdata=wine[-tr.id,])
qua <- wine$quality[-tr.id]
plot(qua, haty, xlim=c(3,9), ylim=c(3,9))
abline(a=0, b=1, col="red", lty=2, lwd=2)
### or
data.frame(qua, haty) %>% 
  ggplot(mapping=aes(x=qua, y=haty)) + 
  geom_point() + 
  geom_abline(intercept=0, slope=1, color="RED") + xlim(3,9) + ylim(3,9)

