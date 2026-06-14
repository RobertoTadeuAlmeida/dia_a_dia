plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.diaadia.dia_a_dia"
    compileSdk = 36                          // ← substituiu flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"             // ← substituiu flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(
                org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
            )
        }
    }

    defaultConfig {
        applicationId = "com.diaadia.dia_a_dia"
        minSdk = 23                          // ← substituiu flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion // ← esse pode manter
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}