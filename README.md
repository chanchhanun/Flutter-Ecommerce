signingConfigs {
    debug {
        keyAlias 'key'
        keyPassword '123456'
        storeFile file('key.jks')
        storePassword '123456'
    }
}

keytool -genkeypair -v -keystore mykey.jks -keyalg RSA -keysize 2048 -validity 10000 -alias mykey

cd android
./gradlew signingReport

// GoogleSignInService does not work 
