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

