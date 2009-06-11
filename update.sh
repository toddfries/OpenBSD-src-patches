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
        usr.sbin
do
	if ! [ -d $d/.git ]; then
		echo "$d/.git does not exist, skipping"
		continue
	fi
	echo "==> $d"
	(
		cd $d
		git pull
		git merge origin/master
	)
done 2>&1 | tee update.log
