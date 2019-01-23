if [ "$#" -ne 1 ]; then
  echo "Usage: ./migrate_repo.sh <project-name>"
  exit
fi

# Assume we are in your home directory
cd ~/

# Clone the repo from GitLab using the `--mirror` option
git clone --mirror git@gitlab.com:ddowl/$1.git

# Change into newly created repo directory
cd ~/$1.git

# Push to GitHub using the `--mirror` option.  The `--no-verify` option skips any hooks.
git push --no-verify --mirror git@github.com:ddowl/$1.git

# Set push URL to the mirror location
git remote set-url --push origin git@github.com:ddowl/$1.git

# To periodically update the repo on GitHub with what you have in GitLab
git fetch -p origin
git push --no-verify --mirror

cd ..
rm -rf ~/$1.git
