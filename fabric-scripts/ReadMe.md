NOTE : Run the scripts with ". " ie dot space and not "." ,eg ". start-ordererJoin.sh"

. start-ordererJoin.sh 

//open peer0-org1 terminal
. peer0-org1-join.sh

//open peer0-org2 terminal
. peer0-org2-join.sh

//peer0-org1 terminal
. peer0-org1-anchorUpdate.sh

//peer0-org2 terminal
. peer0-org2-anchorUpdate.sh

//peer0-org1 terminal
. peer0-org1-cc-package-install.sh

//peer0-org2 terminal
. peer0-org2-cc-install.sh


//peer0-org1 terminal
export CC_PACKAGE_ID=basic_1.0:d3ced865d65bb0db0980f7c27e023d7c8c7be01ebca4b37642b1447dd5873818

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID $CHANNEL_NAME --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent


//peer0-org2 terminal
export CC_PACKAGE_ID=basic_1.0:d3ced865d65bb0db0980f7c27e023d7c8c7be01ebca4b37642b1447dd5873818


peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID $CHANNEL_NAME --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent


//peer0-org1 terminal
. peer0-org1-cc-commit.sh

. cc-invoke-query.sh

//tear down neetwork
.neetworkDown.sh
