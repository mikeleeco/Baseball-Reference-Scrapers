c('rvest','dplyr','pipeR') -> packages #installs packages
lapply(packages, library, character.only = T) #installs packages
url <- "http://www.baseball-reference.com/teams/"
teams=c("ARI","ATL","BAL","BOS","CHC","CHW","CIN","CLE","COL","DET","HOU","KCR","LAD","MIA","MIL","MIN","NYM","NYY","OAK","PHI","PIT","SDP","SFG","SEA","STL","TEX","TOR","TBR")
'#team_pitching' -> stats_table
stats_table %>>% paste0(stats_table,' a') -> stats_id
majors_pitching <- data.frame()

for (teams in teams){ for (season in 2014:2000) {
html <- paste(url,teams,"/",season,".shtml",sep="")

html(html) %>%
	html_nodes(stats_table) %>%
	html_table(header = T) %>%
	data.frame() %>%
	tbl_df() -> df

html(html) %>>%
        html_nodes(stats_id) %>>%
        html_attr(name="href") %>>% unlist %>>% as.character -> maj_playerid
df %>>% nrow()-5  -> rows
    df[1:rows,] -> df
df=df[!na.omit(df$Rk=='Rk'),]
df$season <- c(season)
df$Tm <- c(teams)
df$Lev=c("MLB")
maj_playerid <- gsub(".shtml","",maj_playerid)
maj_playerid=substring(maj_playerid, 12)
df$maj_playerid <- c(maj_playerid)

majors_pitching <- rbind(majors_pitching,df)

}
}

teams=c("TBD")
'#team_pitching' -> stats_table
stats_table %>>% paste0(stats_table,' a') -> stats_id
majors_pitching_tam <- data.frame()

for (teams in teams){ for (season in 2007:2000) {
    html <- paste(url,teams,"/",season,".shtml",sep="")
    
    html(html) %>%
        html_nodes(stats_table) %>%
        html_table(header = T) %>%
        data.frame() %>%
        tbl_df() -> df
    
    html(html) %>>%
        html_nodes(stats_id) %>>%
        html_attr(name="href") %>>% unlist %>>% as.character -> maj_playerid
    df %>>% nrow()-5  -> rows
    df[1:rows,] -> df
    df=df[!na.omit(df$Rk=='Rk'),]
    df$season <- c(season)
    df$Tm <- c(teams)
    df$Lev=c("MLB")
    maj_playerid <- gsub(".shtml","",maj_playerid)
    maj_playerid=substring(maj_playerid, 12)
    df$maj_playerid <- c(maj_playerid)
    
    majors_pitching_tam <- rbind(majors_pitching_tam,df)
    
}
}


teams=c("WSN","LAA")
'#team_pitching' -> stats_table
stats_table %>>% paste0(stats_table,' a') -> stats_id
majors_pitching_new <- data.frame()

for (teams in teams){ for (season in 2014:2005) {
    html <- paste(url,teams,"/",season,".shtml",sep="")
    
    html(html) %>%
        html_nodes(stats_table) %>%
        html_table(header = T) %>%
        data.frame() %>%
        tbl_df() -> df
    
    html(html) %>>%
        html_nodes(stats_id) %>>%
        html_attr(name="href") %>>% unlist %>>% as.character -> maj_playerid
    df %>>% nrow()-5  -> rows
    df[1:rows,] -> df
    df=df[!na.omit(df$Rk=='Rk'),]
    df$season <- c(season)
    df$Tm <- c(teams)
    df$Lev=c("MLB")
    maj_playerid <- gsub(".shtml","",maj_playerid)
    maj_playerid=substring(maj_playerid, 12)
    df$maj_playerid <- c(maj_playerid)
    
    majors_pitching_new <- rbind(majors_pitching_new,df)
    
}
}

teams=c("MON","ANA")
'#team_pitching' -> stats_table
stats_table %>>% paste0(stats_table,' a') -> stats_id
majors_pitching_extra <- data.frame()

for (teams in teams){ for (season in 2000:2004) {
    html <- paste(url,teams,"/",season,".shtml",sep="")
    
    html(html) %>%
        html_nodes(stats_table) %>%
        html_table(header = T) %>%
        data.frame() %>%
        tbl_df() -> df
    
    html(html) %>>%
        html_nodes(stats_id) %>>%
        html_attr(name="href") %>>% unlist %>>% as.character -> maj_playerid
    df %>>% nrow()-5  -> rows
    df[1:rows,] -> df
    df=df[!na.omit(df$Rk=='Rk'),]
    df$season <- c(season)
    df$Tm <- c(teams)
    df$Lev=c("MLB")
    maj_playerid <- gsub(".shtml","",maj_playerid)
    maj_playerid=substring(maj_playerid, 12)
    df$maj_playerid <- c(maj_playerid)
    
    majors_pitching_extra <- rbind(majors_pitching_extra,df)
    
}
}

majors_pitching=rbind(majors_pitching,majors_pitching_tam,majors_pitching_new,majors_pitching_extra)

url <- "http://www.baseball-reference.com/minors/"
teams=c("ARI","ATL","BAL","BOS","CHC","CHW","CIN","CLE","COL","DET","HOU","KCR","ANA","LAD","FLA","MIL","MIN","NYM","NYY","OAK","PHI","PIT","SDP","SFG","SEA","STL","TBD","TEX","TOR","WSN")
'#team_pitching.sortable.stats_table' -> stats_table
stats_table %>>% paste0(stats_table,' a') -> stats_id
minors_pitching <- data.frame()

for (teams in teams){ for (season in 2014:2000) {
html <- paste(url,"affiliate.cgi?id=",teams,"&year=",season,sep="")

html(html) %>%
	html_nodes(stats_table) %>%
	html_table(header = T) %>%
	data.frame() %>%
	tbl_df() -> df

html(html) %>>%
        html_nodes(stats_id) %>>%
        html_attr(name="href") %>>% unlist %>>% as.character -> maj_playerid
df %>>% nrow() -> rows
    df[1:rows,] -> df
df=df[!na.omit(df$Rk=='Rk'),]
df$season <- c(season)
df$Tm <- c(teams)
maj_playerid <- gsub(".shtml","",maj_playerid)
maj_playerid=substring(maj_playerid, 12)

df$maj_playerid <- c(maj_playerid)

minors_pitching <- rbind(minors_pitching,df)

}
}

View(majors_pitching)
View(minors_pitching)
