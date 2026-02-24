class MoreVideoRewards {
  final bool success;
  final String message;
  final RewardsData data;

  MoreVideoRewards({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MoreVideoRewards.fromJson(Map<String, dynamic> json) {
    return MoreVideoRewards(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: RewardsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

class RewardsData {
  final int totalUnlocked;
  final List<RewardItem> rewards;

  RewardsData({
    required this.totalUnlocked,
    required this.rewards,
  });

  factory RewardsData.fromJson(Map<String, dynamic> json) {
    final list = (json['rewards'] as List?) ?? [];
    return RewardsData(
      totalUnlocked: (json['totalUnlocked'] ?? 0) is int
          ? (json['totalUnlocked'] ?? 0)
          : int.tryParse('${json['totalUnlocked']}') ?? 0,
      rewards: list.map((e) => RewardItem.fromJson(e ?? {})).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'totalUnlocked': totalUnlocked,
    'rewards': rewards.map((e) => e.toJson()).toList(),
  };
}

class RewardItem {
  final DateTime? unlockedAt;
  final bool watched;
  final DateTime? watchedAt;
  final VideoModel video;

  RewardItem({
    required this.unlockedAt,
    required this.watched,
    required this.watchedAt,
    required this.video,
  });

  factory RewardItem.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      return DateTime.tryParse(v.toString());
    }

    return RewardItem(
      unlockedAt: parseDate(json['unlockedAt']),
      watched: json['watched'] ?? false,
      watchedAt: parseDate(json['watchedAt']),
      video: VideoModel.fromJson(json['video'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'unlockedAt': unlockedAt?.toIso8601String(),
    'watched': watched,
    'watchedAt': watchedAt?.toIso8601String(),
    'video': video.toJson(),
  };
}

class VideoModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String videoUrl;
  final int fileSize;
  final List<String> age;
  final int views;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.videoUrl,
    required this.fileSize,
    required this.age,
    required this.views,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      return DateTime.tryParse(v.toString());
    }

    final ageList = (json['age'] as List?) ?? [];

    return VideoModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      videoUrl: (json['videoUrl'] ?? '').toString(),
      fileSize: (json['fileSize'] ?? 0) is int
          ? (json['fileSize'] ?? 0)
          : int.tryParse('${json['fileSize']}') ?? 0,
      age: ageList.map((e) => e.toString()).toList(),
      views: (json['views'] ?? 0) is int
          ? (json['views'] ?? 0)
          : int.tryParse('${json['views']}') ?? 0,
      isActive: json['isActive'] ?? false,
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'videoUrl': videoUrl,
    'fileSize': fileSize,
    'age': age,
    'views': views,
    'isActive': isActive,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}