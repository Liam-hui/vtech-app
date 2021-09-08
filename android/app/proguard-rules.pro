# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /home/asu/GeekLife/android-sdk-linux/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-keepattributes SourceFile,LineNumberTable

#-keep class com.baidu.** { *; }
#-keep class org.apache.** { *; }
#-keep class org.bouncycastle.** { *; }
#-keep class android.support** { *; }

#actionbar
-dontwarn com.actionbarsherlock.**
-keep public class com.actionbarsherlock.**{*;}
#viewpagerindicator
-dontwarn com.viewpagerindicator.**
-keep public class com.viewpagerindicator.**{*;}
#slidingmenu
-dontwarn com.jeremyfeinstein.slidingmenu.**
-keep public class com.jeremyfeinstein.slidingmenu.**{*;}

# Suppress warnings if you are NOT using IAP:
 -dontwarn com.baidu.**
 -dontwarn org.apache.**
 -dontwarn org.bouncycastle.**
 -dontwarn com.google.android.gms.**
 -dontwarn com.tencent.bugly.**
 -dontwarn java.nio.**
 -dontwarn org.codehaus.**

 -keep public class com.tencent.bugly.**{*;}

##########################################################################

-keep public class * extends android.app.Activity

-keep public class * extends android.app.Application

-keep public class * extends android.app.Service

-keep public class * extends android.content.BroadcastReceiver

-keep public class * extends android.content.ContentProvider

-keep public class * extends android.app.backup.BackupAgentHelper

-keep public class * extends android.preference.Preference

-keep public class com.android.vending.licensing.ILicensingService

-keepclasseswithmembers class * {
    public <init>(android.content.Context,android.util.AttributeSet);
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context,android.util.AttributeSet,int);
}

-keepclassmembers class * extends android.app.Activity {
    public void *(android.view.View);
}

-keep class * extends android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep - Library. Keep all public and protected classes, fields, and methods.
-keep public class * {
    public protected <fields>;
    public protected <methods>;
}

# Also keep - Enumerations. Keep the special static methods that are required in
# enumeration classes.
-keepclassmembers enum  * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep names - Native method names. Keep all native class/method names.
-keepclasseswithmembers class * {
    native <methods>;
}


# james2019oct21
# avoid 100% crash when Base64.encodeBase64() ( build by AS for windows only )
# https://gist.github.com/marshall/799497/f757d6f492fe57008efabdad6ae9bf9962913189
# https://github.com/krschultz/android-proguard-snippets/blob/master/libraries/proguard-square-okhttp.pro
# -keep class com.squareup.okhttp.** { *; }
# -keep interface com.squareup.okhttp.** { *; }
# -dontwarn com.squareup.okhttp.**
#
# -keep class org.apache.commons.codec.binary.Base64 { *; }
# -keep interface org.apache.commons.codec.binary.Base64 { *; }
# -dontwarn org.apache.commons.codec.binary.Base64
-keep class org.apache.commons.** { *; }
-keep interface org.apache.commons.** { *; }
-dontwarn org.apache.commons.**
# james2019oct21 -- end



-assumenosideeffects class android.util.Log {
  public static *** v(...);
  public static *** d(...);
  public static *** i(...);
#  public static *** w(...);
#  public static *** e(...);
}
# without the line below, the apk will crash when compiled from windows.MacOS was OK.
#-keep public class com.tutk.**{*;}

##############################################################################################

