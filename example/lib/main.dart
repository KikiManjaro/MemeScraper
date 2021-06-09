import 'package:memescraper/memescraper.dart';

void main() async {
  var list = await MemeScraper.listMemes(type: Type.confirmed, sortedBy: SortedBy.newest);
  for (var mini in list) {
    print(mini);
  }
}
