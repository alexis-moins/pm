local set="${args[--set]}"

if [[ -z "${set}" ]]; then
    echo "# Leader + o: open a pm project"
    echo 'bind-key o display-popup -E "pm open"'

    echo -e "\n# Leader + -: create a new pm project"
    echo 'bind-key - display-popup -E "pm tmux new"'
else
    echo "# Leader + o: open a pm project" >> ~/.tmux.conf
    echo 'bind-key o display-popup -E "pm open"' >> ~/.tmux.conf

    echo -e "\n# Leader + -: create a new pm project" >> ~/.tmux.conf
    echo 'bind-key - display-popup -E "pm tmux new"' >> ~/.tmux.conf
fi
