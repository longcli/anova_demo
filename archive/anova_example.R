

# LOAD PACKAGES ###############################################################

library(ggplot2)




# DO STUFF ####################################################################



# TESTING
cssize = 10
csd = 50
mu1 = 100; sd1 = csd
mu2 = 150; sd2 = csd
mu3 = 200; sd3 = csd
lenx = len1 = len2 = len3 = 100

# cssize = input$ssize
# mu1 = input$mu1; sd1 = input$sd1
# mu2 = input$mu2; sd2 = input$sd2
# mu3 = input$mu3; sd3 = input$sd3

lenx = 100  # keep constant, used to create prob dens fn
len1 = len2 = len3 = cssize


x1_min = mu1 - 4*sd1
x1_max = mu1 + 4*sd1
x1 = seq(x1_min, x1_max, length.out = lenx)
grp1 = rep('group 1', lenx)
y1 = dnorm(x1, mu1, sd1)
x1seq = 1:lenx


x2_min = mu2 - 4*sd2
x2_max = mu2 + 4*sd2
x2 = seq(x2_min, x2_max, length.out = lenx)
grp2 = rep('group 2', lenx)
y2 = dnorm(x2, mu2, sd2)
x2seq = 1:lenx


x3_min = mu3 - 4*sd3
x3_max = mu3 + 4*sd3
x3 = seq(x3_min, x3_max, length.out = lenx) 
grp3 = rep('group 3', lenx)
y3 = dnorm(x3, mu3, sd3)
x3seq = 1:lenx


dat = data.frame(x = append(append(x1,x2),x3),
                 y = append(append(y1,y2),y3),
                 group = append(append(grp1,grp2),grp3),
                 xseq = append(append(x1seq,x2seq),x3seq))


# take a subset based on sample size ##########################################

dtemp1 = dat


seqfm = 1
seqto = 100  # matches lenx above

# tmpssize = input$ssize
tmpssize = 10

seqby = round((seqto - seqfm)/tmpssize, 0)

subset_seq = seq(from = seqfm, to = seqto, by = seqby)

dsmpl <- dplyr::filter(dtemp1, xseq %in% subset_seq)


# plot datasetinit ############################################################

plotdat1 = dat

plot1 = ggplot(data = plotdat1, aes(x = x, y = y, group = group, color = group)) +
  geom_line(size = 2) 


# library(ggstance)
# 
# plot1 = plot1 + 
#   geom_boxploth(data = plotdat2, aes(x = x, y = group, group = group, color = group))



# boxplots for samples from each group ########################################

plotdat2 = dsmpl

plot2 = ggplot(data = plotdat2, aes(x = group, y = x, group = group, color = group)) +
  geom_boxplot() + coord_flip()


# plot2h = ggplot(data = plotdat2, aes(x = x, y = group, group = group, color = group)) +
#   geom_boxploth()



# ANOVA #######################################################################

dat_aov <- dsmpl

fit1 <- aov(x ~ group, data = dat_aov)

summary(fit1)


library(broom)

TukeyHSD(fit1)




# END CODE ####################################################################