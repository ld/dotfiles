# ~/.bash_profile
# https://gist.github.com/hxx/52f420798ee88009cf32#file-set_iterm2_tab_color-sh

function cd {
	# actually change the directory with all args passed to the function
	builtin cd "$@"

	auto_set_tab_chrome_background_color;
}

function auto_set_tab_chrome_background_color {
	RR=`pwd | wc -m`
	let RR=(RR%25)\*10

	GG=`basename \`pwd\` | wc -m`
	let GG=(GG%25)\*10\*2

	BB=`ls | wc -l`
	let BB=(BB%25)*\10

	# start to set background color of tab chrome
	# Documents: http://iterm2.com/documentation-escape-codes.html
	echo -en "\033]6;1;bg;red;brightness;${RR}\a"         # -n: ignore newline
	echo -en "\033]6;1;bg;green;brightness;${GG}\a"
	echo -en "\033]6;1;bg;blue;brightness;${BB}\a"
}

auto_set_tab_chrome_background_color;
