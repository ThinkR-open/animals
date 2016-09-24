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

#' urls for pictures of cats
#' 
#' @export
cats <- function(){
  scrap_all("chats")
}
  
#' urls for pictures of kittens
#' 
#' @export
kittens <- function(){
  scrap_all("bebe,chats")
}

#' urls for pictures of dogs
#' @export
dogs <- function(){
  scrap_all("chiens")
}

#' urls for pictures of puppies
#' @export
puppies <- function(){
  scrap_all("bebe,chiens")
}

#' urls for pictures of horses
#' @export
horses <- function(){
  scrap_all("chevaux")
}

#' urls for pictures of foals
#' @export
foals <- function(){
  scrap_all("bebe,chevaux")
}

#' urls for pictures of rodents
#' @export
rodents <- function(){
  scrap_all("rongeurs")
}

#' urls for pictures of rodents
#' @export
baby_rodents <- function(){
  scrap_all("bebe,rongeurs")
}

#' urls for pictures of birds
#' @export
birds <- function(){
  scrap_all("oiseaux")
}

#' urls for pictures of chicks
#' @export
chicks <- function(){
  scrap_all("bebe,oiseaux")
}

#' urls for pictures of arthropods
#' @export
arthropods <- function(){
  scrap_all("arthropodes")
}

#' urls for pictures of farm animals
#' @export
farm_animals <- function(){
  scrap_all("animaux-de-la-ferme")
}

#' urls for pictures of farm animals
#' @export
baby_farm_animals <- function(){
  scrap_all("bebe,animaux-de-la-ferme")
}

#' urls for pictures of reptiles
#' @export
reptiles <- function(){
  scrap_all("reptiles")
}

#' urls for sea animals pictures
#' @export
sea_animals <- function(){
  scrap_all("animaux-aquatiques")
}

#' urls for pictures of other animals
#' @export
other_animals <- function(){
  scrap_all("autres")
}

#' urls for other baby animals pictures
#' @export
other_baby_animals <- function(){
  scrap_all("bebe,autres")
}

#' urls for all animal pictures
#' @export
all_animals <- function(){
  scrap_all("toutes")
}

#' urls for all baby animal pictures
#' @export
all_baby_animals <- function(){
  scrap_all("bebe,toutes")
}
