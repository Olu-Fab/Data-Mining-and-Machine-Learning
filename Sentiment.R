# loading required packages

install.packages("tm")
library(tm)
install.packages("wordcloud")
library(wordcloud)
install.packages("wordcloud2")
library(wordcloud2)



Tourist

names(Tourist)
head(Tourist)
tail(Tourist)
nrow(Tourist)
ncol(Tourist)
dim(Tourist)
str(Tourist)
summary(Tourist)

#SetSeed and selecting random Sample of 30 Hotels
set.seed(600)
TouristRandom <- sample(Tourist$Hotel.Restaurant.name, size = 30, replace = FALSE)
TouristRandom

#Selecting the different Tables for the selected 30 random Hotels
Amalfi<-subset(Tourist, Hotel.Restaurant.name=="Amalfi")
Baba_Soul<-subset(Tourist, Hotel.Restaurant.name=="Baba Soul Food")
Shakers<-subset(Tourist, Hotel.Restaurant.name=="Shakers")
Fatty<-subset(Tourist, Hotel.Restaurant.name=="Fatty's")
Tandoori <-subset(Tourist, Hotel.Restaurant.name=="Tandoori Flames")
Orchid<-subset(Tourist, Hotel.Restaurant.name=="The Orchid Garden")
Trattoria<-subset(Tourist, Hotel.Restaurant.name=="Trattoria del Buongustaio")
Live_India<-subset(Tourist, Hotel.Restaurant.name=="Live India Indian Restaurant")
Ohlala<-subset(Tourist, Hotel.Restaurant.name=="Ohlala")
Siam_Deli <-subset(Tourist, Hotel.Restaurant.name=="Siam Deli")
Cafe_101<-subset(Tourist, Hotel.Restaurant.name=="Cafe 101 Bar & Restaurant")
Outdoor<-subset(Tourist, Hotel.Restaurant.name=="Outdoor Restaurant")
Sabaijai<-subset(Tourist, Hotel.Restaurant.name=="Sabaijai Cafe")
Skye_Lake<-subset(Tourist, Hotel.Restaurant.name=="Skye Lake Club - Laguna, Phuket")
Blue_Elephant<-subset(Tourist, Hotel.Restaurant.name=="Blue Elephant Phuket")
Hard_Rock_Cafet<-subset(Tourist, Hotel.Restaurant.name=="Hard Rock Cafe Phuket")
Pum_Thai<-subset(Tourist, Hotel.Restaurant.name=="Pum Thai Restaurant")
CatFish_Cafe<-subset(Tourist, Hotel.Restaurant.name=="CatFish Cafe")
Kwality_Indian<-subset(Tourist, Hotel.Restaurant.name=="Kwality Indian Restaurant")
Chez_Nicolas <-subset(Tourist, Hotel.Restaurant.name=="Chez Nicolas")
Pomodoro_Pizza<-subset(Tourist, Hotel.Restaurant.name=="Pomodoro Pizza Restaurant")
Blue_Wave<-subset(Tourist, Hotel.Restaurant.name=="Blue Wave Restaurant")
Sweet_and_Sour<-subset(Tourist, Hotel.Restaurant.name=="Sweet and Sour")
Madras_Cafe<-subset(Tourist, Hotel.Restaurant.name=="Madras Cafe")
Mama_Restaurant <-subset(Tourist, Hotel.Restaurant.name=="Mama Restaurant - Karon Beach")
Modena<-subset(Tourist, Hotel.Restaurant.name=="Modena")
Salute_Italian<-subset(Tourist, Hotel.Restaurant.name=="Salute Italian Restaurant")
Restaurant_Royale<-subset(Tourist, Hotel.Restaurant.name=="Restaurant Royale Nam Tok")
Mamasita<-subset(Tourist, Hotel.Restaurant.name=="Mamasita Mexican")
Yorkshire<-subset(Tourist, Hotel.Restaurant.name=="Yorkshire Hotel Restaurant")


#Inspecting the review column in the datasets
head(Madras_Cafe$Review)
head(Modena$Review)
head(Salute_Italian$Review)
head(Yorkshire$Review)
head(Mamasita$Review)

#Creating the Text Vectors and cleaning

reviews_Amalfi<-Amalfi$Review
reviews_Baba_Soul<-Baba_Soul$Review
reviews_Blue_Elephant<-Blue_Elephant$Review
reviews_Blue_wave<-Blue_Wave$Review
reviews_Cafe_101<-Cafe_101$Review
reviews_Catfish_cafe<-CatFish_Cafe$Review
reviews_Chez_Nicolas<-Chez_Nicolas$Review
reviews_Fatty<-Fatty$Review
reviews_HardRock<-Hard_Rock_Cafet$Review
reviews_Kwality_Indian<-Kwality_Indian$Review
reviews_Live_India<-Live_India$Review
reviews_Madras<-Madras_Cafe$Review
reviews_Mama_Restaurant<-Mama_Restaurant$Review
reviews_Mamasita<-Mamasita$Review
reviews_Modena<-Modena$Review
reviews_Ohlala<-Ohlala$Review
reviews_Orchid<-Orchid$Review
reviews_Outdoor<-Outdoor$Review
reviews_Pomodoro_Pizza<-Pomodoro_Pizza$Review
reviews_Pum_Thai<-Pum_Thai$Review
reviews_Restaurant_Royale<-Restaurant_Royale$Review
reviews_Sabaijai<-Sabaijai$Review
reviews_Salute_Italian<-Salute_Italian$Review
reviews_Shakers<-Shakers$Review
reviews_Siam_Deli<-Siam_Deli$Review
reviews_Skye_lake<-Skye_Lake$Review
reviews_Sweet_and_Sour<-Sweet_and_Sour$Review
reviews_Tandoori<-Tandoori$Review
reviews_Trattoria<-Trattoria$Review
reviews_Yorkshire<-Yorkshire$Review

