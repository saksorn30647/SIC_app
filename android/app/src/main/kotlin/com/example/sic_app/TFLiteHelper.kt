import android.content.res.AssetManager
import org.tensorflow.lite.Interpreter
import java.io.FileInputStream
import java.io.IOException
import java.nio.MappedByteBuffer
import java.nio.channels.FileChannel

object TFLiteHelper {
    @Throws(IOException::class)
    fun loadModelFile(assetManager: AssetManager, modelFilename: String): MappedByteBuffer {
        val fileDescriptor = assetManager.openFd(modelFilename)
        val inputStream = FileInputStream(fileDescriptor.fileDescriptor)
        val fileChannel = inputStream.channel
        val startOffset = fileDescriptor.startOffset
        val declaredLength = fileDescriptor.declaredLength
        return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength)
    }

    @Throws(IOException::class)
    fun getInterpreter(assetManager: AssetManager): Interpreter {
        val modelBuffer = loadModelFile(assetManager, "converted_model2.tflite")
        return Interpreter(modelBuffer)
    }
}