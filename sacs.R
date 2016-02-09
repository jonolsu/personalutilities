renwebfacts_wc <- function(pathname = "c:/temp/",filename="renwebfacts.csv")
{
    # adapted from http://www.r-bloggers.com/building-wordclouds-in-r/
    library(tm)
    library(SnowballC)
    library(wordcloud)
    set.seed(42)

    rf <- read.csv(paste0(pathname,filename), stringsAsFactors = FALSE)
    
    #Question Word Cloud
    png(paste0(pathname,"QuestionWC.png"), width=6, height=6, units="in", res=300)
    questionCorpus <- tm::Corpus(VectorSource(rf$question[rf$type == "question"]))
    questionCorpus <- tm::tm_map(questionCorpus, PlainTextDocument)
    questionCorpus <- tm::tm_map(questionCorpus, removePunctuation)
    questionCorpus <- tm::tm_map(questionCorpus, removeWords, stopwords('english'))
    questionCorpus <- tm::tm_map(questionCorpus, stemDocument)
    questionCorpus <- tm_map(questionCorpus, removeWords, c('can','Can', 'renweb', 'RenWeb', stopwords('english')))
    wordcloud::wordcloud(questionCorpus, max.words = 200, random.order = FALSE, colors=brewer.pal(8, "Dark2"))
    dev.off()
    
    #Answer Word Cloud
    png(paste0(pathname,"AnswerWC.png"), width=6, height=6, units="in", res=300)
    answerCorpus <- tm::Corpus(VectorSource(rf$answer[rf$type == "question"]))
    answerCorpus <- tm::tm_map(answerCorpus, PlainTextDocument)
    answerCorpus <- tm::tm_map(answerCorpus, removePunctuation)
    answerCorpus <- tm::tm_map(answerCorpus, removeWords, stopwords('english'))
    answerCorpus <- tm::tm_map(answerCorpus, stemDocument)
    answerCorpus <- tm_map(answerCorpus, removeWords, c('RenWeb', 'school','can','Can',stopwords('english')))
    wordcloud::wordcloud(answerCorpus, max.words = 200, random.order = FALSE, colors=brewer.pal(8, "Dark2"))
    dev.off()
    
    #All Word Cloud
    png(paste0(pathname,"AllWC.png"), width=6, height=6, units="in", res=300)
    allCorpus <- tm::Corpus(VectorSource(paste(rf$question,rf$answer)))
    allCorpus <- tm::tm_map(allCorpus, PlainTextDocument)
    allCorpus <- tm::tm_map(allCorpus, removePunctuation)
    allCorpus <- tm::tm_map(allCorpus, removeWords, stopwords('english'))
    allCorpus <- tm::tm_map(allCorpus, stemDocument)
    allCorpus <- tm_map(allCorpus, removeWords, c('RenWeb','can','Can',stopwords('english')))
    wordcloud::wordcloud(allCorpus, max.words = 200, random.order = FALSE, colors=brewer.pal(8, "Dark2"))
    dev.off()
}
