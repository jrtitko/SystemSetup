if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jrtitko1/.sdkman"
[[ -s "/Users/jrtitko1/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jrtitko1/.sdkman/bin/sdkman-init.sh"
