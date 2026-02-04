import 'package:flutter/foundation.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;
  // User? get firebaseUser => _authService.currentUser;
  dynamic get firebaseUser => _authService.currentUser;

  // Initialize the provider
  Future<void> initialize() async {
    _setLoading(true);
    try {
      final user = _authService.currentUser;
      if (user != null) {
        await _loadUserData('demo_user_id');
        _isAuthenticated = true;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Sign in
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final credential = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      
      if (credential.user != null) {
        await _loadUserData(credential.user.uid);
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Sign up
  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required UserRole role,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      final credential = await _authService.createUserWithEmailAndPassword(
        email,
        password,
        fullName,
        phoneNumber,
        role,
      );
      
      if (credential.user != null) {
        await _loadUserData(credential.user.uid);
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Sign out
  Future<void> signOut() async {
    _setLoading(true);
    
    try {
      await _authService.signOut();
      _clearUserData();
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? address,
    String? bio,
  }) async {
    if (_currentUser == null) return false;
    
    _setLoading(true);
    _clearError();
    
    try {
      final updateData = <String, dynamic>{};
      
      if (fullName != null) updateData['fullName'] = fullName;
      if (phoneNumber != null) updateData['phoneNumber'] = phoneNumber;
      if (address != null) updateData['address'] = address;
      if (bio != null) updateData['bio'] = bio;
      
      await _authService.updateUserData(_currentUser!.id, updateData);
      
      // Update local user data
      _currentUser = _currentUser!.copyWith(
        fullName: fullName ?? _currentUser!.fullName,
        phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
        address: address ?? _currentUser!.address,
        bio: bio ?? _currentUser!.bio,
      );
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update verification status
  Future<bool> updateVerificationStatus(VerificationStatus status) async {
    if (_currentUser == null) return false;
    
    _setLoading(true);
    _clearError();
    
    try {
      await _authService.updateVerificationStatus(_currentUser!.id, status);
      
      // Update local user data
      _currentUser = _currentUser!.copyWith(verificationStatus: status);
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Refresh user data
  Future<void> refreshUserData() async {
    if (_currentUser == null) return;
    
    try {
      await _loadUserData(_currentUser!.id);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Check if user is verified
  bool get isUserVerified {
    return _currentUser?.verificationStatus == VerificationStatus.verified;
  }

  // Check user role
  bool get isEmployer {
    return _currentUser?.role == UserRole.employer;
  }

  bool get isWorker {
    return _currentUser?.role == UserRole.worker;
  }

  bool get isAdmin {
    return _currentUser?.role == UserRole.admin;
  }

  // Load user data from Firestore
  Future<void> _loadUserData(String userId) async {
    try {
      final userData = await _authService.getUserData(userId);
      if (userData != null) {
        _currentUser = userData;
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to load user data: $e');
    }
  }

  // Clear user data
  void _clearUserData() {
    _currentUser = null;
    _isAuthenticated = false;
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  // Clear error
  void _clearError() {
    _error = null;
    notifyListeners();
  }

  // Clear error manually
  void clearError() {
    _clearError();
  }

  // Update user rating
  Future<bool> updateUserRating(double newRating) async {
    if (_currentUser == null) return false;
    
    try {
      await _authService.updateUserData(_currentUser!.id, {
        'rating': newRating,
      });
      
      // Update local user data
      _currentUser = _currentUser!.copyWith(rating: newRating);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Update completed jobs count
  Future<bool> incrementCompletedJobs() async {
    if (_currentUser == null) return false;
    
    try {
      final newCount = _currentUser!.completedJobs + 1;
      await _authService.updateUserData(_currentUser!.id, {
        'completedJobs': newCount,
      });
      
      // Update local user data
      _currentUser = _currentUser!.copyWith(completedJobs: newCount);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Check if user can post jobs (employer and verified)
  bool get canPostJobs {
    return isEmployer && isUserVerified;
  }

  // Check if user can apply for jobs (worker and verified)
  bool get canApplyForJobs {
    return isWorker && isUserVerified;
  }

  // Get user display name
  String get userDisplayName {
    return _currentUser?.fullName ?? 'User';
  }

  // Get user initials
  String get userInitials {
    final name = _currentUser?.fullName ?? '';
    if (name.isEmpty) return 'U';
    
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }
} 