#Converting all text to lowercase
reviews_Amalfi<-tolower(reviews_Amalfi)
reviews_Baba_Soul<-tolower(reviews_Baba_Soul)
reviews_Blue_Elephant
reviews_Blue_Elephant<-tolower(reviews_Blue_Elephant)
reviews_Blue_Elephant
reviews_Blue_wave<-tolower(reviews_Blue_wave)
reviews_Cafe_101<-tolower(reviews_Cafe_101)
reviews_Catfish_cafe<-tolower(reviews_Catfish_cafe)
reviews_Chez_Nicolas<-tolower(reviews_Chez_Nicolas)
reviews_Fatty<-tolower(reviews_Fatty)
reviews_HardRock<-tolower(reviews_HardRock)
reviews_Kwality_Indian<-tolower(reviews_Kwality_Indian)
reviews_Live_India<-tolower(reviews_Live_India)
reviews_Madras<-tolower(reviews_Madras)
reviews_Mama_Restaurant<-tolower(reviews_Mama_Restaurant)
reviews_Mamasita<-tolower(reviews_Mamasita)
reviews_Modena<-tolower(reviews_Modena)
reviews_Ohlala<-tolower(reviews_Ohlala)
reviews_Orchid<-tolower(reviews_Orchid)
reviews_Outdoor<-tolower(reviews_Outdoor)
reviews_Pomodoro_Pizza<-tolower(reviews_Pomodoro_Pizza)
reviews_Pum_Thai<-tolower(reviews_Pum_Thai)
reviews_Restaurant_Royale<-tolower(reviews_Restaurant_Royale)
reviews_Sabaijai<-tolower(reviews_Sabaijai)
reviews_Salute_Italian<-tolower(reviews_Salute_Italian)
reviews_Shakers<-tolower(reviews_Shakers)
reviews_Siam_Deli<-tolower(reviews_Siam_Deli)
reviews_Skye_lake<-tolower(reviews_Skye_lake)
reviews_Sweet_and_Sour<-tolower(reviews_Sweet_and_Sour)
reviews_Tandoori<-tolower(reviews_Tandoori)
reviews_Trattoria<-tolower(reviews_Trattoria)
reviews_Yorkshire<-tolower(reviews_Yorkshire)

reviews_Amalfi

#Removing any links found in the reviews using the gsub function
reviews_Amalfi <- gsub("http\\S+\\s*", "", reviews_Amalfi)
reviews_Baba_Soul <- gsub("http\\S+\\s*", "", reviews_Baba_Soul)
reviews_Blue_Elephant <- gsub("http\\S+\\s*", "", reviews_Blue_Elephant)
reviews_Blue_wave <- gsub("http\\S+\\s*", "", reviews_Blue_wave)
reviews_Cafe_101 <- gsub("http\\S+\\s*", "", reviews_Cafe_101)
reviews_Catfish_cafe <- gsub("http\\S+\\s*", "", reviews_Catfish_cafe)
reviews_Chez_Nicolas <- gsub("http\\S+\\s*", "", reviews_Chez_Nicolas)
reviews_Fatty <- gsub("http\\S+\\s*", "", reviews_Fatty)
reviews_HardRock <- gsub("http\\S+\\s*", "", reviews_HardRock)
reviews_Kwality_Indian <- gsub("http\\S+\\s*", "", reviews_Kwality_Indian)
reviews_Live_India <- gsub("http\\S+\\s*", "", reviews_Live_India)
reviews_Madras <- gsub("http\\S+\\s*", "", reviews_Madras)
reviews_Mama_Restaurant <- gsub("http\\S+\\s*", "", reviews_Mama_Restaurant)
reviews_Mamasita <- gsub("http\\S+\\s*", "", reviews_Mamasita)
reviews_Modena <- gsub("http\\S+\\s*", "", reviews_Modena)
reviews_Ohlala <- gsub("http\\S+\\s*", "", reviews_Ohlala)
reviews_Orchid <- gsub("http\\S+\\s*", "", reviews_Orchid)
reviews_Outdoor <- gsub("http\\S+\\s*", "", reviews_Outdoor)
reviews_Pomodoro_Pizza <- gsub("http\\S+\\s*", "", reviews_Pomodoro_Pizza)
reviews_Pum_Thai <- gsub("http\\S+\\s*", "", reviews_Pum_Thai)
reviews_Restaurant_Royale <- gsub("http\\S+\\s*", "", reviews_Restaurant_Royale)
reviews_Sabaijai <- gsub("http\\S+\\s*", "", reviews_Sabaijai)
reviews_Salute_Italian <- gsub("http\\S+\\s*", "", reviews_Salute_Italian)
reviews_Shakers <- gsub("http\\S+\\s*", "", reviews_Shakers)
reviews_Siam_Deli <- gsub("http\\S+\\s*", "", reviews_Siam_Deli)
reviews_Skye_lake <- gsub("http\\S+\\s*", "", reviews_Skye_lake)
reviews_Sweet_and_Sour <- gsub("http\\S+\\s*", "", reviews_Sweet_and_Sour)
reviews_Tandoori <- gsub("http\\S+\\s*", "", reviews_Tandoori)
reviews_Trattoria <- gsub("http\\S+\\s*", "", reviews_Trattoria)
reviews_Yorkshire <- gsub("http\\S+\\s*", "", reviews_Yorkshire)

