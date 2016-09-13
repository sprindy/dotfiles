# dotfiles
Manage sprindy's dotfiles/config 

# init git
$ git init
$ git config --global user.name "sprindy"
$ git config --global user.email  "sprindy.liu@gmail.com"
$ git remote add origin git@github.com:sprindy/dotfiles.git
$ git branch --set-upstream-to=origin/master 
Branch master set up to track remote branch master from origin.

# what need to sync:
1. Initializing a Build Environment in Ubuntu
	init_build_env.sh

2. ~/.bashrc
	export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/java

	JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
	export JRE_HOME=$JAVA_HOME/jre
	export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
	export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

3. /etc/fstab
	UUID=29e41a94-1b6d-424f-adb4-f92f55bc27bb /home/sprindy/su            ext4    defaults              0       3

4. smb
   # etc/samba/smb.conf

5. git-temp, git config
	# .git-template
	git commit --template=.git-template

	# .git/config
	[core]
		repositoryformatversion = 0
		filemode = true
		bare = false
		logallrefupdates = true
	[remote "origin"]
		url = git@github.com:sprindy/dotfiles.git
		fetch = +refs/heads/*:refs/remotes/origin/*
	[branch "master"]
		remote = origin
		merge = refs/heads/master
