install.packages("lsr")
library(lsr)
install.packages("ggplot2")
library(ggplot2)
install.packages('qqplotr')
library(qqplotr)
install.packages("pastecs")
library(pastecs)
install.packages("car")
library(car)

ce <- read.csv("course_evals.csv")
interaction.plot(x.factor = ce$gender, # x var
                 trace.factor = ce$ethnicity, #separate line
                 response = ce$score, #num var
                 fun=mean
)

anovamodel <- aov(score~gender*ethnicity, data=ce)
anova(anovamodel)
#gender p= 0.005
#ethnicity p= 0.18
#gender, eth p= 0.14

summary.lm(anovamodel)
#2.48%, 0.0248 R^2
#p= 0.008113

etaSquared(anovamodel)

ce$resid <- resid(anovamodel)
ce$pred <- fitted.values(anovamodel)

ggplot(data=ce, mapping=aes(sample=resid))+
  stat_qq_point()+
  stat_qq_line()+
  stat_qq_band()

stat.desc(ce$resid, norm=TRUE)
#p= 0.00

leveneTest(ce$score~ce$gender*ce$ethnicity)
#F= 1.1364
#p= 0.3339
plot(ce$pred, ce$resid)

#transformation
ceSq <- sqrt(ce$score)
anovamodelSq <- aov(score~gender*ethnicity, data=ce)
anova(anovamodelSq)
ce$predSq <- (fitted.values(anovamodelSq))^2
plot(ce$score, ce$predSq)

ceLog <- log(ce$score)
anovamodelLog <- aov(ceLog~score, data=ce)
anova(anovamodelLog)
ce$predLog <- exp(fitted.values(anovamodelLog))
plot(ce$score, ce$predLog)


