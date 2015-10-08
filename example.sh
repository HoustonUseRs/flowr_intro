echo 'Hello World !'

sleep 5
sleep 5

cat $RANDOM > tmp1
cat $RANDOM > tmp2

cat tmp1 tmp2 > tmp

du -sh tmp

