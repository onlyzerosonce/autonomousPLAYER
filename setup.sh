cd .. 
cp -rf autonomousPLAYER/awesome .config/
cp -rf autonomousPLAYER/Thunar .config/
cp -rf autonomousPLAYER/terminator .config/
cp -f autonomousPLAYER/.bashrc "$HOME"
cp -f autonomousPLAYER/.bash_aliases "$HOME"
[ -f .readingstats ] && echo "Pages|Date|FileName">.readingstats

