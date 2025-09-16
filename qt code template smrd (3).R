#### QT Code Template ####

library(tidyverse)

# load data in and clean accordingly (not included here)

# notating the data for the no manipulation setup 
data$new_order <- NA
data$new_order[data$order_name =="No manipulation"] <- "no manipulation"

# for the order manipulation setup, labeling the conditions that are natural vs. unnatural
# this is just an example!! where the "support first" for control was natural and for treatment was unnatural

data$new_order[data$treatment=="control" & data$order_name =="Support first"] <- "natural"
data$new_order[data$treatment=="treatment" & data$order_name =="Oppose first"] <- "natural"
data$new_order[data$treatment=="control" & data$order_name =="Oppose first"] <- "unnatural"
data$new_order[data$treatment=="treatment" & data$order_name =="Support first"] <- "unnatural"


#### Processes Setup ####

#this is the setup we have used to be able to calculate SMRD and proportion, which requires reorganizing data/aspects

# numloops is a variable that captures the number of aspects generated

data$numloops_combined <- rowSums(sapply(data[,c("numloops1","numloops2","numloops3")],as.numeric), na.rm = T)
xref <- data[,c("ResponseId","order_name","treatment","numloops1","numloops2","numloops3","numloops_combined","dependent_variable")]

# the aspect question IDs shown here corresponds with the qualtrics template
# a placemarker question ID for the outcome variables are used

list <- data %>% dplyr::select (ResponseId,treatment, order_name,
                                # aspect - no order manipulation
                                `1_QID927`,`2_QID927`,`3_QID927`,`4_QID927`,`5_QID927`,`6_QID927`,`7_QID927`,`8_QID927`,`9_QID927`,`10_QID927`,`11_QID927`,`12_QID927`,`13_QID927`,`14_QID927`,`15_QID927`,`16_QID927`,`17_QID927`,`18_QID927`,`19_QID927`,`20_QID927`,
                                # aspect - support
                                `1_Q1675`,`2_Q1675`,`3_Q1675`,`4_Q1675`,`5_Q1675`,`6_Q1675`,`7_Q1675`,`8_Q1675`,`9_Q1675`,`10_Q1675`,`11_Q1675`,`12_Q1675`,`13_Q1675`,`14_Q1675`,`15_Q1675`,`16_Q1675`,`17_Q1675`,`18_Q1675`,`19_Q1675`,`20_Q1675`,
                                # aspect - oppose
                                `1_Q1702`,`2_Q1702`,`3_Q1702`,`4_Q1702`,`5_Q1702`,`6_Q1702`,`7_Q1702`,`8_Q1702`,`9_Q1702`,`10_Q1702`,`11_Q1702`,`12_Q1702`,`13_Q1702`,`14_Q1702`,`15_Q1702`,`16_Q1702`,`17_Q1702`,`18_Q1702`,`19_Q1702`,`20_Q1702`,

                                # dependent variable - no order manipulation
                                `1_QX`,`2_QX`,`3_QX`,`4_QX`,`5_QX`,`6_QX`,`7_QX`,`8_QX`,`9_QX`,`10_QX`,`11_QX`,`12_QX`,`13_QX`,`14_QX`,`15_QX`,`16_QX`,`17_QX`,`18_QX`,`19_QX`,`20_QX`,
                                # dependent variable - support first
                                `1_QY`,`2_QY`,`3_QY`,`4_QY`,`5_QY`,`6_QY`,`7_QY`,`8_QY`,`9_QY`,`10_QY`,`11_QY`,`12_QY`,`13_QY`,`14_QY`,`15_QY`,`16_QY`,`17_QY`,`18_QY`,`19_QY`,`20_QY`,
                                # dependent variable - oppose first
                                `1_QZ`,`2_QZ`,`3_QZ`,`4_QZ`,`5_QZ`,`6_QZ`,`7_QZ`,`8_QZ`,`9_QZ`,`10_QZ`,`11_QZ`,`12_QZ`,`13_QZ`,`14_QZ`,`15_QZ`,`16_QZ`,`17_QZ`,`18_QZ`,`19_QZ`,`20_QZ`,
)

