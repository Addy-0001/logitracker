import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/features/profile/presentation/profile/view_model/user_view_model.dart';
import 'package:logitracker/main.dart'; // Import to access navigatorKey

mixin ShakeDetectorMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  DateTime? _lastShakeTime;
  static const double _shakeThreshold = 12.0; // Adjust sensitivity
  static const int _shakeCooldown = 2000; // Cooldown in milliseconds

  @override
  void initState() {
    super.initState();
    _initializeShakeDetector();
  }

  void _initializeShakeDetector() {
    debugPrint('🔄 Initializing shake detector...');

    _accelerometerSubscription = accelerometerEvents.listen((
      AccelerometerEvent event,
    ) {
      _detectShake(event);
    });

    debugPrint('✅ Shake detector initialized');
  }

  void _detectShake(AccelerometerEvent event) {
    // Calculate the magnitude of acceleration
    double acceleration = sqrt(
      event.x * event.x + event.y * event.y + event.z * event.z,
    );

    // Remove gravity (approximately 9.8 m/s²)
    acceleration = (acceleration - 9.8).abs();

    // Check if shake is strong enough and not in cooldown
    if (acceleration > _shakeThreshold) {
      DateTime now = DateTime.now();

      if (_lastShakeTime == null ||
          now.difference(_lastShakeTime!).inMilliseconds > _shakeCooldown) {
        _lastShakeTime = now;
        debugPrint('📱 SHAKE DETECTED! Acceleration: $acceleration');
        _handleShakeDetected();
      }
    }
  }

  void _handleShakeDetected() {
    debugPrint('🚨 Handling shake detection...');
    _showShakeLogoutDialog();
  }

  void _showShakeLogoutDialog() {
    debugPrint('📋 Showing shake logout dialog...');

    // Use the navigator key to get the correct context
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) {
      debugPrint('❌ No valid context available for dialog');
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone_android, color: Colors.red[600], size: 60),
                const SizedBox(height: 20),
                const Text(
                  'Shake Detected!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Do you want to logout from your account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          debugPrint('❌ User cancelled shake logout');
                          Navigator.of(dialogContext).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                          side: BorderSide(color: Colors.grey.withOpacity(0.4)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint('✅ User confirmed shake logout');
                          Navigator.of(dialogContext).pop();
                          _performShakeLogout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 5,
                          shadowColor: Colors.red[600]!.withOpacity(0.4),
                        ),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _performShakeLogout() {
    debugPrint('🔄 Performing shake logout...');
    try {
      final userViewModel = locator<UserViewModel>();
      userViewModel.add(ShakePhoneEvent());
      debugPrint('✅ Shake logout event dispatched');
    } catch (e) {
      debugPrint('❌ Error triggering shake logout: $e');
    }
  }

  @override
  void dispose() {
    debugPrint('🗑️ Disposing shake detector...');
    _accelerometerSubscription?.cancel();
    super.dispose();
  }
}
