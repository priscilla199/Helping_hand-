import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
import 'dart:async'; // Added for Timer

class Helpers {
  // Date and Time formatting
  static String formatDate(DateTime date, {String? format}) {
    final formatter = DateFormat(format ?? 'MMM dd, yyyy');
    return formatter.format(date);
  }

  static String formatTime(DateTime time, {String? format}) {
    final formatter = DateFormat(format ?? 'HH:mm');
    return formatter.format(time);
  }

  static String formatDateTime(DateTime dateTime, {String? format}) {
    final formatter = DateFormat(format ?? 'MMM dd, yyyy HH:mm');
    return formatter.format(dateTime);
  }

  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return formatDate(dateTime);
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  // Currency formatting
  static String formatCurrency(double amount, {String? currencyCode}) {
    final formatter = NumberFormat.currency(
      symbol: currencyCode ?? '\$',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  static String formatCompactCurrency(double amount, {String? currencyCode}) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M ${currencyCode ?? '\$'}';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K ${currencyCode ?? '\$'}';
    } else {
      return formatCurrency(amount, currencyCode: currencyCode);
    }
  }

  // Text validation
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s-()]{10,}$').hasMatch(phone);
  }

  static bool isValidPassword(String password) {
    return password.length >= AppConstants.minPasswordLength;
  }

  static bool isStrongPassword(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$')
        .hasMatch(password);
  }

  // String manipulation
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  static String truncateText(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$suffix';
  }

  // Color utilities
  static Color darkenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static Color lightenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  static bool isColorDark(Color color) {
    final luminance = color.computeLuminance();
    return luminance < 0.5;
  }

  // Size utilities
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isTablet(BuildContext context) {
    return getScreenWidth(context) > 600;
  }

  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) <= 600;
  }

  // Navigation helpers
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? AppConstants.primaryColor,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppConstants.errorColor,
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppConstants.successColor,
    );
  }

  static Future<bool> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // File size formatting
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Rating formatting
  static String formatRating(double rating) {
    return rating.toStringAsFixed(1);
  }

  static String getRatingText(double rating) {
    if (rating >= 4.5) return 'Excellent';
    if (rating >= 4.0) return 'Very Good';
    if (rating >= 3.5) return 'Good';
    if (rating >= 3.0) return 'Average';
    if (rating >= 2.0) return 'Below Average';
    return 'Poor';
  }

  // Distance formatting
  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()}m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)}km';
    }
  }

  // Phone number formatting
  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    final digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits[0] == '1') {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }
    
    return phoneNumber;
  }

  // Debounce function for search
  static Function debounce(Function func, Duration wait) {
    Timer? timer;
    return (dynamic args) {
      if (timer?.isActive ?? false) timer!.cancel();
      timer = Timer(wait, () => func(args));
    };
  }

  // Throttle function for API calls
  static Function throttle(Function func, Duration limit) {
    bool inThrottle = false;
    return (dynamic args) {
      if (!inThrottle) {
        func(args);
        inThrottle = true;
        Timer(limit, () => inThrottle = false);
      }
    };
  }
}

// Extension methods for common operations
extension StringExtension on String {
  String get capitalize => Helpers.capitalize(this);
  String get capitalizeWords => Helpers.capitalizeWords(this);
  bool get isValidEmail => Helpers.isValidEmail(this);
  bool get isValidPhone => Helpers.isValidPhone(this);
  bool get isValidPassword => Helpers.isValidPassword(this);
  bool get isStrongPassword => Helpers.isStrongPassword(this);
}

extension DoubleExtension on double {
  String get toCurrency => Helpers.formatCurrency(this);
  String get toCompactCurrency => Helpers.formatCompactCurrency(this);
  String get toRating => Helpers.formatRating(this);
  String get toRatingText => Helpers.getRatingText(this);
}

extension DateTimeExtension on DateTime {
  String get toRelativeTime => Helpers.getRelativeTime(this);
  String get toFormattedDate => Helpers.formatDate(this);
  String get toFormattedTime => Helpers.formatTime(this);
  String get toFormattedDateTime => Helpers.formatDateTime(this);
}

extension IntExtension on int {
  String get toFileSize => Helpers.formatFileSize(this);
  String get toDistance => Helpers.formatDistance(this.toDouble());
} 