#Removing punctuation from the reviews
reviews_Amalfi <- gsub("[[:punct:]]", "", reviews_Amalfi)
reviews_Baba_Soul <- gsub("[[:punct:]]", "", reviews_Baba_Soul)
reviews_Blue_Elephant <- gsub("[[:punct:]]", "", reviews_Blue_Elephant)
reviews_Blue_wave <- gsub("[[:punct:]]", "", reviews_Blue_wave)
reviews_Cafe_101 <- gsub("[[:punct:]]", "", reviews_Cafe_101)
reviews_Catfish_cafe <- gsub("[[:punct:]]", "", reviews_Catfish_cafe)
reviews_Chez_Nicolas <- gsub("[[:punct:]]", "", reviews_Chez_Nicolas)
reviews_Fatty<- gsub("[[:punct:]]", "", reviews_Fatty)
reviews_HardRock <- gsub("[[:punct:]]", "", reviews_HardRock)
reviews_Kwality_Indian <- gsub("[[:punct:]]", "", reviews_Kwality_Indian)
reviews_Live_India <- gsub("[[:punct:]]", "", reviews_Live_India)
reviews_Madras<- gsub("[[:punct:]]", "", reviews_Madras)
reviews_Mama_Restaurant <- gsub("[[:punct:]]", "", reviews_Mama_Restaurant)
reviews_Mamasita <- gsub("[[:punct:]]", "", reviews_Mamasita)
reviews_Modena <- gsub("[[:punct:]]", "", reviews_Ohlala)
reviews_Ohlala <- gsub("[[:punct:]]", "", reviews_Blue_wave)
reviews_Orchid <- gsub("[[:punct:]]", "", reviews_Orchid)
reviews_Outdoor <- gsub("[[:punct:]]", "", reviews_Outdoor)
reviews_Pomodoro_Pizza <- gsub("[[:punct:]]", "", reviews_Pomodoro_Pizza)
reviews_Pum_Thai<- gsub("[[:punct:]]", "", reviews_Pum_Thai)
reviews_Restaurant_Royale<- gsub("[[:punct:]]", "", reviews_Restaurant_Royale)
reviews_Sabaijai <- gsub("[[:punct:]]", "", reviews_Sabaijai)
reviews_Salute_Italian <- gsub("[[:punct:]]", "", reviews_Salute_Italian)
reviews_Shakers <- gsub("[[:punct:]]", "", reviews_Shakers)
reviews_Siam_Deli<- gsub("[[:punct:]]", "", reviews_Siam_Deli)
reviews_Skye_lake <- gsub("[[:punct:]]", "", reviews_Skye_lake)
reviews_Sweet_and_Sour <- gsub("[[:punct:]]", "", reviews_Sweet_and_Sour)
reviews_Tandoori <- gsub("[[:punct:]]", "", reviews_Tandoori)
reviews_Trattoria <- gsub("[[:punct:]]", "", reviews_Trattoria)
reviews_Yorkshire <- gsub("[[:punct:]]", "", reviews_Yorkshire)

#Removing digits from the reviews
reviews_Amalfi <- gsub("[[:digit:]]", "", reviews_Amalfi)
reviews_Amalfi
reviews_Baba_Soul <- gsub("[[:digit:]]", "", reviews_Baba_Soul)
reviews_Blue_Elephant <- gsub("[[:digit:]]", "", reviews_Blue_Elephant)
reviews_Blue_wave <- gsub("[[:digit:]]", "", reviews_Blue_wave)
reviews_Cafe_101 <- gsub("[[:digit:]]", "", reviews_Cafe_101)
reviews_Catfish_cafe <- gsub("[[:digit:]]", "", reviews_Catfish_cafe)
reviews_Chez_Nicolas <- gsub("[[:digit:]]", "", reviews_Chez_Nicolas)
reviews_Fatty <- gsub("[[:digit:]]", "", reviews_Fatty)
reviews_HardRock <- gsub("[[:digit:]]", "", reviews_HardRock)
reviews_Kwality_Indian <- gsub("[[:digit:]]", "", reviews_Kwality_Indian)
reviews_Live_India <- gsub("[[:digit:]]", "", reviews_Live_India)
reviews_Madras <- gsub("[[:digit:]]", "", reviews_Madras)
reviews_Mama_Restaurant <- gsub("[[:digit:]]", "", reviews_Mama_Restaurant)
reviews_Mamasita <- gsub("[[:digit:]]", "", reviews_Mamasita)
reviews_Modena <- gsub("[[:digit:]]", "", reviews_Modena)
reviews_Ohlala <- gsub("[[:digit:]]", "", reviews_Ohlala)
reviews_Orchid <- gsub("[[:digit:]]", "", reviews_Orchid)
reviews_Outdoor <- gsub("[[:digit:]]", "", reviews_Outdoor)
reviews_Pomodoro_Pizza <- gsub("[[:digit:]]", "", reviews_Pomodoro_Pizza)
reviews_Pum_Thai <- gsub("[[:digit:]]", "", reviews_Pum_Thai)
reviews_Restaurant_Royale <- gsub("[[:digit:]]", "", reviews_Restaurant_Royale)
reviews_Sabaijai <- gsub("[[:digit:]]", "", reviews_Sabaijai)
reviews_Salute_Italian <- gsub("[[:digit:]]", "", reviews_Salute_Italian)
reviews_Shakers <- gsub("[[:digit:]]", "", reviews_Shakers)
reviews_Siam_Deli <- gsub("[[:digit:]]", "", reviews_Siam_Deli)
reviews_Skye_lake <- gsub("[[:digit:]]", "", reviews_Skye_lake)
reviews_Sweet_and_Sour <- gsub("[[:digit:]]", "", reviews_Sweet_and_Sour)
reviews_Tandoori<- gsub("[[:digit:]]", "", reviews_Tandoori)
reviews_Trattoria <- gsub("[[:digit:]]", "", reviews_Trattoria)
reviews_Yorkshire <- gsub("[[:digit:]]", "", reviews_Yorkshire)

