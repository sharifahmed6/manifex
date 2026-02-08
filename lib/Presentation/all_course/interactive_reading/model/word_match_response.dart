class WordMatchResponse {
  final bool success;
  final String message;
  final WordMatchData data;

  WordMatchResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WordMatchResponse.fromJson(Map<String, dynamic> json) {
    return WordMatchResponse(
      success: json["success"] == true,
      message: (json["message"] ?? "").toString(),
      data: WordMatchData.fromJson((json["data"] ?? {}) as Map<String, dynamic>),
    );
  }
}

class WordMatchData {
  final String sessionName;
  final List<WordItem> words;
  final List<ImageItem> images;

  WordMatchData({
    required this.sessionName,
    required this.words,
    required this.images,
  });

  factory WordMatchData.fromJson(Map<String, dynamic> json) {
    final w = (json["words"] as List? ?? [])
        .map((e) => WordItem.fromJson(e as Map<String, dynamic>))
        .toList();

    final im = (json["images"] as List? ?? [])
        .map((e) => ImageItem.fromJson(e as Map<String, dynamic>))
        .toList();

    return WordMatchData(
      sessionName: (json["sessionName"] ?? "").toString(),
      words: w,
      images: im,
    );
  }

  String? imageUrlById(String id) {
    for (final img in images) {
      if (img.id == id) return img.url;
    }
    return null;
  }
}

class WordItem {
  final String id;
  final String text;

  WordItem({required this.id, required this.text});

  factory WordItem.fromJson(Map<String, dynamic> json) {
    return WordItem(
      id: (json["id"] ?? "").toString(),
      text: (json["text"] ?? "").toString(),
    );
  }
}

class ImageItem {
  final String id;
  final String url;

  ImageItem({required this.id, required this.url});

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    return ImageItem(
      id: (json["id"] ?? "").toString(),
      url: (json["url"] ?? "").toString(),
    );
  }
}
