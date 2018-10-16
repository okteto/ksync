#!/bin/bash

plist=$HOME/Library/LaunchAgents/ksync.plist
launchctl unload -w $plist
mkdir -p $HOME/Library/Logs/ksync
group=$(id -g -n)

cat << EOF > $plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
            <key>Label</key>
            <string>ksync</string>
            
            <key>EnvironmentVariables</key>
            <dict>
            <key>HOME</key>
            <string>$HOME</string>
            </dict>

            <key>ProgramArguments</key>
            <array>
                <string>/usr/local/bin/ksync</string>
                <string>watch</string>
                <string>--log-level=debug</string>
            </array>
            
            <key>KeepAlive</key>
            <true/>

            <key>UserName</key>
            <string>$USER</string>
            <key>GroupName</key>
            <string>$group</string>

            <key>StandardErrorPath</key>
            <string>$HOME/Library/Logs/ksync/ksync.err.log</string>
            
            <key>StandardOutPath</key>
            <string>$HOME/Library/Logs/ksync/ksync.log</string>
    </dict>
</plist>
EOF
launchctl load -w $plist
launchctl start -w $plist