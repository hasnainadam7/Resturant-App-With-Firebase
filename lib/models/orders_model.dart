// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class OrdersModel {
//   final int id;
//   final double orderAmount;
//   final String paymentStatus;
//   final String orderStatus;
//   final Timestamp? confirmed;
//   final Timestamp? accepted;
//   final Timestamp? processing;
//   final Timestamp? handover;
//   final Timestamp? failed;
//   final Timestamp? scheduledAt;
//   final int deliveryAddressId;
//   final String orderNote;
//   final Timestamp createdAt;
//   final Timestamp updatedAt;
//   final double deliveryCharge;
//   final String deliveryAddress;
//   final String otp;
//   final Timestamp? pending;
//   final Timestamp? pickedUp;
//   final Timestamp? delivered;
//   final Timestamp? canceled;
//
//   OrdersModel({
//     required this.id,
//     required this.userId,
//     required this.orderAmount,
//     required this.paymentStatus,
//     required this.orderStatus,
//     this.confirmed,
//     this.accepted,
//     required this.scheduled,
//     this.processing,
//     this.handover,
//     this.failed,
//     this.scheduledAt,
//     required this.deliveryAddressId,
//     required this.orderNote,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.deliveryCharge,
//     required this.deliveryAddress,
//     required this.otp,
//     this.pending,
//     this.pickedUp,
//     this.delivered,
//     this.canceled,
//   });
//
//   factory OrdersModel.fromJson(Map<String, dynamic> json) {
//     return OrdersModel(
//       id: json['id'] as int,
//       userId: json['user_id'] as int,
//       orderAmount: (json['order_amount'] as num).toDouble(),
//       paymentStatus: json['payment_status'] as String,
//       orderStatus: json['order_status'] as String,
//       confirmed: json['confirmed'] != null ? (json['confirmed'] as Timestamp) : null,
//       accepted: json['accepted'] != null ? (json['accepted'] as Timestamp) : null,
//       scheduled: json['scheduled'] as bool,
//       processing: json['processing'] != null ? (json['processing'] as Timestamp) : null,
//       handover: json['handover'] != null ? (json['handover'] as Timestamp) : null,
//       failed: json['failed'] != null ? (json['failed'] as Timestamp) : null,
//       scheduledAt: json['scheduled_at'] != null ? (json['scheduled_at'] as Timestamp) : null,
//       deliveryAddressId: json['delivery_address_id'] as int,
//       orderNote: json['order_note'] as String,
//       createdAt: json['created_at'] as Timestamp,
//       updatedAt: json['updated_at'] as Timestamp,
//       deliveryCharge: (json['delivery_charge'] as num).toDouble(),
//       deliveryAddress: json['delivery_address'] as String,
//       otp: json['otp'] as String,
//       pending: json['pending'] != null ? (json['pending'] as Timestamp) : null,
//       pickedUp: json['picked_up'] != null ? (json['picked_up'] as Timestamp) : null,
//       delivered: json['delivered'] != null ? (json['delivered'] as Timestamp) : null,
//       canceled: json['canceled'] != null ? (json['canceled'] as Timestamp) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'order_amount': orderAmount,
//       'payment_status': paymentStatus,
//       'order_status': orderStatus,
//       'confirmed': confirmed,
//       'accepted': accepted,
//       'scheduled': scheduled,
//       'processing': processing,
//       'handover': handover,
//       'failed': failed,
//       'scheduled_at': scheduledAt,
//       'delivery_address_id': deliveryAddressId,
//       'order_note': orderNote,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'delivery_charge': deliveryCharge,
//       'delivery_address': deliveryAddress,
//       'otp': otp,
//       'pending': pending,
//       'picked_up': pickedUp,
//       'delivered': delivered,
//       'canceled': canceled,
//     };
//   }
// }
