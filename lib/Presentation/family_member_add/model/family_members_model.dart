class FamilyMembersResponse {
  final bool success;
  final String message;
  final FamilyMembersData? data;

  FamilyMembersResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FamilyMembersResponse.fromJson(Map<String, dynamic> json) {
    return FamilyMembersResponse(
      success: json['success'] == true,
      message: (json['message'] ?? '').toString(),
      data: json['data'] is Map<String, dynamic>
          ? FamilyMembersData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class FamilyMembersData {
  final Subscription? subscription;
  final List<Member> members;

  FamilyMembersData({
    required this.subscription,
    required this.members,
  });

  factory FamilyMembersData.fromJson(Map<String, dynamic> json) {
    final rawMembers = json['members'];
    return FamilyMembersData(
      subscription: json['subscription'] is Map<String, dynamic>
          ? Subscription.fromJson(json['subscription'] as Map<String, dynamic>)
          : null,
      members: rawMembers is List
          ? rawMembers
          .whereType<Map<String, dynamic>>()
          .map(Member.fromJson)
          .toList()
          : <Member>[],
    );
  }
}

class Subscription {
  final String id;
  final String planName;
  final int maxMembers;
  final int currentMembersCount;

  Subscription({
    required this.id,
    required this.planName,
    required this.maxMembers,
    required this.currentMembersCount,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: (json['id'] ?? '').toString(),
      planName: (json['planName'] ?? '').toString(),
      maxMembers: _toInt(json['maxMembers']),
      currentMembersCount: _toInt(json['currentMembersCount']),
    );
  }
}

class Member {
  final String id;
  final String subscriptionId;
  final String userId;
  final DateTime? joinedAt;
  final UserProfile? user;

  Member({
    required this.id,
    required this.subscriptionId,
    required this.userId,
    required this.joinedAt,
    required this.user,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: (json['id'] ?? '').toString(),
      subscriptionId: (json['subscriptionId'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      joinedAt: _toDateTime(json['joinedAt']),
      user: json['user'] is Map<String, dynamic>
          ? UserProfile.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePic;
  final DateTime? createdAt;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePic,
    required this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: (json['id'] ?? '').toString(),
      firstName: (json['firstName'] ?? '').toString(),
      lastName: (json['lastName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      profilePic: (json['profilePic'] ?? '').toString(),
      createdAt: _toDateTime(json['createdAt']),
    );
  }

  String get fullName => ('$firstName $lastName').trim();
}

/// ---------- Helpers (safe parsing) ----------
int _toInt(dynamic v) {
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

DateTime? _toDateTime(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String) return DateTime.tryParse(v);
  return null;
}