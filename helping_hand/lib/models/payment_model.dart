// import 'package:cloud_firestore/cloud_firestore.dart';

enum PaymentStatus { pending, processing, completed, failed, refunded }
enum PaymentType { deposit, escrow, release, withdrawal }

class PaymentModel {
  final String id;
  final String jobId;
  final String employerId;
  final String? workerId;
  final double amount;
  final PaymentType type;
  final PaymentStatus status;
  final String? transactionId;
  final String? paymentMethod;
  final String? description;
  final DateTime createdAt;
  final DateTime? processedAt;
  final DateTime? completedAt;
  final String? failureReason;
  final Map<String, dynamic>? metadata;

  PaymentModel({
    required this.id,
    required this.jobId,
    required this.employerId,
    this.workerId,
    required this.amount,
    required this.type,
    this.status = PaymentStatus.pending,
    this.transactionId,
    this.paymentMethod,
    this.description,
    required this.createdAt,
    this.processedAt,
    this.completedAt,
    this.failureReason,
    this.metadata,
  });

  // factory PaymentModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return PaymentModel(
  //     id: doc.id,
  //     jobId: data['jobId'] ?? '',
  //     employerId: data['employerId'] ?? '',
  //     workerId: data['workerId'],
  //     amount: (data['amount'] ?? 0.0).toDouble(),
  //     type: PaymentType.values.firstWhere(
  //       (e) => e.toString() == 'PaymentType.${data['type']}',
  //       orElse: () => PaymentType.deposit,
  //     ),
  //     status: PaymentStatus.values.firstWhere(
  //       (e) => e.toString() == 'PaymentStatus.${data['status']}',
  //       orElse: () => PaymentStatus.pending,
  //     ),
  //     transactionId: data['transactionId'],
  //     paymentMethod: data['paymentMethod'],
  //     description: data['description'],
  //     createdAt: (data['createdAt'] as Timestamp).toDate(),
  //     processedAt: data['processedAt'] != null
  //         ? (data['processedAt'] as Timestamp).toDate()
  //         : null,
  //     completedAt: data['completedAt'] != null
  //         ? (data['completedAt'] as Timestamp).toDate()
  //         : null,
  //     failureReason: data['failureReason'],
  //     metadata: data['metadata'],
  //   );
  // }

  Map<String, dynamic> toFirestore() {
    return {
      'jobId': jobId,
      'employerId': employerId,
      'workerId': workerId,
      'amount': amount,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'transactionId': transactionId,
      'paymentMethod': paymentMethod,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'processedAt': processedAt?.millisecondsSinceEpoch,
      'completedAt': completedAt?.millisecondsSinceEpoch,
      'failureReason': failureReason,
      'metadata': metadata,
    };
  }

  PaymentModel copyWith({
    String? id,
    String? jobId,
    String? employerId,
    String? workerId,
    double? amount,
    PaymentType? type,
    PaymentStatus? status,
    String? transactionId,
    String? paymentMethod,
    String? description,
    DateTime? createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
    String? failureReason,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      employerId: employerId ?? this.employerId,
      workerId: workerId ?? this.workerId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt ?? this.processedAt,
      completedAt: completedAt ?? this.completedAt,
      failureReason: failureReason ?? this.failureReason,
      metadata: metadata ?? this.metadata,
    );
  }

  bool get isPending => status == PaymentStatus.pending;
  bool get isProcessing => status == PaymentStatus.processing;
  bool get isCompleted => status == PaymentStatus.completed;
  bool get isFailed => status == PaymentStatus.failed;
  bool get isRefunded => status == PaymentStatus.refunded;

  String get statusText {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }

  String get typeText {
    switch (type) {
      case PaymentType.deposit:
        return 'Deposit';
      case PaymentType.escrow:
        return 'Escrow';
      case PaymentType.release:
        return 'Release';
      case PaymentType.withdrawal:
        return 'Withdrawal';
    }
  }
} 