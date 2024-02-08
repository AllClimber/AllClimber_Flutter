package com.allclimbing.all_climbing.route

import android.util.Log
import java.io.File

class RouteEditor {
    fun adjust(filePath: String, brightness: String, saturation: String): String {
        val file = File(filePath)
        if (!file.exists()) {
            throw Exception("File not found")
        }
        Log.d(
            TAG,
            "Adjusting $filePath with brightness $brightness and saturation $saturation: ${file.length()}"
        )

        val imageAdjustor = ImageAdjustor()
        return imageAdjustor.adjustImage(filePath, brightness.toDouble(), saturation.toDouble()).path
    }

    companion object {
        private const val TAG = "RouteEditor"
    }
}