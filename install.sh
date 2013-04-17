# install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

# install ctags
brew install ctags-exuberant
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
