class Music {
  final String id;
  final String name;
  final String author;
  final String file;
  bool isPlaying;

  Music(
      {required this.id,
      required this.name,
      required this.author,
      required this.file,
      this.isPlaying = false});
}
