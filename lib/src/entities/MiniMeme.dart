class MiniMeme {
  String name;
  String beautifiedName;
  String image;
  String link;

  MiniMeme();

  @override
  String toString() {
    return 'MiniMeme{name: $name, beautifiedName: $beautifiedName, image: $image, link: $link}';
  }
}