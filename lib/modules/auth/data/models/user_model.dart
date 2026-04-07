import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;

  final String? gender;
  final String? gymName;
  final String? fitnessLevel;
  final List<String>? workoutTypes;

  final List<String>? preferredDays;
  final List<String>? preferredTimes;

  final double? latitude;
  final double? longitude;
  final double? maxDistanceKm;
  final bool isLookingForPartner;

  final List<String>? friends;
  final String? bio;

  final DateTime createdAt;
  final DateTime? lastActive;
  final String? fcmToken;
  final bool isPremiumUser;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photoUrl,
    this.gender,
    this.gymName,
    this.fitnessLevel,
    this.workoutTypes,
    this.preferredDays,
    this.preferredTimes,
    this.latitude,
    this.longitude,
    this.maxDistanceKm,
    this.isLookingForPartner = false,
    this.friends,
    this.bio,
    required this.createdAt,
    this.lastActive,
    this.fcmToken,
    this.isPremiumUser = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      photoUrl: json['photoUrl'] as String?,

      gender: json['gender'] as String?,
      gymName: json['gymName'] as String?,
      fitnessLevel: json['fitnessLevel'] as String?,
      workoutTypes: (json['workoutTypes'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),

      preferredDays: (json['preferredDays'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      preferredTimes: (json['preferredTimes'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),

      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      maxDistanceKm: (json['maxDistanceKm'] as num?)?.toDouble(),
      isLookingForPartner: json['isLookingForPartner'] as bool? ?? false,

      friends: (json['friends'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      bio: json['bio'] as String?,

      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
      lastActive: _parseDateTime(json['lastActive']),
      fcmToken: json['fcmToken'] as String?,
      isPremiumUser: json['isPremiumUser'] as bool? ?? false,
    );
  }

  /// Handles both ISO 8601 strings and Firestore Timestamps.
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,

      'gender': gender,
      'gymName': gymName,
      'fitnessLevel': fitnessLevel,
      'workoutTypes': workoutTypes,

      'preferredDays': preferredDays,
      'preferredTimes': preferredTimes,

      'latitude': latitude,
      'longitude': longitude,
      'maxDistanceKm': maxDistanceKm,
      'isLookingForPartner': isLookingForPartner,

      'friends': friends,
      'bio': bio,

      'createdAt': Timestamp.fromDate(createdAt),
      'lastActive': lastActive != null ? Timestamp.fromDate(lastActive!) : null,
      'fcmToken': fcmToken,
      'isPremiumUser': isPremiumUser,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    String? gender,
    String? gymName,
    String? fitnessLevel,
    List<String>? workoutTypes,
    List<String>? preferredDays,
    List<String>? preferredTimes,
    double? latitude,
    double? longitude,
    double? maxDistanceKm,
    bool? isLookingForPartner,
    List<String>? friends,
    String? bio,
    DateTime? createdAt,
    DateTime? lastActive,
    String? fcmToken,
    bool? isPremiumUser,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      gender: gender ?? this.gender,
      gymName: gymName ?? this.gymName,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      workoutTypes: workoutTypes ?? this.workoutTypes,
      preferredDays: preferredDays ?? this.preferredDays,
      preferredTimes: preferredTimes ?? this.preferredTimes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
      isLookingForPartner: isLookingForPartner ?? this.isLookingForPartner,
      friends: friends ?? this.friends,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      fcmToken: fcmToken ?? this.fcmToken,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
    );
  }
}
