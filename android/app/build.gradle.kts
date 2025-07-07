import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.nulltron.aboappv4" // Ihr neuer Namespace
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    // Key-Properties laden
    val keyProperties = Properties()
    val keyPropertiesFile = rootProject.file("key.properties")
    val hasKeyProperties = keyPropertiesFile.exists()
    if (hasKeyProperties) {
        keyProperties.load(FileInputStream(keyPropertiesFile))
    }

    signingConfigs {
        if (hasKeyProperties) {
            create("release") {
                keyAlias = keyProperties["keyAlias"] as String?
                keyPassword = keyProperties["keyPassword"] as String?
                // Sicherere Zuweisung für die storeFile
                storeFile = if (keyProperties["storeFile"] != null) file(keyProperties["storeFile"] as String) else null
                storePassword = keyProperties["storePassword"] as String?
            }
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.nulltron.aboappv4" // Ihre neue Application ID
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            if (hasKeyProperties) {
                signingConfig = signingConfigs.getByName("release")
            }
            isMinifyEnabled = true
            isShrinkResources = true
            getDefaultProguardFile("proguard-android-optimize.txt")


        }
    }
}

flutter {
    source = "../.."
}