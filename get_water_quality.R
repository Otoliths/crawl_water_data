url <- "http://106.37.208.243:8068/GJZ/Ajax/Publish.ashx?AreaID=&RiverID=&MNName=&PageIndex=1&PageSize=9999&action=getRealDatas"
res <- jsonlite::fromJSON(url, simplifyVector = FALSE)
res$tbody <- as.data.frame(rlist::list.rbind(res$tbody))
res$tbody <- apply(res$tbody,1,function(x){gsub("<.*?>", "", x)})
res$tbody <- as.data.frame(t(res$tbody))
names(res$tbody) <- gsub("<.*?>", "", unlist(res$thead))
res$thead <- gsub("<.*?>", "", res$thead)
if (!file.exists(paste0("water_quality_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))){
  dir.create(paste0("water_quality_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))
}
path <- paste0("water_quality_data/",as.POSIXlt(Sys.Date(), "Asia/Shanghai"),"/",as.POSIXlt(Sys.time(), "Asia/Shanghai"),".rds")
saveRDS(res,path)
