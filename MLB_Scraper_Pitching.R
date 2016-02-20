c('rvest','dplyr','pipeR') -> packages #installs packages
lapply(packages, library, character.only = T) #installs packages
url <- "http://www.baseball-reference.com/teams/"
teams=c("ARI","ATL","BAL","BOS","CHC","CHW","CIN","CLE","COL","DET","HOU","KCR","LAD","MIA","MIL","MIN","NYM","NYY","OAK","PHI","PIT","SDP","SFG","SEA","STL","TEX","TOR","TBR")
stats_table <- '#team_pitching'
stats_id <- paste0(stats_table,' a')
majors_pitching <- data.frame()

for (teams in teams){ 
    for (season in 2015:2000) {
        html <- paste(url,teams,"/",season,".shtml",sep="")

        read_html(html) %>%
            html_nodes(stats_table) %>%
            html_table(header = T) %>%
            data.frame() %>%
            tbl_df() -> df

        read_html(html) %>%
            html_nodes(stats_id) %>%
            html_attr(name="href") %>% unlist %>% as.character -> maj_playerid

        rows <- nrow(df)-3
        df <- df[1:rows,]
        df <- df[!na.omit(df$Rk=='Rk'),]
        df$season <- season
        df$teams <- teams
        df$level <- "MLB"

        maj_playerid <- gsub(".shtml","",maj_playerid)
        maj_playerid=substring(maj_playerid, 12)
        df$maj_playerid <- c(maj_playerid)
        
        majors_pitching <- rbind(majors_pitching,df)
    }
}

teams=c("TBD")
stats_table <- '#team_pitching'
stats_id <- paste0(stats_table,' a')
majors_pitching_tam <- data.frame()

for (teams in teams){ 
    for (season in 2007:2000) {
        html <- paste(url,teams,"/",season,".shtml",sep="")

        read_html(html) %>%
            html_nodes(stats_table) %>%
            html_table(header = T) %>%
            data.frame() %>%
            tbl_df() -> df

        read_html(html) %>%
            html_nodes(stats_id) %>%
            html_attr(name="href") %>% unlist %>% as.character -> maj_playerid

        rows <- nrow(df)-3
        df <- df[1:rows,]
        df <- df[!na.omit(df$Rk=='Rk'),]
        df$season <- season
        df$teams <- teams
        df$level <- "MLB"

        maj_playerid <- gsub(".shtml","",maj_playerid)
        maj_playerid=substring(maj_playerid, 12)
        df$maj_playerid <- c(maj_playerid)
        
        majors_pitching_tam <- rbind(majors_pitching_tam,df)
    }
}


teams=c("WSN","LAA")
stats_table <- '#team_pitching'
stats_id <- paste0(stats_table,' a')
majors_pitching_new <- data.frame()

for (teams in teams){ 
    for (season in 2014:2005) {
        html <- paste(url,teams,"/",season,".shtml",sep="")

        read_html(html) %>%
            html_nodes(stats_table) %>%
            html_table(header = T) %>%
            data.frame() %>%
            tbl_df() -> df

        read_html(html) %>%
            html_nodes(stats_id) %>%
            html_attr(name="href") %>% unlist %>% as.character -> maj_playerid

        rows <- nrow(df)-3
        df <- df[1:rows,]
        df <- df[!na.omit(df$Rk=='Rk'),]
        df$season <- season
        df$teams <- teams
        df$level <- "MLB"

        maj_playerid <- gsub(".shtml","",maj_playerid)
        maj_playerid=substring(maj_playerid, 12)
        df$maj_playerid <- c(maj_playerid)
        
        majors_pitching_new <- rbind(majors_pitching_new,df)
    }
}

teams=c("MON","ANA")
stats_table <- '#team_pitching'
stats_id <- paste0(stats_table,' a')
majors_pitching_extra <- data.frame()

for (teams in teams){ 
    for (season in 2004:2000) {
        html <- paste(url,teams,"/",season,".shtml",sep="")

        read_html(html) %>%
            html_nodes(stats_table) %>%
            html_table(header = T) %>%
            data.frame() %>%
            tbl_df() -> df

        read_html(html) %>%
            html_nodes(stats_id) %>%
            html_attr(name="href") %>% unlist %>% as.character -> maj_playerid

        rows <- nrow(df)-3
        df <- df[1:rows,]
        df <- df[!na.omit(df$Rk=='Rk'),]
        df$season <- season
        df$teams <- teams
        df$level <- "MLB"

        maj_playerid <- gsub(".shtml","",maj_playerid)
        maj_playerid=substring(maj_playerid, 12)
        df$maj_playerid <- c(maj_playerid)
        
        majors_pitching_extra <- rbind(majors_pitching_extra,df)
    }
}

majors_pitching=rbind(majors_pitching,majors_pitching_tam,majors_pitching_new,majors_pitching_extra)
rm(majors_pitching_tam,majors_pitching_new,majors_pitching_extra)
