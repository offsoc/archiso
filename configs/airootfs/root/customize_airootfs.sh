#!/bin/sh
set -e

systemctl enable iwd.service
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl enable sshd

hostname="archiso"
echo $hostname > /etc/hostname

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo -e 'en_US.UTF-8 UTF-8\nzh_CN.UTF-8 UTF-8' >> /etc/locale.gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
locale-gen

chsh -s /bin/zsh
cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
sed -i '/^twm/,$d' $HOME/.xinitrc
echo 'exec dwm' >> $HOME/.xinitrc
echo 'if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi' >> $HOME/.zprofile

git clone https://gitee.com/xundaoxd/dogeystamp-dwm.git
cd dogeystamp-dwm
make
sudo make install
cd ..
git clone https://gitee.com/xundaoxd/dogeystamp-st.git
cd dogeystamp-st
make
sudo make install
cd ..
git clone https://gitee.com/xundaoxd/dogeystamp-dmenu.git
cd dogeystamp-dmenu
make
sudo make install
cd ..
