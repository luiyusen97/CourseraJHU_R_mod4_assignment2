if (!file.exists("rawdata//emissionsdata.zip")){
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                  destfile = "rawdata//emissionsdata.zip")
}
unzip(zipfile = "rawdata//emissionsdata.zip", exdir = "rawdata//emissionsdata")

# get the rawdata
NEI <- readRDS("rawdata//emissionsdata//summarySCC_PM25.rds")
SCC <- readRDS("rawdata//emissionsdata//Source_Classification_Code.rds")

# split and calculate sums of total emissions by year
NEIbyyear <- split(NEI, NEI$year)
years <- unique(NEI[ , 6])
totalpm25 <- vector(mode = "numeric")
for (frame in NEIbyyear){
    totalpm25yr <- sum(frame[ , 4])
    totalpm25 <- c(totalpm25, totalpm25yr)
}

# organise data and draw plot
totalpm25frame <- cbind(years, totalpm25)
png(filename = "plot1.png")
plot(totalpm25frame)
dev.off()