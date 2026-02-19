class AchievementModel {
  final List<Achievement> data;

  const AchievementModel({this.data = const []});

  factory AchievementModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const AchievementModel();

    final raw = json['data'];
    final list = (raw is List)
        ? raw.map((e) => Achievement.fromJson(e as Map<String, dynamic>?)).toList()
        : <Achievement>[];

    return AchievementModel(data: list);
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class Achievement {
  final String id;
  final String name;
  final String type;
  final String icon;
  final String description;
  final String requirement;
  final int targetValue;
  final bool isUnlocked;
  final DateTime? earnedAt;
  final AchievementProgress progress;

  const Achievement({
    this.id = '',
    this.name = '',
    this.type = '',
    this.icon = '',
    this.description = '',
    this.requirement = '',
    this.targetValue = 0,
    this.isUnlocked = false,
    this.earnedAt,
    this.progress = const AchievementProgress(),
  });

  factory Achievement.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const Achievement();

    return Achievement(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      icon: (json['icon'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      requirement: (json['requirement'] ?? '').toString(),
      targetValue: _asInt(json['targetValue']),
      isUnlocked: _asBool(json['isUnlocked']),
      earnedAt: _asDateTime(json['earnedAt']),
      progress: AchievementProgress.fromJson(
        json['progress'] as Map<String, dynamic>?,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'icon': icon,
    'description': description,
    'requirement': requirement,
    'targetValue': targetValue,
    'isUnlocked': isUnlocked,
    'earnedAt': earnedAt?.toIso8601String(),
    'progress': progress.toJson(),
  };
}

class AchievementProgress {
  final int current;
  final int target;
  final int percentage;

  const AchievementProgress({
    this.current = 0,
    this.target = 0,
    this.percentage = 0,
  });

  factory AchievementProgress.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const AchievementProgress();

    return AchievementProgress(
      current: _asInt(json['current']),
      target: _asInt(json['target']),
      percentage: _asInt(json['percentage']),
    );
  }

  Map<String, dynamic> toJson() => {
    'current': current,
    'target': target,
    'percentage': percentage,
  };
}

/// -------- helpers (null-safe) --------
int _asInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

bool _asBool(dynamic v) {
  if (v == null) return false;
  if (v is bool) return v;
  if (v is num) return v != 0;
  if (v is String) {
    final s = v.toLowerCase();
    return s == 'true' || s == '1' || s == 'yes';
  }
  return false;
}

DateTime? _asDateTime(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String) return DateTime.tryParse(v);
  return null;
}
