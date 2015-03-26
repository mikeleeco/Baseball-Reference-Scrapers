# This scraper builds off the MiLB_Scraper_Batting.R repository by using the baseball-reference minor league reference id URL to scrape each player's major league reference id from their B-R profile. Scrape those files first, then return here to scrape the playerID info.

#WARNING: this scrapes from individual player pages and can take a very long time with a large player pool

# install.packages("devtools")
# install_github("hadley/rvest")
c('rvest','dplyr','pipeR') -> packages #installs packages
lapply(packages, library, character.only = T) #installs packages

url <- "http://www.baseball-reference.com/minors/player.cgi?id="
minors_player <- data.frame()

for (min_bref in min_bref){
    html <- html(paste(url,min_bref,sep=""))
    
    html %>%
        html_nodes(".no_mobile a") %>%  
        html_attr("href") %>>% unlist %>>% as.character -> maj_playerid
    
    min_playerid <- c(min_bref)
    maj_playerid=paste(maj_playerid,"")
    df=cbind(min_playerid,maj_playerid)
    
    
    minors_player <- rbind(minors_player,df)
    
}

minors_player=filter(minors_player, !grepl('japan/', maj_playerid)) #remove japanese league info
minors_player$maj_playerid <- gsub(".shtml","",minors_player$maj_playerid)
minors_player$maj_playerid=substring(minors_player$maj_playerid, 12)
minors_player$maj_playerid=str_trim(minors_player$maj_playerid)
View(minors_player)
