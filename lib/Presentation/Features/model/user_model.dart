class UserModel {
  final bool success;
  final String message;
  final UserData? data;

  const UserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const UserModel(success: false, message: '', data: null);
    }
    return UserModel(
      success: json['success'] == true,
      message: (json['message'] ?? '').toString(),
      data: UserData.fromJson(json['data'] as Map<String, dynamic>?),
    );
  }
}

class UserData {
  final String id;
  final String firstName;
  final String lastName;
  final String age;
  final String hobbies;
  final String email;
  final String profilePic;
  final String role;

  final bool isVerified;
  final bool isSubscribed;
  final DateTime? planExpiration;
  final bool isSubscriptionFree;

  final dynamic profile;
  final Subscription? subscription;

  final String language;
  final String userType;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final UserProgress? userProgress;

  const UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.hobbies,
    required this.email,
    required this.profilePic,
    required this.role,
    required this.isVerified,
    required this.isSubscribed,
    required this.planExpiration,
    required this.isSubscriptionFree,
    required this.profile,
    required this.subscription,
    required this.language,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    required this.userProgress,
  });

  factory UserData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const UserData(
        id: '',
        firstName: '',
        lastName: '',
        age: '',
        hobbies: '',
        email: '',
        profilePic: '',
        role: '',
        isVerified: false,
        isSubscribed: false,
        planExpiration: null,
        isSubscriptionFree: false,
        profile: null,
        subscription: null,
        language: '',
        userType: '',
        createdAt: null,
        updatedAt: null,
        userProgress: null,
      );
    }

    return UserData(
      id: (json['id'] ?? '').toString(),
      firstName: (json['firstName'] ?? '').toString(),
      lastName: (json['lastName'] ?? '').toString(),
      age: (json['age'] ?? '').toString(),
      hobbies: (json['hobbies'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      profilePic: (json['profilePic'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      isVerified: json['isVerified'] == true,
      isSubscribed: json['isSubscribed'] == true,
      planExpiration: DateTime.tryParse((json['planExpiration'] ?? '').toString()),
      isSubscriptionFree: json['isSubscriptionFree'] == true,
      profile: json['Profile'],
      subscription: Subscription.fromJson(json['Subscription'] as Map<String, dynamic>?),
      language: (json['language'] ?? '').toString(),
      userType: (json['userType'] ?? '').toString(),
      createdAt: DateTime.tryParse((json['createdAt'] ?? '').toString()),
      updatedAt: DateTime.tryParse((json['updatedAt'] ?? '').toString()),
      userProgress: UserProgress.fromJson(json['userProgress'] as Map<String, dynamic>?),
    );
  }
}

class Subscription {
  final String id;
  final String userId;
  final String planId;

  final DateTime? startDate;
  final DateTime? endDate;

  final double amount;
  final String stripePaymentId;
  final String paymentStatus;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final Plan? plan;
  final List<Member> members;

  const Subscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    required this.amount,
    required this.stripePaymentId,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.plan,
    required this.members,
  });

  factory Subscription.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const Subscription(
        id: '',
        userId: '',
        planId: '',
        startDate: null,
        endDate: null,
        amount: 0.0,
        stripePaymentId: '',
        paymentStatus: '',
        createdAt: null,
        updatedAt: null,
        plan: null,
        members: <Member>[],
      );
    }

    return Subscription(
      id: (json['id'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      planId: (json['planId'] ?? '').toString(),
      startDate: DateTime.tryParse((json['startDate'] ?? '').toString()),
      endDate: DateTime.tryParse((json['endDate'] ?? '').toString()),
      amount: _toDouble(json['amount']),
      stripePaymentId: (json['stripePaymentId'] ?? '').toString(),
      paymentStatus: (json['paymentStatus'] ?? '').toString(),
      createdAt: DateTime.tryParse((json['createdAt'] ?? '').toString()),
      updatedAt: DateTime.tryParse((json['updatedAt'] ?? '').toString()),
      plan: Plan.fromJson(json['plan'] as Map<String, dynamic>?),
      members: _toList(json['members'])
          .map((e) => Member.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }
}

class Plan {
  final String id;
  final String planName;
  final double amount;
  final String planType;
  final String currency;

  final String interval;
  final int intervalCount;
  final int? freeTrialDays;

  final String productId;
  final String priceId;

  final bool active;
  final String description;
  final int maxMembers;

  final List<String> features;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Plan({
    required this.id,
    required this.planName,
    required this.amount,
    required this.planType,
    required this.currency,
    required this.interval,
    required this.intervalCount,
    required this.freeTrialDays,
    required this.productId,
    required this.priceId,
    required this.active,
    required this.description,
    required this.maxMembers,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const Plan(
        id: '',
        planName: '',
        amount: 0.0,
        planType: '',
        currency: '',
        interval: '',
        intervalCount: 0,
        freeTrialDays: null,
        productId: '',
        priceId: '',
        active: false,
        description: '',
        maxMembers: 0,
        features: <String>[],
        createdAt: null,
        updatedAt: null,
      );
    }

    return Plan(
      id: (json['id'] ?? '').toString(),
      planName: (json['planName'] ?? '').toString(),
      amount: _toDouble(json['amount']),
      planType: (json['PlanType'] ?? '').toString(),
      currency: (json['currency'] ?? '').toString(),
      interval: (json['interval'] ?? '').toString(),
      intervalCount: _toInt(json['intervalCount']),
      freeTrialDays: json['freeTrialDays'] == null ? null : _toInt(json['freeTrialDays']),
      productId: (json['productId'] ?? '').toString(),
      priceId: (json['priceId'] ?? '').toString(),
      active: json['active'] == true,
      description: (json['description'] ?? '').toString(),
      maxMembers: _toInt(json['maxMembers']),
      features: _toList(json['features']).map((e) => e.toString()).toList(),
      createdAt: DateTime.tryParse((json['createdAt'] ?? '').toString()),
      updatedAt: DateTime.tryParse((json['updatedAt'] ?? '').toString()),
    );
  }
}

class Member {
  final String id;
  final String subscriptionId;
  final String userId;
  final DateTime? joinedAt;

  const Member({
    required this.id,
    required this.subscriptionId,
    required this.userId,
    required this.joinedAt,
  });

  factory Member.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const Member(
        id: '',
        subscriptionId: '',
        userId: '',
        joinedAt: null,
      );
    }

    return Member(
      id: (json['id'] ?? '').toString(),
      subscriptionId: (json['subscriptionId'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      joinedAt: DateTime.tryParse((json['joinedAt'] ?? '').toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subscriptionId': subscriptionId,
    'userId': userId,
    'joinedAt': joinedAt?.toIso8601String(),
  };
}

class UserProgress {
  final int dayStreak;
  final int totalWords;
  final int totalLessons;
  final double overallAccuracy;
  final int dailyGoal;
  final DateTime? lastActivityDate;

  const UserProgress({
    required this.dayStreak,
    required this.totalWords,
    required this.totalLessons,
    required this.overallAccuracy,
    required this.dailyGoal,
    required this.lastActivityDate,
  });

  factory UserProgress.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const UserProgress(
        dayStreak: 0,
        totalWords: 0,
        totalLessons: 0,
        overallAccuracy: 0.0,
        dailyGoal: 0,
        lastActivityDate: null,
      );
    }

    return UserProgress(
      dayStreak: _toInt(json['dayStreak']),
      totalWords: _toInt(json['totalWords']),
      totalLessons: _toInt(json['totalLessons']),
      overallAccuracy: _toDouble(json['overallAccuracy']),
      dailyGoal: _toInt(json['dailyGoal']),
      lastActivityDate: DateTime.tryParse((json['lastActivityDate'] ?? '').toString()),
    );
  }
}

// ========================= helpers =========================
double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0.0;
}

int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.round();
  return int.tryParse(v.toString()) ?? 0;
}

List _toList(dynamic v) {
  if (v is List) return v;
  return const [];
}
