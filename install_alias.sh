env_term=$(printenv SHELL)

if [ $1 ]
then
        ls > /dev/null
else
        if [[ $1 = "--update" ]]
        then
                cd $2
                if [[ $(git diff) ]]
                then
                        git pull > /dev/null 2>&1
                        if [[ $env_term = "/bin/zsh" ]]
                        then
                                echo "\033[1m\033[32mA new update has been installed\n\033[0m"
                        else
                                echo -ne "\033[1m\033[32mA new update has been installed\n\033[0m"
                        fi
                fi
                exit
        fi
fi

if [ $env_term = "/bin/zsh" ]
then
        file=$(cat ~/.zshrc)
        if [[ $file =~ "epinorm" ]]
        then
                echo "\033[1m\033[31mThe alias is already installed\n\033[0m"
        else
                chmod 777 ~/.zshrc
                echo "\n\nalias epinorm=\"python3 $PWD/EpiNorm.py\"" >> ~/.zshrc
                chmod 644 ~/.zshrc
                source ~/.zshrc
                echo "\033[1m\033[32msuccessful alias installation\033\n[0m"
        fi
        if [[ $file =~ "up_epinorm" ]]
        then
                echo "\033[1m\033[31mAutomatic updates are already installed\n\033[0m"
        else
                chmod 777 ~/.zshrc
                echo "\nalias up_epinorm=\"$PWD/install_alias.sh --update $PWD\"" >> ~/.zshrc
                chmod 644 ~/.zshrc
                source ~/.zshrc
                echo "\033[1m\033[32mAutomatic updates are installed\n\033[0m"
        fi
elif [ $env_term = "/bin/bash" ]
then
        file=$(cat ~/.bashrc)
        if [[ $file =~ "epinorm" ]]
        then
                echo -ne "\033[1m\033[31mThe alias is already installed\n\033[0m"
        else
                echo -ne "\n\nalias epinorm=\"python3 $PWD/EpiNorm.py\"" >> ~/.bashrc
                source ~/.bashrc
                echo -ne "\033[1m\033[32msuccessful alias installation\n\033[0m"
        fi
        if [[ $file =~ "up_epinorm" ]]
        then
                echo -ne "\033[1m\033[31mAutomatic updates are already installed\n\033[0m"
        else
                echo -ne "\nalias up_epinorm=\"$PWD/install_alias.sh --update $PWD\"" >> ~/.bashrc
                source ~/.bashrc
                echo -ne "\033[1m\033[32mAutomatic updates are installed\n\033[0m"
        fi
else
        echo -ne "\033[1m\033[31mError install alias\033[0m\n"
fi