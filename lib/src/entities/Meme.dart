class Meme {
  String name;
  String image;
  String status;
  String origin;
  String year;
  String type;
  String about;
  String link;

  Meme();

  @override
  String toString() {
    return 'Meme{name: $name, image: $image, status: $status, origin: $origin, year: $year, type: $type, about: $about, link: $link}';
  }
}
