import io.flutter.embedding.engine.FlutterEngine
import TFLiteHelper.loadModelFile
import android.content.res.AssetManager
import org.tensorflow.lite.Interpreter
import java.io.IOException
import io.flutter.plugin.common.MethodChannel
import android.util.Log

object TFLiteSingleton {
    var interpreter: Interpreter? = null
        private set
        
    private val PREDICT_RESULT_CHANNEL = "aicanseeyourstroke.com/predictResultPlatform"
    private lateinit var channel: MethodChannel

    @Throws(IOException::class)
    fun init(assetManager: AssetManager, flutterEngine: FlutterEngine) {
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PREDICT_RESULT_CHANNEL)
        if (interpreter == null) {
            val model = loadModelFile(assetManager, "converted_model3.tflite")
            Log.d("TFLiteSingleton", "model3")
            interpreter = Interpreter(model)
        }
    }
    
    fun predictResult(result: Number) {
        Log.d("TFLiteSingleton", "Predict result: $result")
        channel.invokeMethod("predictResult", result)
    }
}