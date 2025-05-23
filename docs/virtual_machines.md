# Virtual machines

The university provides virtual machines, which will have direct access to the shared drive. 

This is great as access to the drive is much faster than using VPN + mounting the shared drive on your local machine. But the issue is that these VM do not save any files, and thus do not save preference files, R liraries, etc. This concerns in particular:

- Your Rstudio prefrence files: shortcuts, last project, snippets
- The R library


## R library

The idea is to use an R library that is permanently saved on the shared drive: `shared_projects/R_shared_lib`. This is done automatically in the `.Rprofile` file in each project.

To do it manually:
```
r_vers <- paste0(R.Version()[c("major","minor")], collapse = ".")
shared_lib_path <- file.path("Z:/shared_projects/R_shared_lib",r_vers)
.libPaths( c( .libPaths(), shared_lib_path) )
```

Where `Z` is the letter linked to the shared drive. 
If you are missing packages, you can install them as usual with `install.packages()`, but this will install in your personnal library, not the shared one (to which you probably don't have write access, only read access), so will be erased every time. To avoid this, let me know and I will install in the main library.

## Machines

You should have access to the following: 

- `GSEM-2024`: the standard student VM
- `GPU-1`: much more powerful, with 64 GB

## Using rstdudio shortcuts on a VM

Unfortunately, shortcuts and the list of previous projects and scripts are not permanent on the VM... There is a complicated workaround:

1. at the end of the session, save the files containing shortcuts and list of projects/scripts in your `H` folder:
   - shortcuts are stored in the folder `C:/Users/YOURUSER/AppData/Roaming/RStudio/keybindings`
   - list of last project/scripts are stored in the folder `C:/Users/YOURUSER/AppData/Local/RStudio/monitored/lists"`
3. at the beginning of every VM, copy from `H` to the (temporary) preference files
4. If you update the shortcuts, or use often other projects/scripts, restart step 1

Here is the full script for step 2, that I use every time I launch a VM:

```
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


## shortcuts: only on gsem VDI
node <- Sys.info()["nodename"]
if(!grepl("GPU", node)){
  
  copy_directory("H:/sync_VDI/keybindings",
                 "C:/Users/YOURUSER/AppData/Roaming/RStudio/keybindings")
}

## last project
copy_directory("H:/sync_VDI/monitored_lists",
               "C:/Users/YOURUSER/AppData/Local/RStudio/monitored/lists")
```

## Using `git` on a VM

The best way to `pull`/`push` is using the ssh protocol. This will involve:

1. Creating a ssh key
2. sending it to ghitub
3. Then do the `pull`/`push`

This is more complicated on the VM as the ssh key is not necessarily stored. I recommend saving in on your personnal H drive

Steps:

1. Create key: `ssh-keygen -t ed25519 -C "your.email@unige.ch" -f /h/SSH/id_ed25519`
2. send to github: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
3. Add it to the ssh-agent: `eval $(ssh-agent -s)
ssh-add /h/SSH/id_ed25519`
4. Check: `ssh -T git@github.com`

Currently, you will need to run the two lines `eval $(ssh-agent -s)
ssh-add /h/SSH/id_ed25519` every time you reboot the machine

