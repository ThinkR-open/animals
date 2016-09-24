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
  res <- llply( seq_len(pages), function(i){
    scrap(what, page=i)
  }, .progress = .progress, ... )
  unlist(res)
}

#' urls for pictures of cats
#' 
#' @export
#' @rdname animals
cats <- function(){
  scrap_all("chats")
}
  
#' urls for pictures of kittens
#' 
#' @export
#' @rdname animals
kittens <- function(){
  scrap_all("bebe,chats")
}

#' urls for pictures of dogs
#' @export
#' @rdname animals
dogs <- function(){
  scrap_all("chiens")
}

#' urls for pictures of puppies
#' @export
#' @rdname animals
puppies <- function(){
  scrap_all("bebe,chiens")
}

#' urls for pictures of horses
#' @export
#' @rdname animals
horses <- function(){
  scrap_all("chevaux")
}

#' urls for pictures of foals
#' @export
#' @rdname animals
foals <- function(){
  scrap_all("bebe,chevaux")
}

#' urls for pictures of rodents
#' @export
#' @rdname animals
rodents <- function(){
  scrap_all("rongeurs")
}

#' urls for pictures of rodents
#' @export
#' @rdname animals
baby_rodents <- function(){
  scrap_all("bebe,rongeurs")
}

#' urls for pictures of birds
#' @export
#' @rdname animals
birds <- function(){
  scrap_all("oiseaux")
}

#' urls for pictures of chicks
#' @export
#' @rdname animals
chicks <- function(){
  scrap_all("bebe,oiseaux")
}

#' urls for pictures of arthropods
#' @export
#' @rdname animals
arthropods <- function(){
  scrap_all("arthropodes")
}

#' urls for pictures of farm animals
#' @export
#' @rdname animals
farm_animals <- function(){
  scrap_all("animaux-de-la-ferme")
}

#' urls for pictures of farm animals
#' @export
#' @rdname animals
baby_farm_animals <- function(){
  scrap_all("bebe,animaux-de-la-ferme")
}

#' urls for pictures of reptiles
#' @export
#' @rdname animals
reptiles <- function(){
  scrap_all("reptiles")
}

#' urls for sea animals pictures
#' @export
#' @rdname animals
sea_animals <- function(){
  scrap_all("animaux-aquatiques")
}

#' urls for pictures of other animals
#' @export
#' @rdname animals
other_animals <- function(){
  scrap_all("autres")
}

#' urls for other baby animals pictures
#' @export
#' @rdname animals
other_baby_animals <- function(){
  scrap_all("bebe,autres")
}

#' urls for all animal pictures
#' @export
#' @rdname animals
all_animals <- function(){
  scrap_all("toutes")
}

#' urls for all baby animal pictures
#' @export
#' @rdname animals
all_baby_animals <- function(){
  scrap_all("bebe,toutes")
}
