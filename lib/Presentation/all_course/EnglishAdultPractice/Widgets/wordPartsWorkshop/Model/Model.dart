class WordPartsModel {
  final List<String> suffix;
  final List<String> root;
  final List<String> prefix;
  final List<String> suffixMeaning;
  final List<String> rootMeaning;
  final List<String> prefixMeaning;

  WordPartsModel({
    required this.suffix,
    required this.root,
    required this.prefix,
    required this.suffixMeaning,
    required this.rootMeaning,
    required this.prefixMeaning,
  });

  factory WordPartsModel.fromJson(Map<String, dynamic> json) {
    return WordPartsModel(
      suffix: List<String>.from(json['suffix'] ?? []),
      root: List<String>.from(json['root'] ?? []),
      prefix: List<String>.from(json['prefix'] ?? []),
      suffixMeaning: List<String>.from(json['suffix_meaning'] ?? []),
      rootMeaning: List<String>.from(json['root_meaning'] ?? []),
      prefixMeaning: List<String>.from(json['prefix_meaning'] ?? []),
    );
  }
}
