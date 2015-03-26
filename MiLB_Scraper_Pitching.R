# install.packages("devtools")
# install_github("hadley/rvest"
c('rvest','dplyr','pipeR') -> packages #installs packages
lapply(packages, library, character.only = T) #installs packages
url <- "http://www.baseball-reference.com/minors/"
teams=c("ARI","ATL","BAL","BOS","CHC","CHW","CIN","CLE","COL","DET","HOU","KCR","ANA","LAD","FLA","MIL","MIN","NYM","NYY","OAK","PHI","PIT","SDP","SFG","SEA","STL","TBD","TEX","TOR","WSN")
'#team_pitching.sortable.stats_table' -> stats_table
stats_table %>>% paste0(stats_table,' a') -> stats_id
min_pitching <- data.frame()

for (teams in teams){ for (season in 2014:2014) {
html <- paste(url,"affiliate.cgi?id=",teams,"&year=",season,sep="")

html(html) %>%
	html_nodes(stats_table) %>%
	html_table(header = T) %>%
	data.frame() %>%
	tbl_df() -> df

html(html) %>>%
        html_nodes(stats_id) %>>%
        html_attr(name="href") %>>% unlist %>>% as.character -> min_playerid
df %>>% nrow() -> rows
    df[1:rows,] -> df
df=df[!na.omit(df$Rk=='Rk'),]
df$season <- c(season)
min_playerid=substr(min_playerid, 23,34)
df$min_playerid <- c(min_playerid)

min_pitching <- rbind(min_pitching,df)

}
}