#Remove leading blank spaces at the beginning from the reviews
reviews_Amalfi <- gsub("^ ", "", reviews_Amalfi)
reviews_Baba_Soul <- gsub("^ ", "", reviews_Baba_Soul)
reviews_Blue_Elephant <- gsub("^ ", "", reviews_Blue_Elephant)
reviews_Blue_wave <- gsub("^ ", "", reviews_Blue_wave)
reviews_Cafe_101 <- gsub("^ ", "", reviews_Cafe_101)
reviews_Catfish_cafe <- gsub("^ ", "", reviews_Catfish_cafe)
reviews_Chez_Nicolas<- gsub("^ ", "", reviews_Chez_Nicolas)
reviews_Fatty <- gsub("^ ", "", reviews_Fatty)
reviews_HardRock <- gsub("^ ", "", reviews_HardRock)
reviews_Kwality_Indian <- gsub("^ ", "", reviews_Kwality_Indian)
reviews_Live_India<- gsub("^ ", "", reviews_Live_India)
reviews_Madras<- gsub("^ ", "", reviews_Madras)
reviews_Mama_Restaurant <- gsub("^ ", "", reviews_Mama_Restaurant)
reviews_Mamasita <- gsub("^ ", "", reviews_Mamasita)
reviews_Modena <- gsub("^ ", "", reviews_Modena)
reviews_Ohlala <- gsub("^ ", "", reviews_Ohlala)
reviews_Orchid <- gsub("^ ", "", reviews_Orchid)
reviews_Outdoor <- gsub("^ ", "", reviews_Outdoor)
reviews_Pomodoro_Pizza <- gsub("^ ", "", reviews_Pomodoro_Pizza)
reviews_Pum_Thai <- gsub("^ ", "", reviews_Pum_Thai)
reviews_Restaurant_Royale <- gsub("^ ", "", reviews_Restaurant_Royale)
reviews_Sabaijai <- gsub("^ ", "", reviews_Sabaijai)
reviews_Salute_Italian <- gsub("^ ", "", reviews_Salute_Italian)
reviews_Shakers <- gsub("^ ", "", reviews_Shakers)
reviews_Siam_Deli <- gsub("^ ", "", reviews_Siam_Deli)
reviews_Skye_lake <- gsub("^ ", "", reviews_Skye_lake)
reviews_Sweet_and_Sour <- gsub("^ ", "", reviews_Sweet_and_Sour)
reviews_Tandoori <- gsub("^ ", "", reviews_Tandoori)
reviews_Trattoria <- gsub("^ ", "", reviews_Trattoria)
reviews_Yorkshire <- gsub("^ ", "", reviews_Yorkshire)

#Remove blank spaces at the end from the reviews
reviews_Amalfi <- gsub(" $", "", reviews_Amalfi)
reviews_Baba_Soul <- gsub(" $", "", reviews_Baba_Soul)
reviews_Blue_Elephant <- gsub(" $", "", reviews_Blue_Elephant)
reviews_Blue_wave <- gsub(" $", "", reviews_Blue_wave)
reviews_Cafe_101 <- gsub(" $", "", reviews_Cafe_101)
reviews_Catfish_cafe <- gsub(" $", "", reviews_Catfish_cafe)
reviews_Chez_Nicolas <- gsub(" $", "", reviews_Chez_Nicolas)
reviews_Fatty<- gsub(" $", "", reviews_Fatty)
reviews_HardRock <- gsub(" $", "", reviews_HardRock)
reviews_Kwality_Indian <- gsub(" $", "", reviews_Kwality_Indian)
reviews_Live_India <- gsub(" $", "", reviews_Live_India)
reviews_Madras <- gsub(" $", "", reviews_Madras)
reviews_Mama_Restaurant <- gsub(" $", "", reviews_Mama_Restaurant)
reviews_Mamasita <- gsub(" $", "", reviews_Mamasita)
reviews_Modena <- gsub(" $", "", reviews_Modena)
reviews_Ohlala <- gsub(" $", "", reviews_Ohlala)
reviews_Orchid <- gsub(" $", "", reviews_Orchid)
reviews_Outdoor <- gsub(" $", "", reviews_Outdoor)
reviews_Pomodoro_Pizza <- gsub(" $", "", reviews_Pomodoro_Pizza)
reviews_Pum_Thai <- gsub(" $", "", reviews_Pum_Thai)
reviews_Restaurant_Royale <- gsub(" $", "", reviews_Restaurant_Royale)
reviews_Sabaijai <- gsub(" $", "", reviews_Sabaijai)
reviews_Salute_Italian <- gsub(" $", "", reviews_Salute_Italian)
reviews_Shakers <- gsub(" $", "", reviews_Shakers)
reviews_Siam_Deli <- gsub(" $", "", reviews_Siam_Deli)
reviews_Skye_lake <- gsub(" $", "", reviews_Skye_lake)
reviews_Sweet_and_Sour <- gsub(" $", "", reviews_Sweet_and_Sour)
reviews_Tandoori <- gsub(" $", "", reviews_Tandoori)
reviews_Trattoria <- gsub(" $", "", reviews_Trattoria)
reviews_Yorkshire <- gsub(" $", "", reviews_Yorkshire)

reviews_Amalfi
reviews_HardRock

