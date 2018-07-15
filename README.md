# SystemSetup
Default setups.
 
## GitHub Hooks
GitHub hooks cannot be saved to individual repos, so have to be set up be each Engineer manually.
 
In the /hooks directory is a commit-msg hook that should be put in all git repos locally to automatically put the Jira (if it is used as the branch name) at the beginning of all Git commits unless a Jira is manually added to the beginning of the comment.
 
Also in /hooks is a hookSetup.sh script that will automatically deploy commit.msg to your global .git-templates directory (creating it if necessary) and running 'git init' in all of your repositories.  <workspace-root> is the directory in which all of your repos exist.  If you have multiple workspace directories with repos, you will have to run this once for each workspace directory.
 
    Usage: <dev-tools repo>/hookSetup.sh <workspace-root>
 
After running this script for the first time, any new repo initialized using 'git init' or any time you clone a repo, the hooks stored globally will be copied into that repo.
 
## Process Commands
processCommand.sh executes the same command on multiple folders.  It is necessary to customize this script to group the folders each person wants to execute commands on.  Currently it is set up to process commands across all repos (known at the time it was written) for the GSP and EGS projects and located in the directory ~/workspace/.  The usefulness of this script is when it is combined with alias' in .bashrc to perform actions on all repos such as:
 
    alias pc='~/workspace/dev-tools/processCommand.sh'          - Location of the processCommand script
    alias fetch='pc git fetch'                                  - Performs a fetch on all repos
    alias master='pc git checkout master'                       - Changes all repos to the master branch
    alias st='pc git st'                                        - Performs a status on all repos to see what is outstanding
    alias test='pc -jl gradle clean check'                      - Compiles all repos that are Java applications or libraries
    alias update='pc -jnl git checkout master && pc -jnlx git pull && pc -jnl git checkout -' 
                                                                - Checks out the latest code in the master branch for all repos and restores the branch back to what it was before the checkout.
 
 
## Setup
Run SETUP.sh to run an automatic setup for creating symlinks to the .\<files\> and to set up standardized GIT shortcuts.  These are the shortcuts that I use so only run this if you want these aliases.
 