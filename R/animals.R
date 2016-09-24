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

#' urls for pictures of animals
#' @export
#' @rdname animals
cats <- function(){
  scrap_all("chats")
}
  
#' @export
#' @rdname animals
kittens <- function(){
  scrap_all("bebe,chats")
}

#' @export
#' @rdname animals
dogs <- function(){
  scrap_all("chiens")
}

#' @export
#' @rdname animals
puppies <- function(){
  scrap_all("bebe,chiens")
}

#' @export
#' @rdname animals
horses <- function(){
  scrap_all("chevaux")
}

#' @export
#' @rdname animals
foals <- function(){
  scrap_all("bebe,chevaux")
}

#' @export
#' @rdname animals
rodents <- function(){
  scrap_all("rongeurs")
}

#' @export
#' @rdname animals
baby_rodents <- function(){
  scrap_all("bebe,rongeurs")
}

#' @export
#' @rdname animals
birds <- function(){
  scrap_all("oiseaux")
}

#' @export
#' @rdname animals
chicks <- function(){
  scrap_all("bebe,oiseaux")
}

#' @export
#' @rdname animals
arthropods <- function(){
  scrap_all("arthropodes")
}

#' @export
#' @rdname animals
farm_animals <- function(){
  scrap_all("animaux-de-la-ferme")
}

#' @export
#' @rdname animals
baby_farm_animals <- function(){
  scrap_all("bebe,animaux-de-la-ferme")
}

#' @export
#' @rdname animals
reptiles <- function(){
  scrap_all("reptiles")
}

#' @export
#' @rdname animals
sea_animals <- function(){
  scrap_all("animaux-aquatiques")
}

#' @export
#' @rdname animals
other_animals <- function(){
  scrap_all("autres")
}

#' @export
#' @rdname animals
other_baby_animals <- function(){
  scrap_all("bebe,autres")
}

#' @export
#' @rdname animals
all_animals <- function(){
  scrap_all("toutes")
}

#' @export
#' @rdname animals
all_baby_animals <- function(){
  scrap_all("bebe,toutes")
}