names(list) <- c("ResponseId","treatment","order_name",
                 "X1_asp_noManip","X2_asp_noManip","X3_asp_noManip","X4_asp_noManip",
                 "X5_asp_noManip","X6_asp_noManip","X7_asp_noManip","X8_asp_noManip","X9_asp_noManip","X10_asp_noManip",
                 "X11_asp_noManip","X12_asp_noManip","X13_asp_noManip","X14_asp_noManip","X15_asp_noManip","X16_asp_noManip",
                 "X17_asp_noManip","X18_asp_noManip","X19_asp_noManip","X20_asp_noManip",
                 "X1_asp_Support","X2_asp_Support","X3_asp_Support","X4_asp_Support",
                 "X5_asp_Support","X6_asp_Support","X7_asp_Support","X8_asp_Support","X9_asp_Support","X10_asp_Support",
                 "X11_asp_Support","X12_asp_Support","X13_asp_Support","X14_asp_Support","X15_asp_Support","X16_asp_Support",
                 "X17_asp_Support","X18_asp_Support","X19_asp_Support","X20_asp_Support",
                 "X1_asp_Oppose","X2_asp_Oppose","X3_asp_Oppose","X4_asp_Oppose",
                 "X5_asp_Oppose","X6_asp_Oppose","X7_asp_Oppose","X8_asp_Oppose","X9_asp_Oppose","X10_asp_Oppose",
                 "X11_asp_Oppose","X12_asp_Oppose","X13_asp_Oppose","X14_asp_Oppose","X15_asp_Oppose","X16_asp_Oppose",
                 "X17_asp_Oppose","X18_asp_Oppose","X19_asp_Oppose","X20_asp_Oppose",
                 "X1_dv_noManip","X2_dv_noManip","X3_dv_noManip",
                 "X4_dv_noManip","X5_dv_noManip","X6_dv_noManip","X7_dv_noManip","X8_dv_noManip","X9_dv_noManip","X10_dv_noManip",
                 "X11_dv_noManip","X12_dv_noManip","X13_dv_noManip","X14_dv_noManip","X15_dv_noManip","X16_dv_noManip","X17_dv_noManip",
                 "X18_dv_noManip","X19_dv_noManip","X20_dv_noManip",
                 "X1_dv_Support","X2_dv_Support","X3_dv_Support",
                 "X4_dv_Support","X5_dv_Support","X6_dv_Support","X7_dv_Support","X8_dv_Support","X9_dv_Support","X10_dv_Support",
                 "X11_dv_Support","X12_dv_Support","X13_dv_Support","X14_dv_Support","X15_dv_Support","X16_dv_Support","X17_dv_Support",
                 "X18_dv_Support","X19_dv_Support","X20_dv_Support",
                 "X1_dv_Oppose","X2_dv_Oppose","X3_dv_Oppose",
                 "X4_dv_Oppose","X5_dv_Oppose","X6_dv_Oppose","X7_dv_Oppose","X8_dv_Oppose","X9_dv_Oppose","X10_dv_Oppose",
                 "X11_dv_Oppose","X12_dv_Oppose","X13_dv_Oppose","X14_dv_Oppose","X15_dv_Oppose","X16_dv_Oppose","X17_dv_Oppose",
                 "X18_dv_Oppose","X19_dv_Oppose","X20_dv_Oppose")

backup <- list
list <- list %>% pivot_longer(cols = -c("ResponseId","treatment","order_name")) %>% filter(value !="")
list$n <- NA
list$n[grepl("1_",list$name)] <- 1
list$n[grepl("2_",list$name)] <- 2
list$n[grepl("3_",list$name)] <- 3
list$n[grepl("4_",list$name)] <- 4
list$n[grepl("5_",list$name)] <- 5
list$n[grepl("6_",list$name)] <- 6
list$n[grepl("7_",list$name)] <- 7
list$n[grepl("8_",list$name)] <- 8
list$n[grepl("9_",list$name)] <- 9
list$n[grepl("10_",list$name)] <- 10
list$n[grepl("11_",list$name)] <- 11
list$n[grepl("12_",list$name)] <- 12
list$n[grepl("13_",list$name)] <- 13
list$n[grepl("14_",list$name)] <- 14
list$n[grepl("15_",list$name)] <- 15
list$n[grepl("16_",list$name)] <- 16
list$n[grepl("17_",list$name)] <- 17
list$n[grepl("18_",list$name)] <- 18
list$n[grepl("19_",list$name)] <- 19
list$n[grepl("20_",list$name)] <- 20

list$type <- NA
list$type[grepl("_asp",list$name)] <- "aspect"
list$type[grepl("_dv",list$name)] <- "dv"

