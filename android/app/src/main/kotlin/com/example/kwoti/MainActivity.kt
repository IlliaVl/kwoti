package com.example.kwoti

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.kwoti/share_whats_app"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "shareToWhatsApp") {
                shareWhatsApp(msg = call.argument("msg")!!, result = result)
            } else {
                result.notImplemented()
            }
        }
    }
    private fun shareWhatsApp(
        msg: String,
        result: MethodChannel.Result,
    ) {
        try {
            val whatsappIntent = Intent(Intent.ACTION_SEND)
            whatsappIntent.setPackage("com.whatsapp")
            whatsappIntent.putExtra(Intent.EXTRA_TEXT, msg)
            whatsappIntent.type = "text/plain"
            activity.startActivity(whatsappIntent)
            result.success("success")
        } catch (var9: Exception) {
            result.error("error", var9.toString(), "")
        }
    }
}
