package com.example.sic_app

import android.content.Context
import android.graphics.Bitmap
import android.graphics.ImageDecoder
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.ImageView.ScaleType
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import androidx.lifecycle.lifecycleScope
import coil.load
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.tasks.core.BaseOptions
import com.google.mediapipe.tasks.vision.core.RunningMode
import com.google.mediapipe.tasks.vision.facelandmarker.FaceLandmarker
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import android.util.Log
import java.io.File
import java.io.FileOutputStream
import java.io.FileInputStream
import java.nio.ByteBuffer

fun copyAssetToFile(context: Context, assetName: String): String {
    val file = File(context.filesDir, assetName)
    if (!file.exists()) {
        context.assets.open(assetName).use { input ->
            FileOutputStream(file).use { output ->
                input.copyTo(output)
            }
        }
    }
    return file.absolutePath
}

fun loadTaskFile(context: Context, assetName: String): ByteBuffer {
    val file = File(context.filesDir, assetName)
    if (!file.exists()) {
        context.assets.open(assetName).use { input ->
            FileOutputStream(file).use { output -> input.copyTo(output) }
        }
    }

    val inputStream = FileInputStream(file)
    val buffer = ByteBuffer.allocate(file.length().toInt())
    inputStream.channel.read(buffer)
    buffer.rewind()
    return buffer
}


class MyImageView(
    private val context: Context,
    id : Int,
    creationParams: Map<String?, Any?>?,
    private val activity: MainActivity
): PlatformView{

    private val constraintLayout: ConstraintLayout = ConstraintLayout(context)
    private val overlayView: OverlayView = OverlayView(context, null)
    private val imageView: ImageView = ImageView(context)


    private lateinit var faceLandmarker: FaceLandmarker

    override fun getView(): View {
        return constraintLayout
    }

    override fun dispose() {}

    init {
        try {
        val modelBuffer = loadTaskFile(context, "face_landmarker.task")
        Log.d("-5 ImageView ID", imageView.id.toString())
        val baseOptionsBuilder = BaseOptions.builder()
        Log.d("-4 ImageView ID", imageView.id.toString())
        baseOptionsBuilder.setModelAssetPath("face_landmarker.task")
        Log.d("-3 ImageView ID", imageView.id.toString())
        val baseOptions = baseOptionsBuilder.build()
        Log.d("-2 ImageView ID", imageView.id.toString())
        val optionsBuilder = FaceLandmarker.FaceLandmarkerOptions.builder()
            .setBaseOptions(baseOptions)
            .setMinFaceDetectionConfidence(0.5f)
            .setMinTrackingConfidence(0.5f)
            .setMinFacePresenceConfidence(0.5f)
            .setNumFaces(1)
            .setRunningMode(RunningMode.IMAGE)
        Log.d("-1 ImageView ID", imageView.id.toString())
        val options = optionsBuilder.build()
        Log.d("0 ImageView ID", imageView.id.toString())

            faceLandmarker = FaceLandmarker.createFromOptions(context, options)


        Log.d("1 ImageView ID", imageView.id.toString())
        } catch (e: Exception) {
            Log.e("FaceLandmarkerInit", "Failed to create FaceLandmarker", e)
        }

        constraintLayout.id = View.generateViewId()
        val layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.WRAP_CONTENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        constraintLayout.layoutParams = layoutParams

        Log.d("2 ImageView ID", imageView.id.toString())

        val constraintSet = ConstraintSet()
        constraintSet.clone(constraintLayout)

        Log.d("3 ImageView ID", imageView.id.toString())

        imageView.id = View.generateViewId()
        constraintLayout.addView(imageView)
        imageView.scaleType = ScaleType.FIT_XY
        constraintSet.constrainWidth(imageView.id, ConstraintSet.MATCH_CONSTRAINT)
        constraintSet.constrainHeight(imageView.id, ConstraintSet.MATCH_CONSTRAINT)
        constraintSet.connect(
            imageView.id,
            ConstraintSet.START,
            ConstraintSet.PARENT_ID,
            ConstraintSet.START
        )
        constraintSet.connect(
            imageView.id,
            ConstraintSet.TOP,
            ConstraintSet.PARENT_ID,
            ConstraintSet.TOP
        )
        constraintSet.connect(
            imageView.id,
            ConstraintSet.END,
            ConstraintSet.PARENT_ID,
            ConstraintSet.END
        )
        constraintSet.connect(
            imageView.id,
            ConstraintSet.BOTTOM,
            ConstraintSet.PARENT_ID,
            ConstraintSet.BOTTOM
        )
        
        Log.d("ImageView ID", imageView.id.toString())
        Log.d("BUddy ID", imageView.id.toString())

        overlayView.id = View.generateViewId()


        constraintSet.constrainWidth(overlayView.id, ConstraintSet.MATCH_CONSTRAINT)
        constraintSet.constrainHeight(overlayView.id, ConstraintSet.MATCH_CONSTRAINT)
        constraintSet.connect(
            imageView.id,
            ConstraintSet.START,
            ConstraintSet.PARENT_ID,
            ConstraintSet.START
        )
        constraintSet.connect(
            imageView.id,
            ConstraintSet.TOP,
            ConstraintSet.PARENT_ID,
            ConstraintSet.TOP
        )
        constraintSet.connect(
            imageView.id,
            ConstraintSet.END,
            ConstraintSet.PARENT_ID,
            ConstraintSet.END
        )
        constraintSet.connect(
            imageView.id,
            ConstraintSet.BOTTOM,
            ConstraintSet.PARENT_ID,
            ConstraintSet.BOTTOM
        )

        constraintSet.applyTo(constraintLayout)

        activity.lifecycleScope.launch {
            display(Uri.parse(creationParams?.get("imageUrl").toString()))
        }

        constraintLayout.addView(overlayView)

    }

    private suspend fun display(mediaUri: Uri) {
        withContext(Dispatchers.IO) {

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                val source = ImageDecoder.createSource(
                    context.contentResolver, mediaUri
                )
                ImageDecoder.decodeBitmap(source)
            } else{
                MediaStore.Images.Media.getBitmap(
                    context.contentResolver, mediaUri
                )
            }.copy(Bitmap.Config.ARGB_8888, true)?.let { bitmap ->

                val mpImage = BitmapImageBuilder(bitmap.scaleDown(512F)).build()
                
                
                val result = faceLandmarker?.detect(mpImage)
                
                result?.let { 
                    Log.d("Founddo", it.toString())
                    Log.d("Restulasdfasdf", result.toString())
                    overlayView.setResults(it, mpImage.height, mpImage.width)
                    Log.d("Restulasdfasdf", result.toString())
                }
                withContext(Dispatchers.Main){
                    imageView.load(bitmap)
                }
                Log.d("Angdrae key tae", result.toString())

            }
    }

}

private fun Bitmap.scaleDown(targetWidth: Float): Bitmap {

    if (targetWidth >= width) return this
        val scaleFactor = targetWidth / width
        return Bitmap.createScaledBitmap(
            this,
            (width * scaleFactor).toInt(),
            (height * scaleFactor).toInt(),
            false
        )
    }

}