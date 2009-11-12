for d in \
        etc \
        include \
        libexec \
        bin \
        sbin \
        sys \
        distrib \
        games \
        gnu \
        kerberosV \
        lib \
        share \
        . \
        usr.bin \
        usr.sbin \
	regress
do
	if ! [ -d $d/.git ]; then
		if [ -d $d ]; then
			echo "$d/.git does not exist, skipping"
			continue
		fi
		reference=""
		[ -d "$HOME/git/OpenBSD/$d.master" ] && reference="--reference $HOME/git/OpenBSD/$d.master"
		git clone $reference ssh://afs0.freedaemon.com/afs/freedaemon.com/code/OpenBSD/git/src/$d
	fi
	echo "==> $d"
	(
		cd $d
		git pull
		git merge origin/master
	)
done 2>&1 | tee update.log
