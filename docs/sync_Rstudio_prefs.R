#' ---
#' Title: ""
#' Author: "Matthieu"
#' Date: 2025-05-23
#' ---

## create function to copy an entire folder
copy_directory <- function(from, to, overwrite = TRUE, recursive = TRUE) {
  
  if (!dir.exists(from)) {
    warning(paste("Source directory", from, "does not exist."))
    return(FALSE)
  }
  
  if (!dir.exists(to)) {
    dir.create(to, recursive = TRUE)
  }
  
  files <- list.files(from, all.files = TRUE, recursive = recursive, include.dirs = TRUE, full.names = TRUE)
  
  for (file in files) {
    relative_path <- gsub(from, "", file, fixed = TRUE)
    dest_file <- file.path(to, relative_path)
    if (file.info(file)$isdir) {
      if (!dir.exists(dest_file)) {
        dir.create(dest_file, recursive = TRUE)
      }
    } else {
      file.copy(file, dest_file, overwrite = overwrite)
    }
  }
  
  return(TRUE)
}


## save preferences to H: only first time or to update!
your_USER <- "XXX"
if(FALSE){
  copy_directory(paste0("C:/Users/", stigler, "/AppData/Roaming/RStudio/keybindings"),
                 "H:/sync_VDI/keybindings")
  copy_directory(paste0("C:/Users/", your_USER, "/AppData/Local/RStudio/monitored/"),
                 "H:/sync_VDI/monitored")
  file.copy(paste0("C:/Users/", your_USER, "/AppData/Roaming/RStudio/rstudio-prefs.json"),
            "H:/sync_VDI/rstudio-prefs.json")
}

## update every time:

## shortcuts + prefs: only on gsem VM, not GPU
node <- Sys.info()["nodename"]
if(!grepl("GPU", node)){
  
  copy_directory("H:/sync_VDI/keybindings",
                 paste0("C:/Users/", your_USER, "/AppData/Roaming/RStudio/keybindings"))
  file.copy("H:/sync_VDI/rstudio-prefs.json",
            paste0("C:/Users/", your_USER, "/AppData/Roaming/RStudio/rstudio-prefs.json"),
            overwrite=TRUE)
}

## last project, snippets
copy_directory("H:/sync_VDI/monitored",
               paste0("C:/Users/", your_USER, "/AppData/Local/RStudio/monitored"))

