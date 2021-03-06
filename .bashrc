
###########################
##########################
#how to clone on a new computer
#go to home
#git init .
#git remote add origin <repository-url>
#git pull origin master
##########################
###########################

###in this case, repository-url is https://github.com/jsartor7/bashrc


if [ -f .extrabashrc ]; then
	. .extrabashrc
fi

	# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsd='ls -ltr'

alias pdfview='xdg-open'

count_jobs()
{
gpuJobs=$(squeue -u $1 -t RUNNING | grep " gpu" | wc -l)
longgpuJobs=$(squeue -u $1 -t RUNNING | grep longgpu | wc -l)
totalUnits=$((2 * longgpuJobs + gpuJobs))
printf $gpuJobs" gpu jobs running\n"
printf $longgpuJobs" longgpu jobs running\n"
printf $totalUnits" total units running\n\n"
printf "queued jobs:\n"
squeue --Format=jobarrayid:22,partition:10,username:12,reasonlist -u $1 -t PENDING | grep gpu
}

alias squeue2='squeue --Format=jobarrayid:22,partition:10,username:12,timeused:14,reasonlist,name'
alias my_jobs='squeue2 | grep jsartor7'
alias gpu_jobs='squeue2 | grep gpu'
alias my_procs='ps -xau | grep jsartor7'

alias free='free -h'

alias mocorlab='sudo mount -t cifs -o username=jsartor7 //corwinlab.uoregon.edu/NFSHomes/jsartor7/Documents/data ~/Documents/corwinlabData/'



# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi





#################################custom stuff

#makes autocomplete for cd work right with symlinks
complete -rd cd
#makes autocomplete for cd only hit directories
#complete -d cd
#it seems like this is a pick one situation...

#autocomplete case insensitive is in ~/.inputrc

#https://superuser.com/questions/378018/how-can-i-do-ctrl-z-and-bg-in-one-keypress-to-make-process-continue-in-backgroun

#also this doesn't work
fancy-ctrl-z () {
  #if [[ $#BUFFER -eq 0 ]]; then
    bg
    #zle redisplay

  #else
    #zle push-input
  #fi
}
#zle -N fancy-ctrl-z
bind '"^Z":"fancy-ctrl-z"'

#should put in aliases
sbc () {
    source ~/.bashrc
}

#makes cd * work, email from eric
cd(){ builtin cd "${@:1:1}"; }

alias ssh='ssh -Y'
alias cprd='cp_and_rename_dirs'
alias rm_newlines='sed -i -e '\''/^\s*$/d'\'''
alias talapas='ssh talapas-login.uoregon.edu'
alias mantid='ssh mantid.uoregon.edu'
alias phasmid='ssh phasmid.uoregon.edu'
alias ant='ssh ant.uoregon.edu'
alias hellgrammite='ssh hellgrammite.uoregon.edu'
alias docker='sudo docker'

alias python='python -u'

#just let's get those flags in there
alias rsync='rsync -rltvPh'
alias rsync='rsync -rltvPhe "ssh -T -o Compression=no -x -c aes128-gcm@openssh.com" -a --info=progress2 '

#pipe errors and output to dev/null
alias spotify='spotify &>/dev/null &'
alias firefox='firefox &>/dev/null &'

#this might cause problems sometime when i'm trying to run matlab
#from command line 
#alias matlab='matlab &>/dev/null &'

alias cdn='cd_nth_dir'
alias cd2='cdn 2'
alias cd*='cdn 1'

alias cddata='cd ~/Documents/data'
alias cdphsf='cd ~/Documents/code/pcpAnalysis/hyperstaticForces'
alias cdmhsf='cd ~/Documents/MATLAB/highD/hyperStaticForces'
alias cdimp='cd ~/Documents/code/pyCudaPacking/pyCudaPacking/packingMixins'

alias count='ls | wc -l'
alias ebc='emacs ~/.bashrc &'

