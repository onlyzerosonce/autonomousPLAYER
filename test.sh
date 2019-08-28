
function delfirstandrefillifempty(){
sed -i '1d' .mplayer_delete_parent
[ ! -s .mplayer_delete_parent ]&&python readingcount.py
echo
}

delfirstandrefillifempty


