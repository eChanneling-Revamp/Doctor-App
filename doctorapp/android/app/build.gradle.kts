plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // Flutter Gradle plugin must come last
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.doctorapp"

    // Use highest compile SDK required by plugins
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.doctorapp"
        minSdk = flutter.minSdkVersion
    targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    compileOptions {
        // ✅ Use Java 17 to avoid obsolete Java 8 warnings
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        release {
            // Keep using debug signing for now (you can change later)
            signingConfig = signingConfigs.getByName("debug")
            // Resource shrinking requires code shrinking; keep both off for now
            isMinifyEnabled = false
            isShrinkResources = false
        }
        debug {
            isDebuggable = true
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    packaging {
        resources {
            excludes += setOf("META-INF/LICENSE*", "META-INF/NOTICE*")
        }
    }
}

flutter {
    source = "../.."
}
