git checkout master
git fetch upstream
git reset --hard upstream/master

git remote prune origin


git branch -D


message="Use @family datasets."

git add .
git commit -m "$message"

git add .
git commit --amend -m "$message"
