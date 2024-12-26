package com.mike.proyect_atenea

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Crear un canal de notificaciones para Android 8.0 o superior
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "high_importance_channel", // ID del canal
                "High Importance Notifications", // Nombre del canal
                NotificationManager.IMPORTANCE_HIGH // Nivel de importancia
            )
            channel.description = "Este canal es utilizado para notificaciones importantes."

            // Registrar el canal con el sistema
            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }
    }
}