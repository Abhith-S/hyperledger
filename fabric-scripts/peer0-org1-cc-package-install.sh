#!/bin/bash

peer lifecycle chaincode package basic.tar.gz --path ../Chaincode/chaincode-javascript/ --lang node --label basic_1.0

peer lifecycle chaincode install basic.tar.gz

peer lifecycle chaincode queryinstalled

