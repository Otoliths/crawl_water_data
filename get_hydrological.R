if (!requireNamespace(c("jsonlite","rlist"), quietly = TRUE))
  install.packages("jsonlite","rlist",dependencies = T)

baseurl1 <- "http://xxfb.mwr.cn/hydroSearch/"
baseurl2 <- "http://xxfb.mwr.cn/portal/"
query1 <- c("greatRiver","greatRsvr")
query2 <- c("vitalRiverInfo","vitalRsvrInfo","earlyWarningInfo","hydroinfoByDays","surpassWarningInfo")
hydroSearch <- lapply(1:length(query1),function(x){
  jsonlite::fromJSON(paste0(baseurl1,query1[x]))
})

portal <- lapply(1:length(query2),function(x){
  jsonlite::fromJSON(paste0(baseurl2,query2[x]))
})

hydrological <- list(greatRiver = hydroSearch[[1]],
                     greatRsvr = hydroSearch[[2]],
                     vitalRiverInfo = portal[[1]],
                     vitalRsvrInfo = portal[[2]],
                     earlyWarningInfo = portal[[3]],
                     hydroinfoByDays = portal[[4]],
                     surpassWarningInfo = portal[[5]])
if (!file.exists(paste0("hydrological_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))){
  dir.create(paste0("hydrological_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))
}
path <- paste0("hydrological_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai"),"/",as.POSIXlt(Sys.time(), "Asia/Shanghai"),".rds")
saveRDS(hydrological,path)
