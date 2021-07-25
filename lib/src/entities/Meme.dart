class Meme {
  String name;
  String image;
  String status;
  String origin;
  String year;
  String type;
  String link;
  Map<String, String> infos;

  Meme();

  @override
  String toString() {
    return 'Meme{name: $name, image: $image, status: $status, origin: $origin, year: $year, type: $type, link: $link, infos: $infos}';
  }
}
