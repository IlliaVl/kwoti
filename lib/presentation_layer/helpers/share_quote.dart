import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Helper class for sharing Quotes
class ShareQuote {
  static const platform = MethodChannel('com.example.kwoti/share_whats_app');

  const ShareQuote._();

  static Future<void> toWhatsApp(BuildContext context, String message) async {
    final Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent('msg', () => message);
    try {
      await platform.invokeMethod(
        'shareToWhatsApp',
        arguments,
      );
    } on PlatformException catch (e) {
      "Failed to share Quote: '${e.message}'.";
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Install WhatsApp at first, please.'),
        ),
      );
    }
  }
}
