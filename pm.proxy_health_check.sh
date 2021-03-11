(
	SCRIPT_DIR=`dirname $0`
        max=4
        SLEEP_T=$(bc <<< "scale=3;  ( 60 / $max )")s
        echo "$SLEEP_T `date`"
        for ((i=1; i<=$max; i++))
        do
                echo "check #$i quick white `date`"
                bash $SCRIPT_DIR/proxy_health_check.sh
                echo "check sleeping $SLEEP_T"
                sleep $SLEEP_T
        done
        set -e
        exit $?
)&

