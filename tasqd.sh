TASQFILE='/tmp/tasq'
echo -n "" > "$TASQFILE"
LINELIMIT=64
while true
do
 TASQOUNT=0
 tail -f /tmp/tasq | while read LINE0
 do
  echo "> ${LINE0}";
  eval $LINE0
  ((TASQOUNT++))
  if [ "$TASQOUNT" -gt "$LINELIMIT" ]
  then
   LINESTART=$((TASQOUNT+1))
   tail -n "+$LINESTART" "$TASQFILE"  > "$TASQFILE.swp" && mv "$TASQFILE.swp" "$TASQFILE"
   break
  fi
 done
done
