package com.shareinvest.unique_id

import androidx.annotation.NonNull
import android.annotation.SuppressLint
import android.content.ContentResolver
import android.provider.Settings

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** UniqueIdPlugin */
class UniqueIdPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var contentResolver: ContentResolver

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    contentResolver = flutterPluginBinding.applicationContext.contentResolver
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "unique_id")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method)
    {
      "getUniqueId" -> result.success(getAndroidId())

      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @SuppressLint("HardwareIds")
  private fun getAndroidId(): String? {
    return Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
  }
}
