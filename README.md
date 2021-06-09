[![Pub](https://img.shields.io/pub/v/memescraper.svg)](https://pub.dev/packages/memescraper)

# A non-official API for Know Your Meme

MemeScraper is a non-official API of [Know Your Meme](https://knowyourmeme.com/) made using scraping.

Pull requests are most welcome.

## Getting Started

In your `pubspec.yaml` root add:

```yaml
dependencies:
  memescrapper:
```

then,

```dart
import 'package:memescraper/memescraper.dart';
```

## Methods

| Method | Description | Arguments | Return Type
|---|---|---|---|
| getMemeInfo | Return a Meme object containing some info found about this meme | String memeName | Future `<Meme>` |
| searchMemeName | Search for a meme using a query (name, info ...) and return a List of MiniMeme | String query | Future `List<MiniMeme>` |
| miniMemeToMeme | Transform a MiniMeme to a Meme (more info) | MiniMeme miniMeme | Future `<Meme>` |
| luckySearch | Return a Meme object containing some info found about this meme using a query | String query | Future `<Meme>` |
| listMemes | Return List of Meme found using Type and Sort | Type type, SortedBy sortedBy | Future `List<MiniMeme>` |
| listMemesWithUnsortedType | Return List of Meme found using Unsortable Type | UnsortableType unsortableType | Future `List<MiniMeme>` |

## License

Created by KikiManjaro from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).