rm -f ~/test_output_collection.txt 
cd ~/indigo/
TESTTOTAL=500
echo "Total number of test runs is $TESTTOTAL" > ~/test_output_collection.txt
echo "Expansion Frequency(hz) Total-Time-Plan(s)" >> ~/test_output_collection.txt

for ((TCOUNT=1; TCOUNT<=$TESTTOTAL; TCOUNT++))
do
  echo $TCOUNT
  catkin_make run_tests_fetch_moveit_config_rostest_test_pick_place_sbpl.test > ~/test_temp_output.txt
  RESULTLine=`cat ~/test_temp_output.txt | sed -n 's/.*RESULT: \(\)/\1/p'`
  EXPANSIONSLine=`cat ~/test_temp_output.txt | sed -n 's/.*Expansions: \([1-9][0-9]*\).*Freq: \([0-9]*\.[0-9]*hz\)/\1/p'`
  FREQLine=`cat ~/test_temp_output.txt | sed -n 's/.*Expansions: \([1-9][0-9]*\).*Freq: \([0-9]*\.[0-9]*hz\)/\2/p'`
  TPTLine=`cat ~/test_temp_output.txt | sed -n 's/.*Total Planning Time: \([0-9]*\.[0-9]*\)/\1/p'`
  echo $RESULTLine
  echo $EXPANSIONSLine
  echo $FREQLine
  echo $TPTLine
  INDEX=0
  for EXPANSION in $EXPANSIONSLine
  do 
      echo $EXPANSION
      EXPANSIONS[$INDEX]=$EXPANSION
      INDEX=$((INDEX+1))
      #(( INDEX=1 + INDEX ))
  done
  INDEX=0
  for FREQ in $FREQLine
  do
      echo $FREQ
      FREQS[$INDEX]=$FREQ
      INDEX=$((INDEX+1))
      #(( INDEX=1 + INDEX ))
  done
  INDEX=0
  for TPT in $TPTLine
  do 
      echo $TPT
      TPTS[$INDEX]=$TPT
      INDEX=$((INDEX+1))
      #(( INDEX=1 + INDEX ))
  done
  echo $RESULTLine >> ~/test_output_collection.txt
  LCTotal=$INDEX
  INDEX=0
  for ((LCOUNT=1; LCOUNT<=$LCTotal; LCOUNT++))
  do
      
      echo "${EXPANSIONS[$INDEX]}       ${FREQS[$INDEX]}       ${TPTS[$INDEX]}"
      echo "${EXPANSIONS[$INDEX]}       ${FREQS[$INDEX]}       ${TPTS[$INDEX]}"  >> ~/test_output_collection.txt
      (( INDEX=1 + INDEX ))
  done
done