#Removing two words from the reviews -  "restaurant" and "food"
reviews_Amalfi <- gsub("restaurant", "", reviews_Amalfi)
reviews_Amalfi <- gsub("food", "", reviews_Amalfi)
reviews_Amalfi
reviews_Baba_Soul <- gsub("restaurant", "", reviews_Baba_Soul)
reviews_Baba_Soul <- gsub("food", "", reviews_Baba_Soul)
reviews_Blue_Elephant <- gsub("restaurant", "", reviews_Blue_Elephant)
reviews_Blue_Elephant <- gsub("food", "", reviews_Blue_Elephant)
reviews_Blue_wave <- gsub("restaurant", "", reviews_Blue_wave)
reviews_Blue_wave <- gsub("food", "", reviews_Blue_wave)
reviews_Cafe_101 <- gsub("restaurant", "", reviews_Cafe_101)
reviews_Cafe_101 <- gsub("food", "", reviews_Cafe_101)
reviews_Catfish_cafe <- gsub("restaurant", "", reviews_Catfish_cafe)
reviews_Catfish_cafe <- gsub("food", "", reviews_Catfish_cafe)
reviews_Chez_Nicolas <- gsub("restaurant", "", reviews_Chez_Nicolas)
reviews_Chez_Nicolas <- gsub("food", "", reviews_Chez_Nicolas)
reviews_Fatty <- gsub("restaurant", "", reviews_Fatty)
reviews_Fatty <- gsub("food", "", reviews_Fatty)
reviews_HardRock <- gsub("restaurant", "", reviews_HardRock)
reviews_HardRock <- gsub("food", "", reviews_HardRock)
reviews_Kwality_Indian <- gsub("restaurant", "", reviews_Kwality_Indian)
reviews_Kwality_Indian <- gsub("food", "", reviews_Kwality_Indian)
reviews_Live_India <- gsub("restaurant", "", reviews_Live_India)
reviews_Live_India <- gsub("food", "", reviews_Live_India)
reviews_Madras <- gsub("restaurant", "", reviews_Madras)
reviews_Madras <- gsub("food", "", reviews_Madras)
reviews_Mama_Restaurant <- gsub("restaurant", "", reviews_Mama_Restaurant)
reviews_Mama_Restaurant <- gsub("food", "", reviews_Mama_Restaurant)
reviews_Mamasita <- gsub("restaurant", "", reviews_Mamasita)
reviews_Mamasita <- gsub("food", "", reviews_Mamasita)
reviews_Modena <- gsub("restaurant", "", reviews_Modena)
reviews_Modena <- gsub("food", "", reviews_Modena)
reviews_Ohlala <- gsub("restaurant", "", reviews_Ohlala)
reviews_Ohlala <- gsub("food", "", reviews_Ohlala)
reviews_Orchid <- gsub("restaurant", "", reviews_Orchid)
reviews_Orchid <- gsub("food", "", reviews_Orchid)
reviews_Outdoor <- gsub("restaurant", "", reviews_Outdoor)
reviews_Outdoor <- gsub("food", "", reviews_Outdoor)
reviews_Pomodoro_Pizza <- gsub("restaurant", "", reviews_Pomodoro_Pizza)
reviews_Pomodoro_Pizza <- gsub("food", "", reviews_Pomodoro_Pizza)
reviews_Pum_Thai <- gsub("restaurant", "", reviews_Pum_Thai)
reviews_Pum_Thai <- gsub("food", "", reviews_Pum_Thai)
reviews_Restaurant_Royale <- gsub("restaurant", "", reviews_Restaurant_Royale)
reviews_Restaurant_Royale <- gsub("food", "", reviews_Restaurant_Royale)
reviews_Sabaijai <- gsub("restaurant", "", reviews_Sabaijai)
reviews_Sabaijai <- gsub("food", "", reviews_Sabaijai)
reviews_Salute_Italian <- gsub("restaurant", "", reviews_Salute_Italian)
reviews_Salute_Italian <- gsub("food", "", reviews_Salute_Italian)
reviews_Shakers <- gsub("restaurant", "", reviews_Shakers)
reviews_Shakers <- gsub("food", "", reviews_Shakers)
reviews_Siam_Deli <- gsub("restaurant", "", reviews_Siam_Deli)
reviews_Siam_Deli <- gsub("food", "", reviews_Siam_Deli)
reviews_Skye_lake <- gsub("restaurant", "", reviews_Skye_lake)
reviews_Skye_lake <- gsub("food", "", reviews_Skye_lake)
reviews_Sweet_and_Sour <- gsub("restaurant", "", reviews_Sweet_and_Sour)
reviews_Sweet_and_Sour <- gsub("food", "", reviews_Sweet_and_Sour)
reviews_Tandoori <- gsub("restaurant", "", reviews_Tandoori)
reviews_Tandoori <- gsub("food", "", reviews_Tandoori)
reviews_Trattoria <- gsub("restaurant", "", reviews_Trattoria)
reviews_Trattoria <- gsub("food", "", reviews_Trattoria)
reviews_Yorkshire <- gsub("restaurant", "", reviews_Yorkshire)
reviews_Yorkshire <- gsub("food", "", reviews_Yorkshire)

#Inspecting the vectors after cleaning
head(reviews_Amalfi)
head(reviews_Baba_Soul)
head(reviews_Blue_Elephant)
head(reviews_Blue_wave)
head(reviews_Cafe_101)
head(reviews_Catfish_cafe)

# Transformation and cleaning up of corpus ----
#Converting the text vectors to corpus

