# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn javax.lang.model.SourceVersion
-dontwarn javax.lang.model.element.Element
-dontwarn javax.lang.model.element.ElementKind
-dontwarn javax.lang.model.type.TypeMirror
-dontwarn javax.lang.model.type.TypeVisitor
-dontwarn javax.lang.model.util.SimpleTypeVisitor8
-keep class android.graphics.** { *; }
-keep class android.provider.MediaStore$Images$Media { *; }
-keep class android.media.ImageDecoder { *; }

-keep class com.google.mediapipe.** { *; }
-keep class com.google.mediapipe.tasks.** { *; }
-keep class com.google.mediapipe.framework.** { *; }

# Keep MediaPipe protobuf classes
-keep class com.google.mediapipe.proto.** { *; }

# Keep generated protobuf classes for Graph and Profile
-keep class com.google.mediapipe.proto.CalculatorProfileProto$CalculatorProfile { *; }
-keep class com.google.mediapipe.proto.GraphTemplateProto$CalculatorGraphTemplate { *; }

# Optional but safer
-keep class com.google.mediapipe.** { *; }
-keep class com.google.protobuf.** { *; }
-dontwarn com.google.protobuf.**

-dontwarn com.google.mediapipe.proto.CalculatorProfileProto$CalculatorProfile
-dontwarn com.google.mediapipe.proto.GraphTemplateProto$CalculatorGraphTemplate

# Keep MediaPipe core and task classes
-keep class com.google.mediapipe.** { *; }
-keep class com.google.mediapipe.tasks.** { *; }
-keep class com.google.mediapipe.framework.** { *; }
-keep class com.google.mediapipe.components.** { *; }

# Keep Protobuf classes used by MediaPipe
-keep class com.google.mediapipe.proto.** { *; }
-keep class com.google.protobuf.** { *; }
-dontwarn com.google.protobuf.**

# Specifically keep these missing classes
-keep class com.google.mediapipe.proto.CalculatorProfileProto$CalculatorProfile { *; }
-keep class com.google.mediapipe.proto.GraphTemplateProto$CalculatorGraphTemplate { *; }

# Keep task APIs and runtime
-keep class com.google.mediapipe.tasks.vision.facelandmarker.FaceLandmarker { *; }

# Keep all MediaPipe native classes
-keep class com.google.mediapipe.** { *; }

# Keep all protobuf-related classes
-keep class com.google.mediapipe.proto.** { *; }

# Keep JNI bindings
-keepclassmembers class * {
    native <methods>;
}

# Prevent obfuscation of TensorFlow Lite classes
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**

# Prevent stripping model files
-keep class **.tflite { *; }
-keep class **.task { *; }
-keep class **.lite { *; }

# MediaPipe core classes
-keep class com.google.mediapipe.framework.** { *; }
-keep class com.google.mediapipe.** { *; }

# Keep all native method bindings
-keepclassmembers class * {
    native <methods>;
}

# Keep protobuf used by MediaPipe
-keep class com.google.protobuf.** { *; }
-dontwarn com.google.protobuf.**

# Keep classes involved in the native stack resolution
-keep class R1.** { *; }
-dontwarn R1.**