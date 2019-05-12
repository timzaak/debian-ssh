debian develop kit
==================

本项目主要用来准备 Linux 开发环境，方便在 Mac 上用 CLion 开发/调试 C/C++ 项目

目前支持的项目有

- [x] fluent-bit
- [x] envoy

开发流程参考: [Clion 如何使用 Docker 作为开发环境](https://imhuwq.com/2018/12/02/Clion%20%E4%BD%BF%E7%94%A8%20Docker%20%E4%BD%9C%E4%B8%BA%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83/)


Usage
-----

To create the image `debian develop kit` with latest Debian release, 
execute the following commands on the debian-ssh folder:

    git checkout master
    docker build -t timzaak/devkit .

Running debian develop kit
--------------------------

To run a container from the image binding it to port 2222 in all interfaces, execute:

	docker run -d -p 2222:22 timzaak/devkit

The first time that you run your container, a random password will be generated
for user `root`. To get the password, check the logs of the container by running:

	docker logs <CONTAINER_ID>

You will see an output like the following:

	========================================================================
	You can now connect to this debian-ssh container via SSH using:

	    ssh -p <port> root@<host>
	and enter the root password 'UCr7W3U0iSGV' when prompted

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `UCr7W3U0iSGV` is the password allocated to the `root` user.

Done!


Setting a specific password for the root account
------------------------------------------------

If you want to use a preset password instead of a random generated one, you can
set the environment variable `ROOT_PASS` to your specific password when running the container:

	docker run -d -p 2222:22  -e ROOT_PASS="mypass" timzaak/devkit

作为开发环境基本命令：

    docker run -d -p 2222:22 -p 2345:2345 --name=devkit -e ROOT_PASS="mypass"  timzaak/devkit



通用脚本

    #!/usr/bin/env bash
    # docker.sh
    
    action=$1
    if [ $action = "enter" ]; then
    docker exec -it devkit bash
    elif [ $action = "down" ]; then
        docker stop devkit
    elif [ $action = "debug" ]; then
        docker-compose exec my-project sh -c "gdbserver :2345 $(ENTER_EXECUTE) ${*:2}"
    fi
