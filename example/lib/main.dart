import 'package:memescraper/memescraper.dart';

void main() {
  // listMiniMemesAndMemes();
  findMemeInfo();
}

void listMiniMemesAndMemes() async {
  var list = await MemeScraper.listMemes(
      type: Type.confirmed, sortedBy: SortedBy.oldest, page: 2);
  for (var mini in list) {
    print('Mini : ');
    print(mini);
    print('\n');
    print('Meme : ');
    print(await MemeScraper.miniMemeToMeme(mini));
    print('\n');
  }
}

void findMemeInfo() async {
  var meme = await MemeScraper.getMemeInfo('rickroll');
  print(meme);
}