list$s_o <- ifelse(grepl("Support",list$name)==T,"s",ifelse(grepl("Oppose",list$name)==T,"o","none"))
list$support_order <- factor(list$s_o, levels = c("s","o"),exclude = "none")
list$oppose_order <- factor(list$s_o, levels = c("o","s"),exclude = "none")
list_0 <- list[list$order_name=="No manipulation",]
list_0$n_new <- list_0$n
list_1_asp <-
  list %>% filter(order_name=="Support first" & type == "aspect") %>%
  group_by(ResponseId) %>% arrange(ResponseId, support_order) %>% mutate(n_new = row_number())
list_1_dv <-
  list %>% filter(order_name=="Support first" & type == "dv") %>%
  group_by(ResponseId) %>% arrange(ResponseId, support_order) %>% mutate(n_new = row_number())
list_2_asp <-
  list %>% filter(order_name=="Oppose first" & type == "aspect") %>%
  group_by(ResponseId) %>% arrange(ResponseId, oppose_order) %>% mutate(n_new = row_number())
list_2_dv <-
  list %>% filter(order_name=="Oppose first" & type == "dv") %>%
  group_by(ResponseId) %>% arrange(ResponseId, oppose_order) %>% mutate(n_new = row_number())

list <- rbind(list_0,list_1_asp,list_1_dv,list_2_asp,list_2_dv)

list <- list %>%
  pivot_wider(id_cols = c("ResponseId","treatment","order_name","n_new"), names_from = "type", values_from = "value")

# filter out any aspects that should not count - including when "9" is entered

list %>% mutate(ln = nchar(aspect)) %>% filter(ln <5) %>% group_by(aspect) %>% summarise(n=n()) %>% print(n=45)

list <- list %>% filter(aspect != "9")
list <- list %>% filter(aspect != "99")
list <- list %>% filter(aspect != "0")
list <- list %>% filter(aspect != "\"9\"")
list <- list %>% filter(aspect != "N/A")
list <- list %>% filter(aspect != "N/a")


# number of aspects per condition
list %>% group_by(ResponseId, treatment, order_name) %>% summarise(n = max(n_new)) %>% 
  group_by(treatment, order_name) %>% summarise(m = mean(n), se = sd(n, na.rm = TRUE) / sqrt(n()))

#### Proportion and SMRD Calculations ####

# calculate proportion of support-increasing over total & over subset
prop <- list %>%
  group_by(ResponseId) %>%
  summarise(
    dv_support_inc = sum(dv == "It was in favor of increasing support"),
    dv_n_incDec = sum(dv == "It was in favor of increasing support") + sum(dv == "It was in favor of decreasing support"),
    prop_SupportInc_ofTotal_dv = dv_support_inc / n(),
    prop_SupportInc_ofID_dv = dv_support_inc / dv_n_incDec,
    .groups = 'drop'  # This drops the grouping after summarisation
  ) %>%
  mutate(prop_SupportInc_ofID_dv = ifelse(is.na(prop_SupportInc_ofID_dv), 0, prop_SupportInc_ofID_dv))

prop <- 
  prop %>% left_join(xref, by = c("ResponseId" = "ResponseId"))

# calculating SMRD
smrd_dv <-
  list %>% dplyr::select(-c("aspect")) %>%
  filter(dv=="It was in favor of increasing support" | dv == "It was in favor of decreasing support") %>% group_by(ResponseId) %>%
  dplyr::mutate(Aspect_Adj = 1:n()) %>% #Rerank aspects as both/neithers now removed
  dplyr::mutate(N_Aspects = n()) %>% #Renumber total aspects per P
  ungroup() %>% mutate(dv = dplyr::if_else(dv=="It was in favor of increasing support","Inc","Dec")) %>%
  spread(dv, Aspect_Adj) %>%
  group_by(ResponseId) %>% 
  dplyr::mutate(SMRD = if(all(is.na(Inc))) -1 # Calculate SMRD. Per CDL, Ps who only have one type of thought get coded as 1 or -1, else calculate SMRD.
                else if (all(is.na(Dec))) 1
                else (2*(median(Dec, na.rm=T) - median(Inc,na.rm=T))/(N_Aspects))) %>%
  ungroup %>%
  dplyr::select(ResponseId, SMRD, N_Aspects) %>% unique() %>% 
  left_join(xref,by = c("ResponseId"="ResponseId"))

