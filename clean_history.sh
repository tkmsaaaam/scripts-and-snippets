#!/bin/sh
cat $HOME/.zsh_history > ./.zsh_history

cat $HOME/.zsh_history | wc -l

COMMANDS=(\
  "brew install" \
  "brew uninstall" \
  "brew list" \
  "bundle" \
  "cargo" \
  "cat" \
  "cd .." \
  "chmod" \
  "code" \
  "cp" \
  "curl" \
  "date" \
  "docker build" \
  "docker compose"
  "docker container" \
  "docker exec" \
  "docker history" \
  "docker image" \
  "docker pull" \
  "docker rm" \
  "docker run" \
  "docker status" \
  "docker stop" \
  "docker volume" \
  "dotnet" \
  "echo" \
  "export" \
  "find" \
  "gem" \
  "git add" \
  "gh" \
  "git branch" \
  "git checkout" \
  "git clone" \
  "git commit" \
  "git diff" \
  "git log" \
  "git pull" \
  "git push" \
  "git rebase" \
  "git reset" \
  "git restore" \
  "git remote" \
  "git stash" \
  "git status" \
  "git switch" \
  "go build" \
  "go fmt" \
  "go install" \
  "go generate" \
  "go get" \
  "go mod" \
  "go run" \
  "go test" \
  "gradle" \
  "grep" \
  "gsed" \
  "hadolint" \
  "java" \
  "jhat" \
  "jj" \
  "jmap" \
  "jstat" \
  "kill" \
  "kubectl" \
  "less" \
  "ls" \
  "man" \
  "mdatagen" \
  "mkdir" \
  "mv" \
  "mysql" \
  "node" \
  "nodebrew" \
  "npm" \
  "npx" \
  "open" \
  "pringenv" \
  "ps" \
  "pwd" \
  "rails" \
  "rbenv" \
  "reportgenerator" \
  "rm" \
  "ruby" \
  "scp" \
  "security" \
  "sed" \
  "semgrep" \
  "sleep" \
  "source" \
  "SLACK_TOKEN=" \
  "sudo" \
  "tail" \
  "TEXT=" \
  "tsc" \
  "touch" \
  "./target" \
  "vagrant" \
  "vi"\
  "uuidgen" \
  "which" \
  "yarn" \
  "\.\/" \
  "\/" \
)

for COMMAND in "${COMMANDS[@]}"; do
  echo $COMMAND
  gsed -i -e "s#^$COMMAND.*##g" $HOME/.zsh_history
  gsed -r -i -e "s#^\:\ [0-9]{10}\:0\;$COMMAND.*##g" $HOME/.zsh_history
done

gsed -i -e "s#^$[a-zA-Z]*\.sh.*##g" $HOME/.zsh_history

gsed -i -e '/^$/d' $HOME/.zsh_history

echo  "less $HOME/.zsh_history"

cat $HOME/.zsh_history | wc -l

# brew upgrade && brew cleanup && brew autoremove && brew list | xargs -I{} sh -c 'brew uses --installed {} | wc -l | xargs printf "%20s %2d\n" {}' | grep " 0"
# brew bundle dump --file $HOME/.Brewfile -f
# brew bundle cleanup --file $HOME/.Brewfile
