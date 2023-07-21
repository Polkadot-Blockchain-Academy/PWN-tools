#!/bin/bash
######################################################################
# Polkadot Blockchain Academy Proof-of-Winning tools
# Generate `proof-of-winning.json` payload
#
# For subkey and raw messages
# 
# Polkadot Blockchain Academy - UNLICENSE - 2023-02-01
# #####################################################################

clear
echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -e "                  Make sure to read and understand what this script does before you use it!"
echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
echo -e " Dependencies:\n"
echo -e " - sha512sum (OS package manager): https://unix.stackexchange.com/questions/426837/no-sha256sum-in-macos"
echo -e " - subkey (cargo): https://github.com/paritytech/substrate/tree/master/bin/utils/subkey#install-with-cargo"
echo -e " - jq (OS package manager): https://stedolan.github.io/jq/\n"

echo -en "                                     👌 Press [ENTER] to start..."
read -s START
clear

echo -e "//////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e "////////////////           ///////////////////////////////////////////////////////////////////////////////"
echo -e "//////////////               /////////////////////////////////////////////////////////////////////////////"
echo -e "////////    ////           ////    ////////////////////////////////*  *///////////////////////////////////"
echo -e "/////        /////////////////        ////////////////////////////.   ,///////////////////////***/////////"
echo -e "////         /////////////////          /////////////////////////*    ///////////////////////.   ,////////"
echo -e "///         ////////////////////        /////////////////////////.   ,//////////////////////*.   /////////"
echo -e "///      /////////////////////////      //////////////*             .//////*.         .*//*           *///"
echo -e "////////////////////////////////////////////////////,.   .,,**,.    ,///*,    .,,,.    ***,.    ,,,,,*////"
echo -e "/////  ///////////////////////////////////////////*.   ,*//////,   ,*//*    *//////,   ,//*.   ,//////////"
echo -e "///       ///////////////////////       /////////*.   *///////,    *//*    *///////,   ,//*   .///////////"
echo -e "///         ///////////////////         ////////*     ///////,    .*//,   .///////,    */*.   ,/////**////"
echo -e "////         /////////////////         /////////*     ,///*,.     ,**,     *////*.   .///*.   ,//*.   ,///"
echo -e "//////       /////////////////       ////////////,.         ,,       .,.           ,*/////,         .*////"
echo -e "///////////////             ////////////////////////**,,,,,*///*,,,,*/////*,,,,**///////////*,,,,**///////"
echo -e "///////////////             //////////////////////////////////////////////////////////////////////////////"
echo -e "//////////////////       /////////////////////////////////////////////////////////////////////////////////"
echo -e "//////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "==========================================================================================================\n"
echo -e "                           🎉🔐🔏 Blockchain Academy Proof-of-Win (PWN) 🔏🔐🎉\n"
echo -e "==========================================================================================================\n"
echo -e "                                         This script processes a:"
echo -e "                                            - ⚠PRIVATE  KEY⚠"
echo -e "                              *without* writing them to disk or terminal history.\n"
echo -e "                               It outputs a \"PWN-<your address>.json\" to submit"
echo -e "                                      to the Academy team to verify 🕵️\n"
echo -e "                             You could use any Substrate compatible wallet to sign,"
echo -e "                            and instead use the \"generate-proof-of-win-signature.sh\"\n"

echo -e "  🕸️ The network for the SS58 address (polkadot, kusama, some parachain...): "
read NETWORK

# debug, uncomment to override:
# NETWORK="kusama"

echo -e "  📝 A public, pseudononymous, message for the Academy class (any text, without \"quotes\"):\n" 
read MESSAGE

# debug, uncomment to override:
# using Polkadot JS API/Apps, wrapped because https://github.com/polkadot-js/apps/issues/8930
# MESSAGE=<Bytes>I LIKE WINNING! BOOOOO YAAAAAA!</Bytes>
# Using subkey, raw message
# MESSAGE="I LIKE WINNING! BOOOOO YAAAAAA!"

echo -e "  🔑 Your PRIVATE KEY (hex encoding *or* mnemonic & derived path)"
echo -en "  💸 THE PRIZE WILL BE SENT HERE (0x..... *or* [12|24 words here]//HD-Wallet///Path): <hidden input>"
read -s PRIVKEY

# debug, uncomment to override:
# PRIVKEY="middle harsh axis absurd message meadow kick soccer empty left adult giraffe"
# HD path works, but not used in most wallets 😭 :
# PRIVKEY="middle harsh axis absurd message meadow kick soccer empty left adult giraffe//some///path"

# subkey needs an sURI = address SS58 or pubkey-hex or privkey-hex
PUBKEY="$(subkey inspect "$PRIVKEY" --network "$NETWORK" --output-type json | jq '.publicKey' -rj)"
ADDRESS="$(subkey inspect "$PRIVKEY" --network "$NETWORK" --output-type json | jq '.ss58Address' -rj)"


echo -en "\n\n      🙋 Your Public Key (sr25519) = $PUBKEY"
echo -e "\n\n      🙋 Your Address (SS58) for $NETWORK = $ADDRESS"
echo -e "       👀 !!!!!!! BE SURE THESE ARE AS YOU EXPECT !!!!!!!\n\n"

echo -e "                 👌 Press [ENTER] to continue..."
read -s CONTINUE

# Sign your provided message username (only)
SIGNATURE="$(subkey sign --suri "$PRIVKEY" --message "$MESSAGE")"

# DELETE PRIVKEY
unset PRIVKEY

FILE="PWN-""$ADDRESS"".json"

echo -e "\n\n                    👇 🔐 $FILE 🔐 👇"

# Write PWN-$ADDRESS.json
jq -n --arg message "$MESSAGE" --arg ss58Address "$ADDRESS" --arg signature "$SIGNATURE" '.message = $message | .ss58Address = $ss58Address | .signature = $signature' > $FILE

jq < $FILE

echo -e "                   📬 Deliver $FILE 📬"
echo -e "                   The Academy team will provide a link to upload or paste this json into.\n"
echo -en "                                 🗑 Press [ENTER] to clear the screen..."
read -s LESS
clear
echo -en "\n\n\n\n                                        Less Trust.\n"
read -s MORE
echo -e           "                                        More Truth.\n\n\n\n"
read -s MIC_DROP

# debug, no HD path, most wallets:
# {
#   "message": "I LIKE WINNING! BOOOOO YAAAAAA!",
#   "ss58Address": "14XeJg226wvHG6PWmhKUsrv5PmeccjbXwFe9pVrBbryEWeZc",
#   "signature": "0x683dc112821364f6201f5e6c231a156ae8a4bc10a931972825543c6e8f273e47b271756d70366ba154fb29ea15360d3210f8e05951d64dd27518c8fd3476a587"
# } 
# Tested to verify correctly on https://polkadot.js.org/apps/#/signing/verify
# Also another good signature:
# "0x3ef12aa93dc7eca7d60616f9b2535f967c202ba77ca80451847d528025bde836280744bf9ca643413c93ce3702841414ef5b9ff4d0bb9c63f1b48dc0a2e6ff8e"

# debug, HD "//some///path":
# {
#   "message": "I LIKE WINNING! BOOOOO YAAAAAA!",
#   "ss58Address": "14VJA6QWfE7iEXsvrcE8vmF5wnEqEfimG8s35VfWU1TJYPVR",
#   "signature": "0xde6b453a72d65de1661305af10595c9126e72bc75a475d299635229bc69ac20e3aff52e0cb5c8059224f16d2231ede92e8ff37d3739099d9fe20df0c0863bb84"
# }