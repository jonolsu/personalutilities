createshapefile(inputfilepath="c:/temp/Block_Vertices.csv")

createshapefile <- function(inputfilepath)
{
    library(shapefiles)
    df <- read.csv(inputfilepath)
    longformat <- getlongformat(df)
    
}

getlongformat <- function(df)
{
    dfout <- data.frame(Id=character(0),X=numeric(0),Y=numeric(0))
    for(i in 1:nrow(df))
    {
        dfout <- rbind(dfout,df[i,c(1,2:3)])
        dfout <- rbind(dfout,df[i,c(1,4:5)])
        dfout <- rbind(dfout,df[i,c(1,6:7)])
        dfout <- rbind(dfout,df[i,c(1,8:9)])
    }
    dfout
}
