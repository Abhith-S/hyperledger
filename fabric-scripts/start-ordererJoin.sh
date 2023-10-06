#!/bin/bash

# Start the Certificate Authority container
docker-compose -f docker/docker-compose-ca.yaml up -d

# Change permissions recursively for 'organizations' directory
sudo chmod -R 777 organizations/

# Register and enroll identities using the 'registerEnroll.sh' script
./registerEnroll.sh

# Start the 2 organization network
docker-compose -f docker/docker-compose-2org.yaml up -d

# Set environment variables for Fabric configuration
export FABRIC_CFG_PATH=./config
export CHANNEL_NAME=mychannel

# Generate the channel configuration transaction
configtxgen -profile TwoOrgsApplicationGenesis -outputBlock ./channel-artifacts/${CHANNEL_NAME}.block -channelID $CHANNEL_NAME

#Joining orderer
export ORDERER_CA=./organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

export ORDERER_ADMIN_TLS_SIGN_CERT=./organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt

export ORDERER_ADMIN_TLS_PRIVATE_KEY=./organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

osnadmin channel join --channelID $CHANNEL_NAME --config-block ./channel-artifacts/$CHANNEL_NAME.block -o localhost:7053 --ca-file $ORDERER_CA --client-cert $ORDERER_ADMIN_TLS_SIGN_CERT --client-key $ORDERER_ADMIN_TLS_PRIVATE_KEY

osnadmin channel list -o localhost:7053 --ca-file $ORDERER_CA --client-cert $ORDERER_ADMIN_TLS_SIGN_CERT --client-key $ORDERER_ADMIN_TLS_PRIVATE_KEY

