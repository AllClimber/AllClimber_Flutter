package com.allclimbing.all_climbing

import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import android.widget.Toast
import com.allclimbing.all_climbing.route.RouteEditor
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.opencv.android.OpenCVLoader

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.allclimbing.all_climbing/route_adjuster"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "onCreate")
        if (OpenCVLoader.initLocal()) {
            Log.d(TAG, "OpenCV loaded successfully")
        } else {
            Log.d(TAG, "OpenCV initialization failed!")
            Toast.makeText(this, "OpenCV initialization failed!", Toast.LENGTH_LONG)
                .show()
            return
        }

    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "adjust") {
                val args = call.arguments as? Map<String, String> ?: run {
                    result.error(
                        "Wrong arguments",
                        null,
                        null
                    )
                    return@setMethodCallHandler
                }
                result.success(adjust(args))
            } else {
                result.notImplemented()
            }
        }
    }

    private fun adjust(args: Map<String, String>): String {
        val filePath = args["filePath"] ?: throw Exception("No file path")
        val brightness = args["brightness"] ?: throw Exception("No brightness")
        val saturation = args["saturation"] ?: throw Exception("No saturation")
        val routeEditor = RouteEditor()
        return routeEditor.adjust(filePath, brightness, saturation)
    }

    companion object {
        private const val TAG = "AndroidSide"
    }
}
