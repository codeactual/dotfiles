echo "Loading $0"

alias adb-restart="adb kill-server && adb start-server"
alias android-start-avd="emulator -verbose -avd" # android-start-avd <name>
alias android-keygen-debug="keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64"
