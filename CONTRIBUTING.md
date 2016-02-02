## Workflow
Fork and clone the repo.
Add the upstream seven-web-frameworks repository as a new remote to your clone. git remote add upstream https://github.com/mikeyjcat/seven-web-frameworks.git
Create a new branch git checkout -b name-of-branch
Commit and push as usual on your branch.
When you're ready to submit a pull request, rebase your branch onto the upstream master so that you can resolve any conflicts: git fetch upstream && git rebase upstream/master You may need to push with --force up to your branch after resolving conflicts.
When you've got everything solved, push up to your branch and send the pull request as usual.
## Issues
We keep track of everything around the repository using Github issues.
