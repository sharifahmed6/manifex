class UserBadgesResponse {
  final bool success;
  final String message;
  final List<Badge> data;

  UserBadgesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserBadgesResponse.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    final rawList = json['data'];

    return UserBadgesResponse(
      success: _asBool(json['success'], defaultValue: false),
      message: _asString(json['message'], defaultValue: ''),
      data: rawList is List
          ? rawList
          .map((e) => Badge.fromJson(e is Map<String, dynamic> ? e : null))
          .toList()
          : <Badge>[],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class Badge {
  final String id;
  final String name;
  final String type;
  final String icon;
  final String description;
  final String requirement;
  final int targetValue;
  final bool isUnlocked;
  final DateTime? earnedAt;
  final Progress progress;

  Badge({
    required this.id,
    required this.name,
    required this.type,
    required this.icon,
    required this.description,
    required this.requirement,
    required this.targetValue,
    required this.isUnlocked,
    required this.earnedAt,
    required this.progress,
  });

  factory Badge.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Badge(
      id: _asString(json['id'], defaultValue: ''),
      name: _asString(json['name'], defaultValue: ''),
      type: _asString(json['type'], defaultValue: ''),
      icon: _asString(json['icon'], defaultValue: ''),
      description: _asString(json['description'], defaultValue: ''),
      requirement: _asString(json['requirement'], defaultValue: ''),
      targetValue: _asInt(json['targetValue'], defaultValue: 0),
      isUnlocked: _asBool(json['isUnlocked'], defaultValue: false),
      earnedAt: _asDateTime(json['earnedAt']),
      progress: Progress.fromJson(
        json['progress'] is Map<String, dynamic> ? json['progress'] : null,
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

class Progress {
  final int current;
  final int target;
  final double percentage;

  Progress({
    required this.current,
    required this.target,
    required this.percentage,
  });

  factory Progress.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Progress(
      current: _asInt(json['current'], defaultValue: 0),
      target: _asInt(json['target'], defaultValue: 0),
      percentage: _asDouble(json['percentage'], defaultValue: 0),
    );
  }

  Map<String, dynamic> toJson() => {
    'current': current,
    'target': target,
    'percentage': percentage,
  };
}

/// ----------------------
/// Safe Cast Helpers
/// ----------------------

String _asString(dynamic v, {String defaultValue = ''}) {
  if (v == null) return defaultValue;
  if (v is String) return v;
  return v.toString();
}

int _asInt(dynamic v, {int defaultValue = 0}) {
  if (v == null) return defaultValue;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? defaultValue;
  return defaultValue;
}

double _asDouble(dynamic v, {double defaultValue = 0}) {
  if (v == null) return defaultValue;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? defaultValue;
  return defaultValue;
}

bool _asBool(dynamic v, {bool defaultValue = false}) {
  if (v == null) return defaultValue;
  if (v is bool) return v;
  if (v is String) {
    final s = v.toLowerCase().trim();
    if (s == 'true' || s == '1' || s == 'yes') return true;
    if (s == 'false' || s == '0' || s == 'no') return false;
  }
  if (v is num) return v != 0;
  return defaultValue;
}

DateTime? _asDateTime(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String) return DateTime.tryParse(v);
  return null;
}