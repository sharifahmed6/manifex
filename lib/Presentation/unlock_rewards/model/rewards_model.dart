class RewardModel {
  final bool success;
  final String message;
  final RewardData data;

  RewardModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RewardModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RewardModel(
      success: _asBool(json['success'], defaultValue: false),
      message: _asString(json['message'], defaultValue: ''),
      data: RewardData.fromJson(
        json['data'] is Map<String, dynamic> ? json['data'] : null,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

class RewardData {
  final bool canUnlock;
  final bool alreadyUnlocked;
  final RewardVideo? unlockedVideo;
  final RewardProgress progress;

  RewardData({
    required this.canUnlock,
    required this.alreadyUnlocked,
    required this.unlockedVideo,
    required this.progress,
  });

  factory RewardData.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RewardData(
      canUnlock: _asBool(json['canUnlock'], defaultValue: false),
      alreadyUnlocked: _asBool(json['alreadyUnlocked'], defaultValue: false),
      unlockedVideo: json['unlockedVideo'] is Map<String, dynamic>
          ? RewardVideo.fromJson(json['unlockedVideo'])
          : null,
      progress: RewardProgress.fromJson(
        json['progress'] is Map<String, dynamic> ? json['progress'] : null,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'canUnlock': canUnlock,
    'alreadyUnlocked': alreadyUnlocked,
    'unlockedVideo': unlockedVideo?.toJson(),
    'progress': progress.toJson(),
  };
}

class RewardVideo {
  final String id;
  final String title;
  final String description;
  final String category;
  final String videoUrl;
  final int views;

  RewardVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.videoUrl,
    required this.views,
  });

  factory RewardVideo.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RewardVideo(
      id: _asString(json['id'], defaultValue: ''),
      title: _asString(json['title'], defaultValue: ''),
      description: _asString(json['description'], defaultValue: ''),
      category: _asString(json['category'], defaultValue: ''),
      videoUrl: _asString(json['videoUrl'], defaultValue: ''),
      views: _asInt(json['views'], defaultValue: 0),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'videoUrl': videoUrl,
    'views': views,
  };
}

class RewardProgress {
  final int completedCount;
  final int totalCount;
  final int remainingCount;
  final double percentage;
  final RewardTaskStatus taskStatus;

  RewardProgress({
    required this.completedCount,
    required this.totalCount,
    required this.remainingCount,
    required this.percentage,
    required this.taskStatus,
  });

  factory RewardProgress.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RewardProgress(
      completedCount: _asInt(json['completedCount'], defaultValue: 0),
      totalCount: _asInt(json['totalCount'], defaultValue: 0),
      remainingCount: _asInt(json['remainingCount'], defaultValue: 0),
      percentage: _asDouble(json['percentage'], defaultValue: 0),
      taskStatus: RewardTaskStatus.fromJson(
        json['taskStatus'] is Map<String, dynamic> ? json['taskStatus'] : null,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'completedCount': completedCount,
    'totalCount': totalCount,
    'remainingCount': remainingCount,
    'percentage': percentage,
    'taskStatus': taskStatus.toJson(),
  };
}

class RewardTaskStatus {
  final bool reading;
  final bool adult;
  final bool writing;
  final bool speaking;
  final bool presentation;

  RewardTaskStatus({
    required this.reading,
    required this.adult,
    required this.writing,
    required this.speaking,
    required this.presentation,
  });

  factory RewardTaskStatus.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RewardTaskStatus(
      reading: _asBool(json['reading'], defaultValue: false),
      adult: _asBool(json['adult'], defaultValue: false),
      writing: _asBool(json['writing'], defaultValue: false),
      speaking: _asBool(json['speaking'], defaultValue: false),
      presentation: _asBool(json['presentation'], defaultValue: false),
    );
  }

  Map<String, dynamic> toJson() => {
    'reading': reading,
    'adult': adult,
    'writing': writing,
    'speaking': speaking,
    'presentation': presentation,
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