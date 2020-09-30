if [ -n "$PS1" ]
then
	source ~/.bash_profile;
else
	[ -r ~/.path ] && [ -f ~/.path ] && source ~/.path;
fi
