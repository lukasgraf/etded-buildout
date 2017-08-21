#!/bin/bash
# Wrapper script to start ET Legacy dedicated server with NQ mod and Omni-Bot

ETL_HOME="$HOME/etlegacy-server"

cd $ETL_HOME
./etlded +set sv_pure 1 +set fs_game nq +set omnibot_enable 1 +set omnibot_path "./legacy/omni-bot" +exec noquarter.cfg +exec server.cfg
