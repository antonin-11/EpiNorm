env_term=$(printenv SHELL)

if [ $env_term = "/bin/zsh" ]
then
        file=$(cat ~/.zshrc)
        if [[ $file =~ "epinorm" ]]
        then
                echo "\033[1m\033[31mthe alias is already installed\033[0m"
        else
                chmod 777 ~/.zshrc
                echo "\n\nalias epinorm=\"python3 $PWD/EpiNorm.py\"\nalias Epinorm=\"python3 $PWD/EpiNorm.py\"\nalias EpiNorm=\"python3 $PWD/EpiNorm.py\"" >> ~/.zshrc
                chmod 644 ~/.zshrc
                echo "\033[1m\033[32msuccessful alias installation\033[0m"
        fi
elif [ $env_term = "/bin/bash" ]
then
        file=$(cat ~/.bashrc)
        if [[ $file =~ "epinorm" ]]
        then
                echo -ne "\033[1m\033[31mthe alias is already installed\033[0m"
        else
                echo -ne "\n\nalias epinorm=\"python3 $PWD/EpiNorm.py\"\nalias Epinorm=\"python3 $PWD/EpiNorm.py\"\nalias EpiNorm=\"python3 $PWD/EpiNorm.py\"" >> ~/.bashrc
                echo -ne "\033[1m\033[32msuccessful alias installation\033[0m\n"
        fi
else
        echo -ne "\033[1m\033[31mError install alias\033[0m\n"
fi