### Git and GitHub Tutorial by Kalen Clifton

Git is a popular version control software.  It keeps track of every file in a folder structure that is refered to as a repository (repo). Through tracking versions, Git allows you to restore a previous version if necessary.

GitHub is a platform that allows you to host repositories remotely so that multiple people can conveniently contribute to a project.

1. You can create a GitHub account at [https://github.com](https://github.com)

#### Forking a Repo

If there is an existing repository that you want to edit, you can perform a task called forking the repo. Making a fork copies an existing repository to your account. It maintains a link to the original parent respository so that you can sync your copy whenever the parent repository changes and you can also contribute new changes in your respository to the parent.

2. To create a fork, navigate to a repo on the GitHub website. In the top right you will see a "Fork" button.

#### Cloning a Repo

To be able to edit a repo as if you were working in a regular directory on your computer, you can clone a repo to your machine. Cloning a repo creates a local copy of a repository while still mainting a link to the remote repository hosted on GitHub. 

3. To clone your forked repo, go to your forked repo in your GitHub account. Make sure in the top left you see your username ahead of the forked repo name. On the top right, you'll see a green "Code" button. After you click on code, copy the repo address. In terminal navigate to where you would like to store your repo (can utilize the `cd` command). Enter the command `git clone [repo address]` replacing the entired bracketed phrase including the brackets with you copied repo address.

#### Committing Changes

When making changes in a repo, a version of the changes can be saved and tracked by making a commit, essentially storing a snapshot of all the files in the repo. Commits make it possible to transfer specific changes from your local repo to its remote repo on GitHub.

4. Check what changes have been made in a repo by entering the command `git status`. A list of untracked files should appear if any changes have been made.
5. To specify which file changes you would like to include in the next commit, use the command `git add [your filename]` (can list multiple files separating names by single spaces) to add changes into the staging area. If you are sure you would like to to add all changes in a directory to the git staging area, instead you can use `git add [your directory]` or use the command `git add .` where the `.` is refering to the current directory.
6. Check what files have been added by entering the command `git status`. A list of tracked files should appear if any files have been staged.
7. Use `git commit -m [your message]` to commit tracked changes with a short but meaningful commit message that describes what changes are being stored in case you want to revert back to this snapshot.

#### Pushing and Pulling Commits

Pushing and pulling commits allows for content in repositories to match. Pushing is how you transfer commits from your local repo to a remote repo. Conversely, pulling is how you transfer commits from a remote repo to your repo. When working collaboratively on a shared repo, you are often pushing away commits that you make in your local repo and pulling in commits that collaborators have made in the remote repo.

8. Enter the command `git push` to push your changes from your local repo to your remote forked repo on GitHub. You can utilize `git status` again to check if you push was successful. Also, when you view your forked repo on GitHub after pushing a commit, you should be at least 1 commit **ahead** on the main parent repo and there will be a message stating that at the top of your repo.
9. If your forked repo is any number of commits **behind** the parent repo, you should sync changes by clicking on the "Sync fork" button on the top right and then selecting "Update branch".
10. Return to the terminal and enter `git pull` to update your local repo to match your remote repo once you have synced your remote repo with the parent repo.

#### Pull Requests

Pull requests are a mechanism to collaborate with others on a repository by using a web interface for discussing proposed changes before integrating them into the main shared project. When you file a pull request, you are requesting that someone else pulls commits from your repository into their repository. With pull requests, GitHub will notify the collaborator if any conflicts will be introduced if they merge the changes from your repo into their own. If the collaborator likes your changes and no conflicts are introduced, they will accept the pull request. 

11. Since you have synced your changes from your local repo with your remote forked repo, you can request that those changes be merge into the main parent repo from which you forked. On GitHub, view your forked repo and navigate to the "Pull requests" tab, then click "New pull request" and follow the instruction to submit a pull request.


#### Resources

- [https://docs.github.com/en/get-started/quickstart/fork-a-repo]()
- [https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository#adding-a-file-to-a-repository-using-the-command-line]()
- [https://www.atlassian.com/git/tutorials/syncing](https://www.atlassian.com/git/tutorials/syncing)
- [https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork]()