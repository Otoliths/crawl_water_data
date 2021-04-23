if (!requireNamespace(c("jsonlite","rlist","httr"), quietly = TRUE))
  install.packages("jsonlite","rlist","httr",dependencies = T)

url <- "http://106.37.208.243:8068/GJZ/Ajax/Publish.ashx?AreaID=&RiverID=&MNName=&PageIndex=1&PageSize=9999&action=getRealDatas"
re1 <- jsonlite::fromJSON(url, simplifyVector = FALSE)
re1$tbody <- as.data.frame(rlist::list.rbind(re1$tbody))
re1$tbody <- apply(re1$tbody,1,function(x){gsub("<.*?>", "", x)})
re1$tbody <- as.data.frame(t(re1$tbody))
names(re1$tbody) <- gsub("<.*?>", "", unlist(re1$thead))
re1$thead <- gsub("<.*?>", "", re1$thead)


#re2 <- jsonlite::fromJSON("http://106.37.208.244:10001/Home/GetSectionDataList?", simplifyVector = FALSE)
#re2 <- as.data.frame(rlist::list.rbind(re2))
#download_date <- rep(Sys.time(),dim(re2)[1])
#http_date <- rep(httr::http_date(Sys.time()),dim(re2)[1])
#re2 <- cbind(download_date,http_date,re2)

#res <- list(less = re1,more = re2)

if (!file.exists(paste0("water_quality_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))){
  dir.create(paste0("water_quality_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))
}
path <- paste0("water_quality_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai"),"/",as.POSIXlt(Sys.time(), "Asia/Shanghai"),".rds")
saveRDS(re1,path)
