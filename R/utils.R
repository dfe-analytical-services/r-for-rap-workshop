library(odbc)
library(config)

sql_connect <- function(){
  conf <- config::get("db_connection")
  con <- dbConnect(odbc::odbc(), 
                   Driver   = conf$driver, 
                   Server   = conf$server, 
                   Database = conf$database, 
                   UID      = conf$uid, 
                   PWD      = conf$pwd, 
                   Trusted_Connection=conf$trusted)
}

# Get SQL code and tidy it up so it can run-------------------
getSQL <- function(filepath) {
  con <- file(filepath, "r")
  sql.string <- ""
  while (TRUE) {
    line <- readLines(con, n = 1)
    
    if (length(line) == 0) {
      break
    }
    line <- gsub("\\t", " ", line)
    line <- gsub("\\n", " ", line)
    
    if (grepl("--", line) == TRUE) {
      line <- paste(sub("--", "/*", line), "*/")
    }
    sql.string <- paste(sql.string, line)
  }
  close(con)
  return(sql.string)
}
