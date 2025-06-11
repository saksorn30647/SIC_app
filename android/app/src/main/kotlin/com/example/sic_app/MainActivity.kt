package com.example.sic_app

import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.provider.MediaStore
import android.util.Log
import androidx.activity.result.contract.ActivityResultContracts
import androidx.lifecycle.lifecycleScope
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : FlutterFragmentActivity() {
    private lateinit var methodChannelResult: MethodChannel.Result

    private val getContent =
            registerForActivityResult(ActivityResultContracts.OpenDocument()) { uri: Uri? ->
                lifecycleScope.launch {
                    withContext(Dispatchers.IO) {
                        uri?.let { mediaUri -> methodChannelResult.success("$mediaUri") }
                    }
                }
            }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        Log.d("Buddy MainActivity 0", "Buddy")
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.platformViewsController.registry.registerViewFactory(
                "myImageView",
                MyImageViewFactory(this)
        )
        Log.d("Buddy MainActivity 1", "Buddy")
        TFLiteSingleton.init(assets, flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "pickImagePlatform")
                .setMethodCallHandler { call, result ->
                    methodChannelResult = result
                    when (call.method) {
                        "pickImage" -> {
                            getContent.launch(arrayOf("image/*"))
                        }
                        "openCamera" -> {
                            val contentValues =
                                    ContentValues().apply {
                                        put(
                                                MediaStore.Images.Media.DISPLAY_NAME,
                                                "IMG_${System.currentTimeMillis()}.jpg"
                                        )
                                        put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg")
                                        put(MediaStore.Images.Media.RELATIVE_PATH, "DCIM/Camera")
                                    }
                            val uri: Uri? =
                                    contentResolver.insert(
                                            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                                            contentValues
                                    )

                            val intent =
                                    Intent(MediaStore.ACTION_IMAGE_CAPTURE).apply {
                                        putExtra(MediaStore.EXTRA_OUTPUT, uri)
                                    }
                            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                            try {
                                startActivity(intent)
                                result.success(null)
                            } catch (e: Exception) {
                                result.error(
                                        "UNAVAILABLE",
                                        "Camera app could not be opened",
                                        e.message
                                )
                            }
                        }
                        else -> {
                            result.notImplemented()
                        }
                    }
                }
    }
}
