FROM ubuntu:latest

RUN apt-get update
RUN apt dist-upgrade -y

# INSTALL VS CODE
RUN apt-get install -y wget gpg apt-transport-https sudo
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null
RUN rm -f packages.microsoft.gpg
RUN apt-get update
RUN apt-get install -y code

# Install dev dependencies
RUN apt-get install -y zsh git curl

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

RUN echo "VSCODE_CLI_USE_FILE_KEYCHAIN=1" >> /etc/environment

RUN adduser user
RUN chsh -s /bin/zsh user
RUN usermod -aG sudo user
USER user
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ENTRYPOINT code tunnel --name headless-code