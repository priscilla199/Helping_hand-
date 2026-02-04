// import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { employer, worker, admin }
enum VerificationStatus { pending, verified, rejected }

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final UserRole role;
  final VerificationStatus verificationStatus;
  final String? profileImageUrl;
  final String? nationalIdUrl;
  final String? selfieUrl;
  final String? address;
  final String? bio;
  final double rating;
  final int completedJobs;
  final DateTime createdAt;
  final DateTime? lastActive;
  final bool isActive;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    this.verificationStatus = VerificationStatus.pending,
    this.profileImageUrl,
    this.nationalIdUrl,
    this.selfieUrl,
    this.address,
    this.bio,
    this.rating = 0.0,
    this.completedJobs = 0,
    required this.createdAt,
    this.lastActive,
    this.isActive = true,
  });

  // factory UserModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return UserModel(
  //     id: doc.id,
  //     email: data['email'] ?? '',
  //     fullName: data['fullName'] ?? '',
  //     phoneNumber: data['phoneNumber'] ?? '',
  //     role: UserRole.values.firstWhere(
  //       (e) => e.toString() == 'UserRole.${data['role']}',
  //       orElse: () => UserRole.worker,
  //     ),
  //     verificationStatus: VerificationStatus.values.firstWhere(
  //       (e) => e.toString() == 'VerificationStatus.${data['verificationStatus']}',
  //       orElse: () => VerificationStatus.pending,
  //     ),
  //     profileImageUrl: data['profileImageUrl'],
  //     nationalIdUrl: data['nationalIdUrl'],
  //     selfieUrl: data['selfieUrl'],
  //     address: data['address'],
  //     bio: data['bio'],
  //     rating: (data['rating'] ?? 0.0).toDouble(),
  //     completedJobs: data['completedJobs'] ?? 0,
  //     createdAt: (data['createdAt'] as Timestamp).toDate(),
  //     lastActive: data['lastActive'] != null
  //         ? (data['lastActive'] as Timestamp).toDate()
  //         : null,
  //     isActive: data['isActive'] ?? true,
  //   );
  // }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role.toString().split('.').last,
      'verificationStatus': verificationStatus.toString().split('.').last,
      'profileImageUrl': profileImageUrl,
      'nationalIdUrl': nationalIdUrl,
      'selfieUrl': selfieUrl,
      'address': address,
      'bio': bio,
      'rating': rating,
      'completedJobs': completedJobs,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastActive': lastActive?.millisecondsSinceEpoch,
      'isActive': isActive,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    UserRole? role,
    VerificationStatus? verificationStatus,
    String? profileImageUrl,
    String? nationalIdUrl,
    String? selfieUrl,
    String? address,
    String? bio,
    double? rating,
    int? completedJobs,
    DateTime? createdAt,
    DateTime? lastActive,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      nationalIdUrl: nationalIdUrl ?? this.nationalIdUrl,
      selfieUrl: selfieUrl ?? this.selfieUrl,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      rating: rating ?? this.rating,
      completedJobs: completedJobs ?? this.completedJobs,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      isActive: isActive ?? this.isActive,
    );
  }
} 