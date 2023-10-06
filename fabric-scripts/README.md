# Steps to create a hyperledger fabric network with 2 Organisations

**NOTE : Run the scripts with ". " ie dot space and not "." ,eg ". start-ordererJoin.sh"**

## Start the CA, Peers, Orderer, & Create Channel
`. start-ordererJoin.sh`

## Join peer to channel
### open a new terminal for peer0 of org1
`. peer0-org1-join.sh`

### open a new terminal for peer0 of org2
`. peer0-org2-join.sh`

## Anchor Peer Update
### In peer0-org1 terminal
`. peer0-org1-anchorUpdate.sh`

### In peer0-org2 terminal
`. peer0-org2-anchorUpdate.sh`

## Install Chaincode
### In peer0-org1 terminal
`. peer0-org1-cc-package-install.sh`

### In peer0-org2 terminal
`. peer0-org2-cc-install.sh`

## Approve Chaincode
### In peer0-org1 terminal
`export CC_PACKAGE_ID=add your package id here`


`peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID $CHANNEL_NAME --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent`

### In peer0-org2 terminal
`export CC_PACKAGE_ID=add your package id here`


`peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID $CHANNEL_NAME --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent`

## Commit Chaincode
### In peer0-org1 terminal
`. peer0-org1-cc-commit.sh`

# Invoke and Query chaincode
`. cc-invoke-query.sh`

## Tear down th Ntwork
`.networkDown.sh`
