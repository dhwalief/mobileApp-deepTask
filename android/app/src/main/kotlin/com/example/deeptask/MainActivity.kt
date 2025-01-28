package com.example.deeptask

import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.usageStats"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getUsageStats" -> {
                        if (hasUsageStatsPermission()) {
                            val filterSystemApps = call.argument<Boolean>("filterSystemApps") ?: true
                            val usageStats = getUsageStats(filterSystemApps)
                            Log.d("UsageStats", usageStats.toString()) // Log data untuk debugging
                            result.success(usageStats)
                        } else {
                            openUsageAccessSettings()
                            result.error("PERMISSION_DENIED", "Usage stats permission is not granted", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun hasUsageStatsPermission(): Boolean {
        val appOps = getSystemService(Context.APP_OPS_SERVICE) as android.app.AppOpsManager
        val mode = appOps.checkOpNoThrow(
            android.app.AppOpsManager.OPSTR_GET_USAGE_STATS,
            android.os.Process.myUid(),
            packageName
        )
        return mode == android.app.AppOpsManager.MODE_ALLOWED
    }

    private fun openUsageAccessSettings() {
        val intent = Intent(android.provider.Settings.ACTION_USAGE_ACCESS_SETTINGS)
        startActivity(intent)
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
                    val data = mapOf(
                        "packageName" to packageName,
                        "firstTimeStamp" to usageStat.firstTimeStamp,
                        "lastTimeUsed" to usageStat.lastTimeUsed,
                        "totalTimeInForeground" to usageStat.totalTimeInForeground
                    )
                    usageData.add(data)
                }
            }
        }
        return usageData
    }
}