render_home <- function(req, res){
  res$render("home", list(title = "Hello from R"))
}

render_about <- function(req, res){
  res$render("about", list(title = "About", name = req$query$name))
}