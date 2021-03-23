env_term=$(printenv SHELL)

if [[ $1 = "--update" ]]
then
        cd $2
        update=$(git diff)
        if [[ $update != "" ]]
        then
                # git pull > dev/null 2 > &1
                echo "\033[1m\033[32mA new update has been installed\033[0m"
        fi
        exit
fi

if [ $env_term = "/bin/zsh" ]
then
        file=$(cat ~/.zshrc)
        if [[ $file =~ "epinorm" ]]
        then
                echo "\033[1m\033[31mThe alias is already installed\033[0m"
        else
                chmod 777 ~/.zshrc
                echo "\n\nalias epinorm=\"python3 $PWD/EpiNorm.py\"" >> ~/.zshrc
                chmod 644 ~/.zshrc
                source ~/.zshrc
                echo "\033[1m\033[32msuccessful alias installation\033[0m"
        fi
        if [[ $file =~ "up_epinorm" ]]
        then
                echo "\033[1m\033[31mAutomatic updates are already installed\033[0m"
        else
                chmod 777 ~/.zshrc
                echo "\nalias up_epinorm=\"$PWD/install_alias.sh --update\"" >> ~/.zshrc
                chmod 644 ~/.zshrc
                source ~/.zshrc
                echo "\033[1m\033[32mAutomatic updates are installed\033[0m"
        fi
elif [ $env_term = "/bin/bash" ]
then
        file=$(cat ~/.bashrc)
        if [[ $file =~ "epinorm" ]]
        then
                echo -ne "\033[1m\033[31mThe alias is already installed\033[0m"
        else
                echo -ne "\n\nalias epinorm=\"python3 $PWD/EpiNorm.py\"" >> ~/.bashrc
                source ~/.bashrc
                echo -ne "\033[1m\033[32msuccessful alias installation\033[0m\n"
        fi
        if [[ $file =~ "up_epinorm" ]]
        then
                echo -ne "\033[1m\033[31mAutomatic updates are already installed\033[0m"
        else
                echo -ne "\nalias up_epinorm=\"$PWD/install_alias.sh --update\"" >> ~/.bashrc
                source ~/.bashrc
                echo -ne "\033[1m\033[32mAutomatic updates are installed\033[0m"
        fi
else
        echo -ne "\033[1m\033[31mError install alias\033[0m\n"
fi