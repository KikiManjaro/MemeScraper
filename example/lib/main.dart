import 'package:memescraper/memescraper.dart';

void main() async {
  var list = await MemeScraper.listMemes(
      type: Type.confirmed, sortedBy: SortedBy.newest, page: 2);
  for (var mini in list) {
    print('Mini : ');
    print(mini);
    print('\n');
    print('Meme : ');
    print(await MemeScraper.miniMemeToMeme(mini));
    print('\n');
  }
}
