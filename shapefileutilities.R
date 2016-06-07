createshapefile <- function(inputfilepath, outputfilepath)
{
    library(shapefiles)
    df <- read.csv(inputfilepath)
    dd <- getlongformat(df)
    ddTable <- df[,c(1,1)]
    names(ddTable) <- c("Id","Name")
    ddShapefile <- shapefiles::convert.to.shapefile(dd,ddTable,"Id",5)
    write.shapefile(ddShapefile,outputfilepath,arcgis=T)
}

getlongformat <- function(df)
{
    dfout <- data.frame(Id=character(0),X=numeric(0),Y=numeric(0))
    for(i in 1:nrow(df))
    {
        for(j in 1:4)
        {
            newrow <- df[i,c(1,(j*2):(j*2+1))]
            names(newrow) <- c("Id","X","Y")
            dfout <- rbind(dfout,newrow)
        }
    }
    dfout
}

#createshapefile(inputfilepath="c:/temp/Block_Vertices.csv")