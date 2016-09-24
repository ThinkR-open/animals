#' @importFrom magrittr %>%
#' @importFrom xml2 read_html 
#' @importFrom rvest html_node html_text
npages <- function( what = "bebe,chats" ){
  url <- sprintf( "http://www.photos-animaux.com/photos,%s.html", what )
  read_html(url) %>%
    html_node("li.page") %>%
    html_text() %>%
    gsub( "^.* ([[:digit:]]+)$", "\\1", .) %>%
    as.numeric
} 

#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_attr
#' @export
scrap <- function(what = "bebe,chats", page=1 ){
  url <- sprintf( "http://www.photos-animaux.com/photos,%s;%d.html", what, page )
  photos <- read_html(url) %>%
    html_nodes(".photo")
  
  img <- photos %>% 
    html_nodes("img") %>%
    html_attr("src")
  
  img
}

#' @importFrom plyr llply
scrap_all <- function(what = "bebe,chats", .progress = "text", ...){
  pages <- npages(what)
  print(pages)
  res <- llply( seq_len(pages), function(i){
    scrap(what, page=i)
  }, .progress = .progress, ... )
  unlist(res)
}

#' @export
cats <- function(){
  scrap_all("chats")
}
  
#' @export
kittens <- function(){
  scrap_all("bebe,chats")
}
