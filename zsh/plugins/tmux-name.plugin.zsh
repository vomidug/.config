curname=$(tmux list-windows | grep -i active | cut -d '*' -f1 | cut -d ' ' -f2)
if [ $curname = "prod" ]; then
	ssh prod;
fi
if [ $curname = "peka" ]; then
	ssh peka;
fi
