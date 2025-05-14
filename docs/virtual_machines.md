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

## Machines

You should have access to the following: 

- `GSEM-2024`: the standard student VM
- `GPU-1`: much more powerful, with 64 GB 