corpus_Amalfi <- Corpus(VectorSource(reviews_Amalfi))
corpus_Baba_Soul <- Corpus(VectorSource(reviews_Baba_Soul))
corpus_Blue_Elephant <- Corpus(VectorSource(reviews_Blue_Elephant))
corpus_Blue_wave <- Corpus(VectorSource(reviews_Blue_wave))
corpus_Cafe_101 <- Corpus(VectorSource(reviews_Cafe_101))
corpus_Catfish_cafe <- Corpus(VectorSource(reviews_Catfish_cafe))
corpus_Chez_Nicolas <- Corpus(VectorSource(reviews_Chez_Nicolas))
corpus_Fatty <- Corpus(VectorSource(reviews_Fatty))
corpus_HardRock <- Corpus(VectorSource(reviews_HardRock))
corpus_Kwality_Indian <- Corpus(VectorSource(reviews_Kwality_Indian))
corpus_Live_India <- Corpus(VectorSource(reviews_Live_India))
corpus_Madras <- Corpus(VectorSource(reviews_Madras))
corpus_Mama_Restaurant <- Corpus(VectorSource(reviews_Mama_Restaurant))
corpus_Mamasita <- Corpus(VectorSource(reviews_Mamasita))
corpus_Modena <- Corpus(VectorSource(reviews_Modena))
corpus_Ohlala <- Corpus(VectorSource(reviews_Ohlala))
corpus_Orchid <- Corpus(VectorSource(reviews_Orchid))
corpus_Outdoor <- Corpus(VectorSource(reviews_Outdoor))
corpus_Pomodoro_Pizza <- Corpus(VectorSource(reviews_Pomodoro_Pizza))
corpus_Pum_Thai <- Corpus(VectorSource(reviews_Pum_Thai))
corpus_Restaurant_Royale <- Corpus(VectorSource(reviews_Restaurant_Royale))
corpus_Sabaijai <- Corpus(VectorSource(reviews_Sabaijai))
corpus_Salute_Italian <- Corpus(VectorSource(reviews_Salute_Italian))
corpus_Shakers<- Corpus(VectorSource(reviews_Shakers))
corpus_Siam_Deli <- Corpus(VectorSource(reviews_Siam_Deli))
corpus_Skye_lake <- Corpus(VectorSource(reviews_Skye_lake))
corpus_Sweet_and_Sour <- Corpus(VectorSource(reviews_Sweet_and_Sour))
corpus_Tandoori<- Corpus(VectorSource(reviews_Tandoori))
corpus_Trattoria <- Corpus(VectorSource(reviews_Trattoria))
corpus_Yorkshire<- Corpus(VectorSource(reviews_Yorkshire))

#Clean up corpus by removing stop words and Whitespace

corpus_Amalfi <- tm_map(corpus_Amalfi, removeWords,stopwords("english"))
corpus_Amalfi <- tm_map(corpus_Amalfi, stripWhitespace)
inspect(corpus_Amalfi)

corpus_Baba_Soul <- tm_map(corpus_Baba_Soul, removeWords,stopwords("english"))
corpus_Baba_Soul <- tm_map(corpus_Baba_Soul, stripWhitespace)
inspect(corpus_Baba_Soul)

corpus_Blue_Elephant <- tm_map(corpus_Blue_Elephant, removeWords,stopwords("english"))
corpus_Blue_Elephant <- tm_map(corpus_Blue_Elephant, stripWhitespace)
inspect(corpus_Blue_Elephant)

corpus_Blue_wave <- tm_map(corpus_Blue_wave, removeWords,stopwords("english"))
corpus_Blue_wave <- tm_map(corpus_Blue_wave, stripWhitespace)
inspect(corpus_Blue_wave)

corpus_Cafe_101 <- tm_map(corpus_Cafe_101, removeWords,stopwords("english"))
corpus_Cafe_101 <- tm_map(corpus_Cafe_101, stripWhitespace)
inspect(corpus_Cafe_101)

corpus_Catfish_cafe <- tm_map(corpus_Catfish_cafe, removeWords,stopwords("english"))
corpus_Catfish_cafe <- tm_map(corpus_Catfish_cafe, stripWhitespace)
inspect(corpus_Catfish_cafe)

corpus_Chez_Nicolas <- tm_map(corpus_Chez_Nicolas, removeWords,stopwords("english"))
corpus_Chez_Nicolas <- tm_map(corpus_Chez_Nicolas, stripWhitespace)
inspect(corpus_Chez_Nicolas)

corpus_Fatty <- tm_map(corpus_Fatty, removeWords,stopwords("english"))
corpus_Fatty <- tm_map(corpus_Fatty, stripWhitespace)
inspect(corpus_Fatty)

corpus_HardRock <- tm_map(corpus_HardRock, removeWords,stopwords("english"))
corpus_HardRock <- tm_map(corpus_HardRock, stripWhitespace)
inspect(corpus_HardRock)

corpus_Kwality_Indian <- tm_map(corpus_Kwality_Indian, removeWords,stopwords("english"))
corpus_Kwality_Indian <- tm_map(corpus_Kwality_Indian, stripWhitespace)
inspect(corpus_Kwality_Indian)

corpus_Live_India <- tm_map(corpus_Live_India, removeWords,stopwords("english"))
corpus_Live_India <- tm_map(corpus_Live_India, stripWhitespace)
inspect(corpus_Live_India)

corpus_Madras <- tm_map(corpus_Madras, removeWords,stopwords("english"))
corpus_Madras <- tm_map(corpus_Madras, stripWhitespace)
inspect(corpus_Madras)

corpus_Mama_Restaurant <- tm_map(corpus_Mama_Restaurant, removeWords,stopwords("english"))
corpus_Mama_Restaurant <- tm_map(corpus_Mama_Restaurant, stripWhitespace)
inspect(corpus_Mama_Restaurant)

