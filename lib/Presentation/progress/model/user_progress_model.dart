class UserProgressResponse {
  final UserProgressData? data;

  const UserProgressResponse({this.data});

  factory UserProgressResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const UserProgressResponse();
    return UserProgressResponse(
      data: UserProgressData.fromJson(json['data'] as Map<String, dynamic>?),
    );
  }
}

class UserProgressData {
  final int readingProgress;
  final int writingProgress;
  final int speakingProgress;
  final int presentationProgress;
  final int vocabularyProgress;
  final int overallAccuracy;
  final int dayStreak;
  final int totalWords;
  final int totalBadges;
  final int totalLessons;
  final int dailyGoal;
  final int dailyGoalCompleted;
  final int todayLessons;
  final int totalTimeSpent;
  final List<Badge> badges;

  const UserProgressData({
    this.readingProgress = 0,
    this.writingProgress = 0,
    this.speakingProgress = 0,
    this.presentationProgress = 0,
    this.vocabularyProgress = 0,
    this.overallAccuracy = 0,
    this.dayStreak = 0,
    this.totalWords = 0,
    this.totalBadges = 0,
    this.totalLessons = 0,
    this.dailyGoal = 0,
    this.dailyGoalCompleted = 0,
    this.todayLessons = 0,
    this.totalTimeSpent = 0,
    this.badges = const [],
  });

  factory UserProgressData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const UserProgressData();

    final badgesJson = json['badges'];
    final badgeList = (badgesJson is List)
        ? badgesJson
              .map((e) => Badge.fromJson(e as Map<String, dynamic>?))
              .toList()
        : <Badge>[];

    return UserProgressData(
      readingProgress: _asInt(json['readingProgress']),
      writingProgress: _asInt(json['writingProgress']),
      speakingProgress: _asInt(json['speakingProgress']),
      presentationProgress: _asInt(json['presentationProgress']),
      vocabularyProgress: _asInt(json['vocabularyProgress']),
      overallAccuracy: _asInt(json['overallAccuracy']),
      dayStreak: _asInt(json['dayStreak']),
      totalWords: _asInt(json['totalWords']),
      totalBadges: _asInt(json['totalBadges']),
      totalLessons: _asInt(json['totalLessons']),
      dailyGoal: _asInt(json['dailyGoal']),
      dailyGoalCompleted: _asInt(json['dailyGoalCompleted']),
      todayLessons: _asInt(json['todayLessons']),
      totalTimeSpent: _asInt(json['totalTimeSpent']),
      badges: badgeList,
    );
  }
}

class Badge {
  final String name;
  final String type;
  final DateTime? earnedAt;

  const Badge({this.name = '', this.type = '', this.earnedAt});

  factory Badge.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const Badge();

    return Badge(
      name: (json['name'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      earnedAt: _asDateTime(json['earnedAt']),
    );
  }
}

/// ------- helpers (null-safe) -------
int _asInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

DateTime? _asDateTime(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String) return DateTime.tryParse(v);
  return null;
}
