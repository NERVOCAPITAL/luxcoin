#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install libxcb-xinerama0 -y

cd $HOME

wget "https://dl.walletbuilders.com/download?customer=6e4be984674e9707db44047cec2a86377a6006920eceb41639&filename=luxcoin-qt-linux.tar.gz" -O luxcoin-qt-linux.tar.gz

mkdir $HOME/Desktop/Luxcoin

tar -xzvf luxcoin-qt-linux.tar.gz --directory $HOME/Desktop/Luxcoin

mkdir $HOME/.luxcoin

cat << EOF > $HOME/.luxcoin/luxcoin.conf
rpcuser=rpc_luxcoin
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node3.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/Luxcoin/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./luxcoin-qt
EOF

chmod +x $HOME/Desktop/Luxcoin/start_wallet.sh

cat << EOF > $HOME/Desktop/Luxcoin/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
while :
do
./luxcoin-cli generatetoaddress 1 \$(./luxcoin-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/Luxcoin/mine.sh
    
exec $HOME/Desktop/Luxcoin/luxcoin-qt &

sleep 15

exec $HOME/Desktop/Luxcoin/luxcoin-cli -named createwallet wallet_name="" &
    
sleep 15

cd $HOME/Desktop/Luxcoin/

clear

exec $HOME/Desktop/Luxcoin/mine.sh