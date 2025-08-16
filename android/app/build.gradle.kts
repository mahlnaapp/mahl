plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.mahlnaaapp"
    compileSdk = 35  // تم رفعه إلى 35 على الأقل
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.mahlnaaapp"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true // مفيد جدًا في حال كثرة التبعيات
    }

    compileOptions {
        isCoreLibraryDesugaringEnabled = true // تمكين desugaring
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.window:window:1.0.0") // اختياري: لحل مشاكل Android 12L+ إن ظهرت
    implementation("androidx.window:window-java:1.0.0")
}

flutter {
    source = "../.."
}