corpus_Mamasita <- tm_map(corpus_Mamasita, removeWords,stopwords("english"))
corpus_Mamasita <- tm_map(corpus_Mamasita, stripWhitespace)
inspect(corpus_Mamasita)

corpus_Modena <- tm_map(corpus_Modena, removeWords,stopwords("english"))
corpus_Modena <- tm_map(corpus_Modena, stripWhitespace)
inspect(corpus_Modena)


corpus_Ohlala <- tm_map(corpus_Ohlala, removeWords,stopwords("english"))
corpus_Ohlala <- tm_map(corpus_Ohlala, stripWhitespace)
inspect(corpus_Ohlala)

corpus_Orchid <- tm_map(corpus_Orchid, removeWords,stopwords("english"))
corpus_Orchid <- tm_map(corpus_Orchid, stripWhitespace)
inspect(corpus_Orchid)

corpus_Outdoor <- tm_map(corpus_Outdoor, removeWords,stopwords("english"))
corpus_Outdoor <- tm_map(corpus_Outdoor, stripWhitespace)
inspect(corpus_Outdoor)

corpus_Pomodoro_Pizza <- tm_map(corpus_Pomodoro_Pizza, removeWords,stopwords("english"))
corpus_Pomodoro_Pizza <- tm_map(corpus_Pomodoro_Pizza, stripWhitespace)
inspect(corpus_Pomodoro_Pizza)

corpus_Pum_Thai <- tm_map(corpus_Pum_Thai, removeWords,stopwords("english"))
corpus_Pum_Thai <- tm_map(corpus_Pum_Thai, stripWhitespace)
inspect(corpus_Pum_Thai)

corpus_Restaurant_Royale <- tm_map(corpus_Restaurant_Royale, removeWords,stopwords("english"))
corpus_Restaurant_Royale <- tm_map(corpus_Restaurant_Royale, stripWhitespace)
inspect(corpus_Restaurant_Royale)

corpus_Sabaijai <- tm_map(corpus_Sabaijai, removeWords,stopwords("english"))
corpus_Sabaijai <- tm_map(corpus_Sabaijai, stripWhitespace)
inspect(corpus_Sabaijai)

corpus_Salute_Italian <- tm_map(corpus_Salute_Italian, removeWords,stopwords("english"))
corpus_Salute_Italian <- tm_map(corpus_Salute_Italian, stripWhitespace)
inspect(corpus_Salute_Italian)

corpus_Shakers <- tm_map(corpus_Shakers, removeWords,stopwords("english"))
corpus_Shakers <- tm_map(corpus_Shakers, stripWhitespace)
inspect(corpus_Shakers)

corpus_Siam_Deli <- tm_map(corpus_Siam_Deli, removeWords,stopwords("english"))
corpus_Siam_Deli <- tm_map(corpus_Siam_Deli, stripWhitespace)
inspect(corpus_Siam_Deli)

corpus_Skye_lake <- tm_map(corpus_Skye_lake, removeWords,stopwords("english"))
corpus_Skye_lake <- tm_map(corpus_Skye_lake, stripWhitespace)
inspect(corpus_Skye_lake)

corpus_Sweet_and_Sour <- tm_map(corpus_Sweet_and_Sour, removeWords,stopwords("english"))
corpus_Sweet_and_Sour <- tm_map(corpus_Sweet_and_Sour, stripWhitespace)
inspect(corpus_Sweet_and_Sour)

corpus_Tandoori <- tm_map(corpus_Tandoori, removeWords,stopwords("english"))
corpus_Tandoori <- tm_map(corpus_Tandoori, stripWhitespace)
inspect(corpus_Tandoori)

corpus_Trattoria <- tm_map(corpus_Trattoria, removeWords,stopwords("english"))
corpus_Trattoria <- tm_map(corpus_Trattoria, stripWhitespace)
inspect(corpus_Trattoria)

corpus_Yorkshire <- tm_map(corpus_Yorkshire, removeWords,stopwords("english"))
corpus_Yorkshire <- tm_map(corpus_Yorkshire, stripWhitespace)
inspect(corpus_Yorkshire)

inspect(corpus_Blue_Elephant)


install.packages("SnowballC")
library(SnowballC)

#Stemming the words to their root of all reviews present in the corpus

stem_corpus_Amalfi<- tm_map(corpus_Amalfi, stemDocument)
stem_corpus_Baba_Soul<- tm_map(corpus_Baba_Soul, stemDocument)
stem_corpus_Blue_Elephant<- tm_map(corpus_Blue_Elephant, stemDocument)
stem_corpus_Blue_wave<- tm_map(corpus_Blue_wave, stemDocument)
stem_corpus_Cafe_101<- tm_map(corpus_Cafe_101, stemDocument)
stem_corpus_catfish<- tm_map(corpus_Catfish_cafe, stemDocument)
stem_corpus_Chez_Nicolas<- tm_map(corpus_Chez_Nicolas, stemDocument)
stem_corpus_Fatty<- tm_map(corpus_Fatty, stemDocument)
stem_corpus_Hardrock<- tm_map(corpus_HardRock, stemDocument)
stem_corpus_Kwality_Indian<- tm_map(corpus_Kwality_Indian, stemDocument)
stem_corpus_Live_India<- tm_map(corpus_Live_India, stemDocument)
stem_corpus_Madras<- tm_map(corpus_Madras, stemDocument)
stem_corpus_Mama_Restaurant<- tm_map(corpus_Mama_Restaurant, stemDocument)
stem_corpus_Mamasita<- tm_map(corpus_Mamasita, stemDocument)
stem_corpus_Modena<- tm_map(corpus_Modena, stemDocument)
stem_corpus_Ohlala<- tm_map(corpus_Ohlala, stemDocument)
stem_corpus_orchid<- tm_map(corpus_Orchid, stemDocument)
stem_corpus_Outdoor<- tm_map(corpus_Outdoor, stemDocument)
stem_corpus_pomodoro_pizza<- tm_map(corpus_Pomodoro_Pizza, stemDocument)
stem_corpus_Pum_Thai<- tm_map(corpus_Pum_Thai, stemDocument)
stem_corpus_Restaurant_Royale<- tm_map(corpus_Restaurant_Royale, stemDocument)
stem_corpus_Sabaijai<- tm_map(corpus_Sabaijai, stemDocument)
stem_corpus_Salute_Italian<- tm_map(corpus_Salute_Italian, stemDocument)
stem_corpus_Shakers<- tm_map(corpus_Shakers, stemDocument)
stem_corpus_Siam_Deli<- tm_map(corpus_Siam_Deli, stemDocument)
stem_corpus_Skye_Lake<- tm_map(corpus_Skye_lake, stemDocument)
stem_corpus_sweet_and_sour<- tm_map(corpus_Sweet_and_Sour, stemDocument)
stem_corpus_Tandoori<- tm_map(corpus_Tandoori, stemDocument)
stem_corpus_Trattoria<- tm_map(corpus_Trattoria, stemDocument)
stem_corpus_Yorkshire<- tm_map(corpus_Yorkshire, stemDocument)

