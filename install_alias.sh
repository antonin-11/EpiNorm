env_term=$(printenv SHELL)

if [ $env_term = "/bin/zsh" ]
then
        chmod 777 ~/.zshrc
        echo -ne "\n\nalias epinorm=\"python3 $PWD/EpiNorm.py\"\nalias Epinorm=\"python3 $PWD/EpiNorm.py\"\nalias EpiNorm=\"python3 $PWD/EpiNorm.py\"" >> ~/.zshrc
        chmod 644 ~/.zshrc
        echo -ne "\033[1m\033[32msuccessful alias installation\033[0m\n"
elif [ $env_term = "/bin/bash" ]
then
        echo -ne "\n\nalias epinorm=\"python3 $PWD/EpiNorm.py\"\nalias Epinorm=\"python3 $PWD/EpiNorm.py\"\nalias EpiNorm=\"python3 $PWD/EpiNorm.py\"" >> ~/.bashrc
        echo -ne "\033[1m\033[32msuccessful alias installation\033[0m\n"
else
        echo -ne "\033[1m\033[31mError install alias\033[0m\n"
fi