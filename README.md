# gh2

The goal of __gh2__ is to interact with GitHub from RStudio.

This tutorial is for those with a GitHub account, that have already installed Git (Git is the engine of GitHub), R and RStudio; these people configured it all but haven't fully incorporated these tools into their workflow.

Contents: These are good guide for what contents we may cover: 

- http://r-pkgs.had.co.nz/git.html. 
- http://happygitwithr.com/



## Issues

Approach: assume everybody has installed git bash. For those who didn't install it, do that quickly following r-pkgs:






- Open a new repo on GitHub, then clone it into a project on RStudio.

- Clone a repo from GitHub (__gh2__), then clone it into a project on RStudio.


- Clone a repo from GitHub, then a project on RStudio.



## Initial set up

(Adapted from http://r-pkgs.had.co.nz/git.html#git-init)



If you havent yet created an account on GitHub, do it now at 
<https://github.com>. The free plan is fine; you can request unlimited free
private repos at https://education.github.com/discount_requests/new. Your
request will more likely be successful if you use an \@edu email account.

Also install Git and link Git and GitHub together using the same email addredd: 

1.  Install Git:

    * Windows: <http://git-scm.com/download/win>.
    * OS X: <http://git-scm.com/download/mac>.
    * Debian/Ubuntu: `sudo apt-get install git-core`.
    * Other Linux distros: <http://git-scm.com/download/linux>.

    During installation, accept all the defaults.

1.  Launch Git Bash and tell Git your name and email address. These are used to
    label each commit so that when you start collaborating with others, it's 
    clear who made ach change. In the shell, run:

    ```bash
    git config --global user.name "YOUR FULL NAME"
    git config --global user.email "YOUR EMAIL ADDRESS"
    ```

    (You can check if you're set up correctly by running 
    `git config --global --list`.)

1.  If you want Git to not ask you your username and password each time you 
    make a commit, generate a SSH key (recomended but optional). SSH keys allow
    you to securely communicate with websites without a password. There are two
    parts to an SSH key: one public, one private. People with your public key 
    can securely encrypt data that can only be read by someone with your 
    private key. 
    
    In RStudio, you can check if you already have an SSH key-pair by running:
    
    ```{r, eval = FALSE}
    file.exists("~/.ssh/id_rsa.pub")
    ```

    If that returns `FALSE`, you'll need to create a new key. Go to RStudio
    preferences (Tools > Global Options...), choose the Git/SVN panel, and
    click "Create RSA key...":
    
    ```{r, echo = FALSE}
    oldbookdown::screenshot("screenshots/git-config-2.png", dpi = 220)
    ```
    
1.  Give GitHub your SSH public key: <https://github.com/settings/ssh>.
    The easiest way to find the key is to click "View public key" in
    RStudio's Git/SVN preferences pane.


