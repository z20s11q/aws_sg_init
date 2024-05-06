#PermitRootLogin prohibit-password
PermitRootLogin yes

PermitRootLogin yes
PasswordAuthentication yes

sed -i '/#PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config && sed -i '/PasswordAuthentication no/c\PasswordAuthentication yes' /etc/ssh/sshd_config


git clone https://github.com/z20s11q/aws_sg_init.git && cd aws_sg_init && chmod +x setup.sh && sudo ./setup.sh

安装nps:

chmod +x ./nps/nps && sudo  ./nps/nps install

启动nps:

nps start
