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
		[ -d "$HOME/git/OpenBSD/$d.master/.git" ] && reference="--reference $HOME/git/OpenBSD/$d.master/.git"
		git clone $reference ssh://afs0.freedaemon.com/afs/freedaemon.com/code/OpenBSD/git/src/$d
	fi
	echo "==> $d"
	(
		cd $d
		git pull
		# Yes this might be redundant because we might be on master,
		# but no harm if it is, and easier than attempting to detect
		# master, let git deal with it
		git merge origin/master
	)
done 2>&1 | tee update.log
