export LANG=en_US.UTF-8
xrdb -merge ~/.Xresources
xset b off
sh /home/${USER}/.fehbg
xcompmgr -CcfF -I-.015 -O-.03 -D2 -t-1 -l-3 -r4.2 -o.5 &
redshift -l 57.29:53.64 -g 0.8 -m randr -v &
eval $(ssh-agent)
exec i3
