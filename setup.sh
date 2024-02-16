#!/bin/bash

# 确保脚本以root权限运行
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# 1. 更改root账号密码
echo 'root:20020705.zsq' | chpasswd

# 2. 替换/etc/ssh/sshd_config配置文件
# 确保当前路径下有sshd_config文件
if [ -f "sshd_config" ]; then
    cp -f sshd_config /etc/ssh/sshd_config
else
    echo "sshd_config file does not exist in the current directory."
    exit 1
fi

# 3. 执行install-release.sh脚本
# 确保当前路径下有install-release.sh文件
if [ -f "install-release.sh" ]; then
    chmod +x install-release.sh
    ./install-release.sh
else
    echo "install-release.sh file does not exist in the current directory."
    exit 1
fi

# 4. 复制config.json到/usr/local/etc/v2ray/
# 确保当前路径下有config.json文件
if [ -f "config.json" ]; then
    mkdir -p /usr/local/etc/v2ray
    cp -f config.json /usr/local/etc/v2ray/
else
    echo "config.json file does not exist in the current directory."
    exit 1
fi

systemctl enable v2ray
systemctl start v2ray

# 在/root/.bashrc中添加自定义PS1提示符
echo "export PS1='\\[\\e[7;31m\\]\\u@\\h:\\[\\e[0m\\]\\[\\e[7;33m\\]\\w \\[\\e[0m\\]\\[\\e[7;32m\\]\\d \\t\\[\\e[0m\\]\\n\\[\\e[0;32m\\]\\$ \\[\\e[0m\\]'" | tee -a /root/.bashrc
source /root/.bashrc

chmod +x ./nps/setup.sh && sudo  ./nps/nps install
nps start

# 5. 重启系统
shutdown -r now

exit 0
