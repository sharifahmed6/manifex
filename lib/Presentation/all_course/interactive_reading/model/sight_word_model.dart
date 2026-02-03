enum WordState { normal, correct, wrong }
class SentenceWord {
  final int id;
  final String text;
  final String clean;
  WordState state;

  SentenceWord({
    required this.id,
    required this.text,
    required this.clean,
    this.state = WordState.normal,
  });
}