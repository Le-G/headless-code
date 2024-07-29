FROM ubuntu:latest

RUN apt-get update
RUN apt dist-upgrade -y

# INSTALL VS CODE
RUN apt-get install -y wget gpg apt-transport-https
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null
RUN rm -f packages.microsoft.gpg
#RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y code

# Install dev dependencies
RUN apt-get install -y zsh git curl
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
RUN chsh -s /bin/zsh

CMD code --no-sandbox --user-data-dir=/root tunnel