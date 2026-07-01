# Dio / OkHttp
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class okio.** { *; }
-dontwarn okio.**
-keep class io.flutter.plugins.** { *; }

# Keep Dio internal classes
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**