
package com.example.sic_app

/*
 * Copyright 2023 The TensorFlow Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *             http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.util.AttributeSet
import android.view.View
import androidx.core.content.ContextCompat
import com.google.mediapipe.tasks.components.containers.NormalizedLandmark
import com.google.mediapipe.tasks.vision.core.RunningMode
import com.google.mediapipe.tasks.vision.facelandmarker.FaceLandmarker
import com.google.mediapipe.tasks.vision.facelandmarker.FaceLandmarkerResult
import kotlin.math.max
import kotlin.math.min
import android.util.Log
import java.nio.ByteBuffer
import java.nio.ByteOrder


class OverlayView(context: Context, attrs: AttributeSet?) : View(context, attrs) {

    private var results: FaceLandmarkerResult? = null
    private var linePaint = Paint()
    private var pointPaint = Paint()

    private var scaleFactor: Float = 1f
    private var imageWidth: Int = 1
    private var imageHeight: Int = 1

    init {
        Log.d("init", "canvas")
        initPaints()
        invalidate()
    }

    fun clear() {
        Log.d("clear", "canvas")
        results = null
        linePaint.reset()
        pointPaint.reset()
        initPaints()
        invalidate()
    }

    private fun initPaints() {
        Log.d("initPaints", "canvas")
        linePaint.color = Color.RED
        linePaint.strokeWidth = LANDMARK_STROKE_WIDTH
        linePaint.style = Paint.Style.STROKE

        pointPaint.color = Color.YELLOW
        pointPaint.strokeWidth = LANDMARK_STROKE_WIDTH
        pointPaint.style = Paint.Style.FILL
    }

    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)
        Log.d("onDraw", "canvas")

        if (results == null || results!!.faceLandmarks().isEmpty()) {
            Log.d("OverlayView", "No landmarks found.")
            return
        }

        val scaledImageWidth = imageWidth * scaleFactor
        val scaledImageHeight = imageHeight * scaleFactor
        val offsetX = (width - scaledImageWidth) / 2f
        val offsetY = (height - scaledImageHeight) / 2f

        results?.faceLandmarks()?.forEach { faceLandmarks ->
            drawFaceLandmarks(canvas, faceLandmarks, offsetX, offsetY)
            drawFaceConnectors(canvas, faceLandmarks, offsetX, offsetY)
            val inputBuffer = ByteBuffer.allocateDirect(1434 * 4)
            inputBuffer.order(ByteOrder.nativeOrder())
            for (faceLandmark in faceLandmarks) {
                Log.d("Buddy LandmarksX", faceLandmark.x().toString())
                inputBuffer.putFloat(faceLandmark.x())
                Log.d("Buddy LandmarksY", faceLandmark.y().toString())
                inputBuffer.putFloat(faceLandmark.y())
                Log.d("Buddy LandmarksZ", faceLandmark.z().toString())
                inputBuffer.putFloat(faceLandmark.z())
            }

           Log.d("Buddy All Landmarks", faceLandmarks.toString())

            Log.d("Buddy InputBuffer", inputBuffer[0].toString())

            val outputSize = 2
            val outputBuffer = ByteBuffer.allocateDirect(outputSize * 4)
            outputBuffer.order(ByteOrder.nativeOrder())

            inputBuffer.rewind() // Reset position to 0 before reading
            TFLiteSingleton.interpreter?.run(inputBuffer, outputBuffer)
            outputBuffer.rewind() // Reset position to 0 before reading

            val outputArray = FloatArray(outputSize)
            for (i in 0 until outputSize) {
                outputArray[i] = outputBuffer.getFloat()
                Log.d("Buddy Output", outputArray[i].toString())
            }

            TFLiteSingleton.predictResult(outputArray[0])

        }

    }

    /**
     * Draws all landmarks for a single face on the canvas.
     */
    private fun drawFaceLandmarks(
        canvas: Canvas,
        faceLandmarks: List<NormalizedLandmark>,
        offsetX: Float,
        offsetY: Float
    ) {
        Log.d("drawFaceLandmarks", "faceLandmarks")
        faceLandmarks.forEach { landmark ->
            val x = landmark.x() * imageWidth * scaleFactor + offsetX
            val y = landmark.y() * imageHeight * scaleFactor + offsetY
            canvas.drawPoint(x, y, pointPaint)
        }
    }

    /**
     * Draws all the connectors between landmarks for a single face on the canvas.
     */
    private fun drawFaceConnectors(
        canvas: Canvas,
        faceLandmarks: List<NormalizedLandmark>,
        offsetX: Float,
        offsetY: Float
    ) {
        Log.d("drawFaceConnectors", "results" )
        FaceLandmarker.FACE_LANDMARKS_CONNECTORS.filterNotNull().forEach { connector ->
            val startLandmark = faceLandmarks.getOrNull(connector.start())
            val endLandmark = faceLandmarks.getOrNull(connector.end())

            if (startLandmark != null && endLandmark != null) {
                val startX = startLandmark.x() * imageWidth * scaleFactor + offsetX
                val startY = startLandmark.y() * imageHeight * scaleFactor + offsetY
                val endX = endLandmark.x() * imageWidth * scaleFactor + offsetX
                val endY = endLandmark.y() * imageHeight * scaleFactor + offsetY

                canvas.drawLine(startX, startY, endX, endY, linePaint)
            }
        }
    }

    fun setResults(
        faceLandmarkerResults: FaceLandmarkerResult,
        imageHeight: Int,
        imageWidth: Int,
        runningMode: RunningMode = RunningMode.IMAGE
    ) {
        results = faceLandmarkerResults

        this.imageHeight = imageHeight
        this.imageWidth = imageWidth
        
        Log.d("imageHeight", imageHeight.toString())
        Log.d("results 1123", results.toString())

        scaleFactor = when (runningMode) {
            RunningMode.IMAGE,
            RunningMode.VIDEO -> {
                min(width * 1f / imageWidth, height * 1f / imageHeight)
            }
            RunningMode.LIVE_STREAM -> {
                // PreviewView is in FILL_START mode. So we need to scale up the
                // landmarks to match with the size that the captured images will be
                // displayed.
                max(width * 1f / imageWidth, height * 1f / imageHeight)
            }
        }
        Log.d("scaleFactor", scaleFactor.toString())
        invalidate()
    }

    companion object {
        private const val LANDMARK_STROKE_WIDTH = 8F
        private const val TAG = "Face Landmarker Overlay"
    }
}
