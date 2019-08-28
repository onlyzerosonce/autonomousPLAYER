for i in `seq 1 1 20`
do
zenity --notification --text="Shutdown has been sheduled."
sleep 1s
done
sudo shutdown -h 1
