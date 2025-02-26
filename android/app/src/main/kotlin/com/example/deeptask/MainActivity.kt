package com.example.deeptask

import android.app.AppOpsManager
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.os.Process
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.Drawable
import android.graphics.drawable.BitmapDrawable
import android.util.Base64
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.usageStats"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "checkPermission" -> {
                        val hasPermission = hasUsageStatsPermission()
                        result.success(hasPermission)
                    }
                    "requestPermission" -> {
                        openUsageAccessSettings()
                        result.success(hasUsageStatsPermission())
                    }
                    "openUsageAccessSettings" -> {
                        openUsageAccessSettings()
                        result.success(null)
                    }
                    "getUsageStats" -> {
                        if (hasUsageStatsPermission()) {
                            val filterSystemApps = call.argument<Boolean>("filterSystemApps") ?: true
                            val usageStats = getUsageStats(filterSystemApps)
                            result.success(usageStats)
                        } else {
                            result.error("PERMISSION_DENIED", "Usage stats permission is not granted", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun hasUsageStatsPermission(): Boolean {
        val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOps.checkOpNoThrow(
            AppOpsManager.OPSTR_GET_USAGE_STATS,
            Process.myUid(),
            packageName
        )
        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun openUsageAccessSettings() {
        val intent = Intent(android.provider.Settings.ACTION_USAGE_ACCESS_SETTINGS)
        startActivity(intent)
    }

    private fun getAppIcon(packageName: String): String? {
        return try {
            val packageManager = getPackageManager()
            val appIcon: Drawable = packageManager.getApplicationIcon(packageName)
            val bitmap = when (appIcon) {
                is android.graphics.drawable.BitmapDrawable -> appIcon.bitmap
                is android.graphics.drawable.AdaptiveIconDrawable -> {
                    val bitmap = Bitmap.createBitmap(appIcon.intrinsicWidth, appIcon.intrinsicHeight, Bitmap.Config.ARGB_8888)
                    val canvas = android.graphics.Canvas(bitmap)
                    appIcon.setBounds(0, 0, canvas.width, canvas.height)
                    appIcon.draw(canvas)
                    bitmap
                }
                else -> null
            }
            if (bitmap != null) {
                val byteArrayOutputStream = ByteArrayOutputStream()
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
                val byteArray = byteArrayOutputStream.toByteArray()
                Base64.encodeToString(byteArray, Base64.DEFAULT)
            } else {
                // Jika gagal, kembalikan ikon default (misalnya, ikon sistem Android)
                val defaultIcon = ContextCompat.getDrawable(this, android.R.drawable.sym_def_app_icon)
                val defaultBitmap = (defaultIcon as BitmapDrawable).bitmap
                val byteArrayOutputStream = ByteArrayOutputStream()
                defaultBitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
                val byteArray = byteArrayOutputStream.toByteArray()
                Base64.encodeToString(byteArray, Base64.DEFAULT)
            }
        } catch (e: Exception) {
            Log.e("MainActivity", "Error getting app icon: $packageName")
            // Jika terjadi error, kembalikan ikon default
            val defaultIcon = ContextCompat.getDrawable(this, android.R.drawable.sym_def_app_icon)
            val defaultBitmap = (defaultIcon as BitmapDrawable).bitmap
            val byteArrayOutputStream = ByteArrayOutputStream()
            defaultBitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
            val byteArray = byteArrayOutputStream.toByteArray()
            Base64.encodeToString(byteArray, Base64.DEFAULT)
        }
    }

    private fun getUsageStats(filterSystemApps: Boolean): List<Map<String, Any>> {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val currentTime = System.currentTimeMillis()
        val startTime = currentTime - 1000 * 60 * 60 * 24 // 24 jam terakhir
    
        val stats = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY, startTime, currentTime
        )
    
        val usageData = mutableListOf<Map<String, Any>>()
        if (stats != null) {
            for (usageStat in stats) {
                val packageName = usageStat.packageName
                // Filter out system apps if filterSystemApps is true
                if (!filterSystemApps 
                || (!packageName.startsWith("com.android") && !packageName.startsWith("com.google.android") && !packageName.startsWith("android"))
                ) {
                    val appIcon = getAppIcon(packageName)
                    val data = mapOf<String, Any>(
                        "packageName" to packageName,
                        "firstTimeStamp" to usageStat.firstTimeStamp,
                        "lastTimeUsed" to usageStat.lastTimeUsed,
                        "totalTimeInForeground" to usageStat.totalTimeInForeground,
                        // "appIcon" to (appIcon ?: "") // Pastikan appIcon bertipe Any
                    )
                    usageData.add(data)
                }
            }
        }
        return usageData
    }
}