# Loading the positive and negative lexicon data for the Sentiment Analysis Function
positive_lexicon <- read.csv("positive-lexicon.txt")
negative_lexicon <- read.csv("negative-lexicon.txt")


#Inspect Lexicons

head(positive_lexicon)
tail(positive_lexicon)

head(negative_lexicon)
tail(negative_lexicon)



  sentiment <- function(stem_corpus) 
  {
    #generate wordclouds
    wordcloud(stem_corpus, scale=c(3,0.4), max.words=200, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Paired"))
    
#Calculating the count of total positive and negative words in each review 
    
 #Create variables and vectors
    total_pos_count <- 0
    total_neg_count <- 0
    pos_count_vector <- c()
    neg_count_vector <- c()
    #Calculate the size of the corpus
    size <- length(stem_corpus)
    for(i in 1:size)
    {
 #All the words in current review
 corpus_words<- list(strsplit(stem_corpus[[i]]$content, split = " "))
#positive words in current review
pos_count <-length(intersect(unlist(corpus_words), unlist(positive_lexicon)))
#negative words in current review 
neg_count <- length(intersect(unlist(corpus_words), unlist(negative_lexicon)))

total_pos_count <- total_pos_count + pos_count ## overall positive count
total_neg_count <- total_neg_count + neg_count ## overall negative count

    }
    #Calculating overall percentage of positive and negative words of all the reviews
    total_pos_count ## overall positive count
    total_neg_count ## overall negative count
    total_count <- total_pos_count + total_neg_count
    overall_positive_percentage <- (total_pos_count*100)/total_count
    overall_negative_percentage <- (total_neg_count*100)/total_count
    overall_positive_percentage ## overall positive percentage
    #Create a dataframe with all the positive and negative reviews 
    df<-data.frame(Review_Type=c("Postive","Negitive"),
                   Count=c(total_pos_count ,total_neg_count ))
    print(df) #Print
    overall_positive_percentage<-paste("Percentage of Positive Reviews:",
                                       round(overall_positive_percentage,2),"%")
    return(overall_positive_percentage)
  }

sentiment(stem_corpus_Amalfi)
sentiment(stem_corpus_Baba_Soul)
wordcloud(stem_corpus_Baba_Soul, scale=c(4,0.4), max.words=200, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Paired"))
sentiment(stem_corpus_Blue_Elephant)
wordcloud(stem_corpus_Blue_Elephant, scale=c(2,0.4), max.words=200, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Paired"))
sentiment(stem_corpus_Blue_wave)
sentiment(stem_corpus_Cafe_101)
sentiment(stem_corpus_catfish)
sentiment(stem_corpus_Chez_Nicolas)
wordcloud(stem_corpus_Chez_Nicolas, scale=c(2,0.4), max.words=200, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Paired"))
sentiment(stem_corpus_Fatty)
sentiment(stem_corpus_Hardrock)
sentiment(stem_corpus_Kwality_Indian)
sentiment(stem_corpus_Live_India)
sentiment(stem_corpus_Madras)
wordcloud(stem_corpus_Madras, scale=c(3,0.5), max.words=200, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Paired"))
sentiment(stem_corpus_Mama_Restaurant)
sentiment(stem_corpus_Mamasita)
sentiment(stem_corpus_Modena)
sentiment(stem_corpus_Ohlala)
sentiment(stem_corpus_orchid)
wordcloud(stem_corpus_orchid, scale=c(2.5,0.5), max.words=200, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Paired"))
sentiment(stem_corpus_Outdoor)
sentiment(stem_corpus_pomodoro_pizza)
sentiment(stem_corpus_Pum_Thai)
sentiment(stem_corpus_Restaurant_Royale)
wordcloud(stem_corpus_Restaurant_Royale, scale=c(2,0.4), max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Paired"))
sentiment(stem_corpus_Outdoor)
sentiment(stem_corpus_Sabaijai)
sentiment(stem_corpus_Salute_Italian)
sentiment(stem_corpus_Shakers)
sentiment(stem_corpus_Siam_Deli)
sentiment(stem_corpus_Skye_Lake)
sentiment(stem_corpus_sweet_and_sour)
sentiment(stem_corpus_Tandoori)
sentiment(stem_corpus_Trattoria)
sentiment(stem_corpus_Yorkshire)