id_tofix <- unique(list$ResponseId)[!(unique(list$ResponseId) %in% smrd_dv$ResponseId)]
list %>% filter(ResponseId %in% id_tofix) %>% dplyr::select(dv) %>% unique() # confirm that these do not have any 1s or 2s
smrd_dv_fixes <- 
  list %>% filter(ResponseId %in% id_tofix) %>% group_by(ResponseId) %>% summarise(SMRD = 0, N_Aspects = 0) %>%
  left_join(xref, by = c("ResponseId"="ResponseId"))

smrd_dv <- rbind(smrd_dv,smrd_dv_fixes)

# SMRD = 2(MRd – MRi)/n
# MRd is the median rank of decreasing support thoughts, 
# MRi is the median rank of increasing support thoughts, and n is the total number of thoughts that increase or decrease support. 
# Randomly interspersed thoughts produce an SMRD of zero.

smrd_dv %>% group_by(treatment, order_name) %>% summarise(m_SMRD = mean(SMRD), sd = sd(SMRD), se = sqrt(sd)/n())


#### Analyses ####


# select no order manipulation conditions

no_manipulation <- data[data$order==0,]

# can now run different analyses, like this regression below

prop_s2 <- prop %>% filter(order_name=="No manipulation")

t.test(prop_SupportInc_ofID_dv ~ treatment, data = prop_s2)

smrd_s2 <- smrd_dv %>% filter(order_name=="No manipulation")

t.test(SMRD ~ treatment, data = smrd_s2)

# select order manipulation conditions 

study3 <- data[data$order!=0,]

prop_s3 <- prop[prop$order_name!="No manipulation",]
smrd_s3 <- smrd_dv[smrd_dv$order_name!="No manipulation",]


# set natural vs unnatural order, below is an example
prop_s3$new_order <- NA
prop_s3$new_order[prop_s3$treatment=="control" & prop_s3$order_name =="Support first"] <- "natural"
prop_s3$new_order[prop_s3$treatment=="treatment" & prop_s3$order_name =="Oppose first"] <- "natural"
prop_s3$new_order[prop_s3$treatment=="control" & prop_s3$order_name =="Oppose first"] <- "unnatural"
prop_s3$new_order[prop_s3$treatment=="treatment" & prop_s3$order_name =="Support first"] <- "unnatural"

# smrd_s3_sub1 only includes observations where SMRD is -1 for oppose first and SMRD is 1 for support first
# meaning when all oppose thoughts come first for oppose condition and all support thoughts come first for support condition

smrd_s3_sub1 <- smrd_s3[(smrd_s3$SMRD==-1 & smrd_s3$order_name=="Oppose first") | 
                          (smrd_s3$SMRD==1 & smrd_s3$order_name=="Support first"),]
smrd_s3_sub2 <- smrd_s3[(smrd_s3$SMRD<=0 & smrd_s3$order_name=="Oppose first") | 
                          (smrd_s3$SMRD>=0 & smrd_s3$order_name=="Support first"),]

# can conduct separate analyses on these different subsets
study3_sub1 <- study3[study3$ResponseId %in% smrd_s3_sub1$ResponseId,]
study3_sub2 <- study3[study3$ResponseId %in% smrd_s3_sub2$ResponseId,]
prop_s3_sub1 <- prop_s3[prop_s3$ResponseId %in% smrd_s3_sub1$ResponseId,]
prop_s3_sub2 <- prop_s3[prop_s3$ResponseId %in% smrd_s3_sub2$ResponseId,]

# example analyses, could also compare between natural vs. unnatural

# natural
t.test(study3$dependent_variable[study3$new_order=="natural" & study3$treatment=="control"],
       study3$dependent_variable[study3$new_order=="natural" & study3$treatment=="treatment"])

# unnatural
t.test(study3$dependent_variable[study3$new_order=="unnatural" & study3$treatment=="control"],
       study3$dependent_variable[study3$new_order=="unnatural" & study3$treatment=="treatment"])

# proportion

t.test(prop_s3$prop_SupportInc_ofID_dv[prop_s3$new_order=="natural" & prop_s3$treatment=="control"],
       prop_s3$prop_SupportInc_ofID_dv[prop_s3$new_order=="natural" & prop_s3$treatment=="treatment"])
t.test(prop_s3$prop_SupportInc_ofID_dv[prop_s3$new_order=="unnatural" & prop_s3$treatment=="control"],
       prop_s3$prop_SupportInc_ofID_dv[prop_s3$new_order=="unnatural" & prop_s3$treatment=="treatment"])
