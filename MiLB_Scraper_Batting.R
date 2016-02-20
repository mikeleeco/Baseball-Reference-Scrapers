# install.packages("devtools")
# install_github("hadley/rvest")
c('rvest','dplyr') -> packages #installs packages
lapply(packages, library, character.only = T)

# prep scraper
url <- "http://www.baseball-reference.com/minors/"
teams=c("ARI","ATL","BAL","BOS","CHC","CHW","CIN","CLE","COL","DET","HOU","KCR","ANA","LAD","FLA","MIL","MIN","NYM","NYY","OAK","PHI","PIT","SDP","SFG","SEA","STL","TBD","TEX","TOR","WSN")
stats_table <- '#team_batting.sortable.stats_table'
stats_id <- paste0(stats_table,' a')
minors_batting <- data.frame()

# for loop by teams and season
for (teams in teams){ 
	for (season in 2014:2000) {
		html <- paste(url,"affiliate.cgi?id=",teams,"&year=",season,sep="")

    # batting stats
		read_html(html) %>%
			html_nodes(stats_table) %>%
			html_table(header = T) %>%
			data.frame() %>%
			tbl_df() -> df

    # player info
		read_html(html) %>%
			html_nodes(stats_id) %>%
			html_attr(name="href") %>% unlist %>% as.character -> min_playerid

    # clean dataframe and add team and season info
		df <- df[1:nrow(df),]
		df <- df[!na.omit(df$Rk=='Rk'),]
		df$season <- c(season)
		df$teams <- c(teams)

    # remove url data
		min_playerid=gsub("/register/player.cgi?id=", "", min_playerid,fixed = TRUE)
		df$min_playerid <- c(min_playerid)

    # bind to 
		minors_batting <- rbind(minors_batting,df)
	}
}
