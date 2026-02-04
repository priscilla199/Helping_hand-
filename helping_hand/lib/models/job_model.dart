// import 'package:cloud_firestore/cloud_firestore.dart';

enum JobStatus { open, inProgress, completed, cancelled }
enum JobCategory { cleaning, gardening, delivery, handyman, other }

class JobModel {
  final String id;
  final String employerId;
  final String employerName;
  final String title;
  final String description;
  final JobCategory category;
  final double pay;
  final String location;
  final double? latitude;
  final double? longitude;
  final DateTime scheduledDate;
  final int estimatedHours;
  final JobStatus status;
  final String? workerId;
  final String? workerName;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? notes;
  final bool isUrgent;

  JobModel({
    required this.id,
    required this.employerId,
    required this.employerName,
    required this.title,
    required this.description,
    required this.category,
    required this.pay,
    required this.location,
    this.latitude,
    this.longitude,
    required this.scheduledDate,
    required this.estimatedHours,
    this.status = JobStatus.open,
    this.workerId,
    this.workerName,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.notes,
    this.isUrgent = false,
  });

  // factory JobModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return JobModel(
  //     id: doc.id,
  //     employerId: data['employerId'] ?? '',
  //     employerName: data['employerName'] ?? '',
  //     title: data['title'] ?? '',
  //     description: data['description'] ?? '',
  //     category: JobCategory.values.firstWhere(
  //       (e) => e.toString() == 'JobCategory.${data['category']}',
  //       orElse: () => JobCategory.other,
  //     ),
  //     pay: (data['pay'] ?? 0.0).toDouble(),
  //     location: data['location'] ?? '',
  //     latitude: data['latitude']?.toDouble(),
  //     longitude: data['longitude']?.toDouble(),
  //     scheduledDate: (data['scheduledDate'] as Timestamp).toDate(),
  //     estimatedHours: data['estimatedHours'] ?? 1,
  //     status: JobStatus.values.firstWhere(
  //       (e) => e.toString() == 'JobStatus.${data['status']}',
  //       orElse: () => JobStatus.open,
  //     ),
  //     workerId: data['workerId'],
  //     workerName: data['workerName'],
  //     createdAt: (data['createdAt'] as Timestamp).toDate(),
  //     startedAt: data['startedAt'] != null
  //         ? (data['startedAt'] as Timestamp).toDate()
  //         : null,
  //     completedAt: data['completedAt'] != null
  //         ? (data['completedAt'] as Timestamp).toDate()
  //         : null,
  //     notes: data['notes'],
  //     isUrgent: data['isUrgent'] ?? false,
  //   );
  // }

  Map<String, dynamic> toFirestore() {
    return {
      'employerId': employerId,
      'employerName': employerName,
      'title': title,
      'description': description,
      'category': category.toString().split('.').last,
      'pay': pay,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'scheduledDate': scheduledDate.millisecondsSinceEpoch,
      'estimatedHours': estimatedHours,
      'status': status.toString().split('.').last,
      'workerId': workerId,
      'workerName': workerName,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'startedAt': startedAt?.millisecondsSinceEpoch,
      'completedAt': completedAt?.millisecondsSinceEpoch,
      'notes': notes,
      'isUrgent': isUrgent,
    };
  }

  JobModel copyWith({
    String? id,
    String? employerId,
    String? employerName,
    String? title,
    String? description,
    JobCategory? category,
    double? pay,
    String? location,
    double? latitude,
    double? longitude,
    DateTime? scheduledDate,
    int? estimatedHours,
    JobStatus? status,
    String? workerId,
    String? workerName,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? notes,
    bool? isUrgent,
  }) {
    return JobModel(
      id: id ?? this.id,
      employerId: employerId ?? this.employerId,
      employerName: employerName ?? this.employerName,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      pay: pay ?? this.pay,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      status: status ?? this.status,
      workerId: workerId ?? this.workerId,
      workerName: workerName ?? this.workerName,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }

  bool get isAvailable => status == JobStatus.open;
  bool get isAssigned => workerId != null && workerId!.isNotEmpty;
  bool get isInProgress => status == JobStatus.inProgress;
  bool get isCompleted => status == JobStatus.completed;
} 