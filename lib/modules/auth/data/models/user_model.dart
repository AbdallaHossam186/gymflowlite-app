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
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photoUrl'],

      gender: json['gender'],
      gymName: json['gymName'],
      fitnessLevel: json['fitnessLevel'],
      workoutTypes: List<String>.from(json['workoutTypes'] ?? []),

      preferredDays: List<String>.from(json['preferredDays'] ?? []),
      preferredTimes: List<String>.from(json['preferredTimes'] ?? []),

      latitude: json['latitude'],
      longitude: json['longitude'],
      maxDistanceKm: json['maxDistanceKm'],
      isLookingForPartner: json['isLookingForPartner'] ?? false,

      friends: List<String>.from(json['friends'] ?? []),
      bio: json['bio'],

      createdAt: DateTime.parse(json['createdAt']),
      lastActive: json['lastActive'] != null
          ? DateTime.parse(json['lastActive'])
          : null,
      fcmToken: json['fcmToken'],
      isPremiumUser: json['isPremiumUser'] ?? false,
    );
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

      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive?.toIso8601String(),
      'fcmToken': fcmToken,
      'isPremiumUser': isPremiumUser,
    };
  }
}
