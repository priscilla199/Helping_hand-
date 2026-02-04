import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'Helping Hand';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Find work or hire help with trust and security';

  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color primaryDarkColor = Color(0xFF1976D2);
  static const Color primaryLightColor = Color(0xFFBBDEFB);
  static const Color accentColor = Color(0xFFFF9800);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color infoColor = Color(0xFF2196F3);

  // Text Colors
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color textLightColor = Color(0xFFBDBDBD);
  static const Color textWhiteColor = Color(0xFFFFFFFF);

  // Background Colors
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);

  // Border Colors
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color dividerColor = Color(0xFFBDBDBD);

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double borderRadiusS = 4.0;
  static const double borderRadiusM = 8.0;
  static const double borderRadiusL = 12.0;
  static const double borderRadiusXL = 16.0;

  // Shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimaryColor,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
  );

  static const TextStyle buttonStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textWhiteColor,
  );

  // Job Categories
  static const List<String> jobCategories = [
    'Cleaning',
    'Gardening',
    'Delivery',
    'Handyman',
    'Other',
  ];

  // Payment Methods
  static const List<String> paymentMethods = [
    'Mobile Money',
    'Bank Transfer',
    'Credit Card',
    'Cash',
  ];

  // Verification Documents
  static const List<String> verificationDocuments = [
    'National ID',
    'Passport',
    'Driver License',
  ];

  // App Routes
  static const String routeHome = '/';
  static const String routeLogin = '/login';
  static const String routeSignup = '/signup';
  static const String routeVerification = '/verification';
  static const String routeJobs = '/jobs';
  static const String routeJobDetails = '/job-details';
  static const String routeCreateJob = '/create-job';
  static const String routeWallet = '/wallet';
  static const String routeProfile = '/profile';
  static const String routeSettings = '/settings';

  // Firebase Collections
  static const String collectionUsers = 'users';
  static const String collectionJobs = 'jobs';
  static const String collectionPayments = 'payments';
  static const String collectionReviews = 'reviews';
  static const String collectionNotifications = 'notifications';

  // Storage Paths
  static const String storageProfileImages = 'profile_images';
  static const String storageVerificationDocuments = 'verification_documents';
  static const String storageJobImages = 'job_images';

  // API Endpoints (if using external APIs)
  static const String baseUrl = 'https://api.helpinghand.com';
  static const String paymentGatewayUrl = 'https://pay.helpinghand.com';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Job Limits
  static const double minJobPay = 1.0;
  static const double maxJobPay = 10000.0;
  static const int minJobHours = 1;
  static const int maxJobHours = 24;

  // Rating System
  static const double minRating = 1.0;
  static const double maxRating = 5.0;

  // Notification Types
  static const String notificationJobMatch = 'job_match';
  static const String notificationPayment = 'payment';
  static const String notificationVerification = 'verification';
  static const String notificationJobUpdate = 'job_update';
} 