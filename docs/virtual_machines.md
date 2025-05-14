# documentation: virtual machines

The university provides virtual machines, which will have direct access to the shared drive. 

This is great as access to the drive is much faster than using VPN + mounting the shared drive on your local machine. But the issue is that these VM do not save any files, and thus do not save preference files, R liraries, etc. This concerns in particular:

- Your Rstudio prefrence files: shortcuts, last project, snippets
- The R library


## R library

The idea is to use an R library that is permanently saved on the shared drive:

```
r_vers <- paste0(R.Version()[c("major","minor")], collapse = ".")
my_lib_path <- file.path("Z:/shared_projects/R_shared_lib",r_vers)
if(!dir.exists(my_lib_path)) dir.create(my_lib_path)
.libPaths( c( .libPaths(), my_lib_path) )
```

Where Z is the letter linked to the shared drive. 

## Machines

You should have access to the following: 

- `GSEM-2024`: the standard student VM
- `GPU-1`: much more powerful, with 64 GB 
