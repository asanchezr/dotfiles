# bash-git-prompt
A bash prompt that displays information about the current git repository



## Installation

1. Clone this repository to your home directory. 

```sh
git clone --depth=1 https://github.com/asanchezr/bash-git-prompt.git ~/.bash-git-prompt
```

2.  Add to your `~/.bashrc`: 

```sh
if [ -f ~/.bash-git-prompt/git-prompt.sh ]; then
    source ~/.bash-git-prompt/git-prompt.sh
fi
```

3. Restart your shell

## Install using Docker

You can try this **git-prompt** in an isolated environment without changing any local files via a [Docker](https://www.docker.com/) container. (Bash Shell v5 with git-prompt based on [Alpine Linux](https://alpinelinux.org/) running as an unprivileged user). 

### About the Container

[Alpine Linux](https://alpinelinux.org/) was used as the base image which is a lightweight distribution with a small surface area for security concerns, but with enough functionality for development and interactive debugging.

To prevent zombie reaping processes [dumb-init](https://github.com/Yelp/dumb-init) is used as PID 1 which forwards signals to all processes running in the container.

### Example Usage in Docker

**Build the image from the Dockerfile**

```sh
docker build . -t <image_name>
```

**Start a interactive Bash Shell (default)**

```sh
docker run -it <image_name>
```

**Use your local `~/.bashrc` settings inside the Container (:ro for read only)**

```sh
docker run -it -v ~/.bashrc:/home/bashit/.bashrc:ro <image_name>
```

**Map the current directory inside the Container**

```sh
docker run -it ${PWD}:/data <image_name>
```

**Map a [Docker Volume](https://docs.docker.com/engine/tutorials/dockervolumes/)**

```sh
docker run -it myVolName:/app <image_name>
```

**Copy Data between Volumes**

```sh
docker run -it \
  -v import:/import \
  -v export:/export \
 <image_name> -c "cp -R /import/* /export"
```

**Backup a Volume to Disk**

```sh
docker run -it \
  -v import:/import \
  -v ${PWD}:/export \
<image_name> -c "tar -cvjf /export/backup.tar.bz2 /import/"
```

**Run a Command**

```sh
docker run -it <image_name> -c "ls -alF /"
```

**Run as root**

```sh
docker run -it -u root <image_name>
```