cd_nth_dir() {
    a=`ls | head -n $1 | tail -1`
    cd $a
}

cp_and_clean() {
    MYPWD=${PWD}
    rsync -rltv ~/Documents/corwinlabData/pressureBins/ ~/Documents/data/pressureBins/
    cd ~/Documents/data/pressureBins
    rmdir */*/*/*
    cd $MYPWD
}

checkNumAtParticularE() {
    b=$1
    a='find -name scalars.dat | xargs grep "excessContacts\s $1 $" | wc -l'
    echo $a
}

alias cu='check_up'
alias finished='check_up | grep " 0" | wc -l'

check_up () {

    MYPWD=${PWD}

    for d in `ls | sort -V` ;
    do
	a=`echo $d`
	cd $d
	cd *
	b=`cat scalars.dat | grep excess`
	echo $a : $b
	cd $MYPWD
    done
	
    }

grab_cecco_shit () {

    MYPWD=${PWD}

    for d in `ls | sort -V` ;
    do
	cd $d
	ls | sort -V | head -1 | xargs -i cp -r '{}' ../testDir/$d
	cd $MYPWD
    done
	
    }

cp_and_rename_dirs () {

    #full path
    MYPWD=${PWD}  #or MYPWD=$(pwd)
    #current directory name
    dirname=${PWD##*/}
    
    for d in ./*/ ;
    do
	if [ ! -d "../working/$dirname/$d" ]; then
  	echo "doing directory: $d"
	cp -r $d ../working/$dirname
	cd ../working/$dirname/$d
	replace_dirs_with_excess_dirs
	cd $MYPWD
	fi
    done
	
    }


#helper function, do not use
replace_dir_with_excess_dir() {

    a=`ls *stable* | sed 's/\..*//' | sed 's/.*-//'`         # Assigns result of 'ls -l' command to 'a'
    a=$a"excess"


    if [ ! -d "../$a" ]; then
	mkdir "../$a"
	mv * "../$a"
    else

    b=1

    for d in .././*/ ;
    do
	if [[ $d =~ $a.* ]]
	then
	    let b+=1
	fi
    done
    
     mkdir "../$a$b"
     mv * "../$a$b"
    fi
    
}

#helper function, do not use
replace_dirs_with_excess_dirs () {

    for d in ./*/ ;
    do
	if [[ ! $d =~ .*excess.* ]]
	then
	    cd $d
	    replace_dir_with_excess_dir $d
	    cd ..
	    #rm -r $d > /dev/null 2>&1
	fi


	
    done
    #would be better here to individually remove
    rmdir * > /dev/null 2>&1
}



scp_remote_stuff() {
scp -r james@hellgrammite.uoregon.edu:/home/james/Documents/code/*/*/pressuresweep* . 
}



#helper function, do not use
fix_random_broken_shit () {

    b=1
    for d in ./*/ ;
    do
	mv $d "../pressuresweep$b"
	let b+=1
    done
}

module load cuda/8.0

PROMPT_COMMAND='history -a'



#be careful here, this code is garbage
stress_test_talapas_2 () {

    MYPWD=${PWD}  #or MYPWD=$(pwd)
    cd ~/Documents/data/100steps/5D/4096
    rm */timestamp.txt
    cd ~/Documents/code/pcpAnalysis/hyperstaticForces
    for i in {0..15}; do
	nohup python3 generatePressureSweeps.py 6 8192 100 $i &
	sleep 0.1
    done
    cd $MYPWD
}

find_most_recent_modified_file() {

    find . -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "

}

all_temps() {
    nvidia-smi -q -d temperature | grep GPU\ Current\ Temp
    
}

store_temp_data2() {
    while true; do
	date >> ~/tempData/tempData.txt
	nvidia-smi --query-gpu=serial,temperature.gpu,clocks.sm,clocks_throttle_reasons.hw_slowdown --format=csv >> ~/tempData/tempData.txt
	echo "logged"
    sleep 120
    done

}
