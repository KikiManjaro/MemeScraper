import 'package:web_scraper/web_scraper.dart';

import 'entities/Meme.dart';
import 'entities/MiniMeme.dart';
import 'enum/SortedBy.dart';
import 'enum/Type.dart';
import 'enum/UnsortableType.dart';

final website = 'https://knowyourmeme.com/';

class MemeScraper {
  /// Return a Meme object containing some info found about this meme
  static Future<Meme> getMemeInfo(String memeName) async {
    final webScraper = WebScraper(website);
    final endpoint = 'memes/' + memeName;
    var meme = Meme();
    meme.link = website + 'memes/' + memeName;
    if (await webScraper.loadWebPage(endpoint)) {
      final title = webScraper.getElement('section.info > h1', ['title']);
      if (title.isNotEmpty) {
        meme.name =
            title[title.length - 1]['title'].toString().replaceAll('\n', '');
      }
      final details = webScraper.getElement(
          'div.details-col > div.detail > span, div.details-col > div.detail > div > span',
          ['span']);
      if (details.isNotEmpty) {
        if (details.length > 1) {
          meme.status = details[1]['title'].toString().replaceAll('\n', '');
        }
        if (details.length > 3) {
          meme.origin = details[3]['title'].toString().replaceAll('\n', '');
        }
        if (details.length > 5) {
          meme.year = details[5]['title'].toString().replaceAll('\n', '');
        }
        if (details.length > 7) {
          meme.type = details[7]['title'].toString().replaceAll('\n', '');
        }
      }
      final entries = webScraper
          .getElement('div.entry-section > h2, div.entry-section > p', []);
      if (entries.isNotEmpty) {
        meme.infos = createMemeInfos(entries);
      }
      final photo = webScraper.getElement('div.photo-wrapper > a', ['href']);
      if (photo.isNotEmpty) {
        meme.image = photo[photo.length - 1]['attributes']['href'].toString();
      }
      return meme;
    } else {
      return null;
    }
  }

  /// Search for a meme using a query (name, info ...) and return a List of MiniMeme
  static Future<List<MiniMeme>> searchMemeName(String query) async {
    final webScraper = WebScraper('https://knowyourmeme.com/');
    final endpoint = 'search?context=entries&sort=relevance&q=' + query;
    return await _scrapEndpointToMiniMemeList(webScraper, endpoint);
  }

  /// Transform a MiniMeme to a Meme (more info)
  static Future<Meme> miniMemeToMeme(MiniMeme miniMeme) {
    return getMemeInfo(miniMeme.name);
  }

  /// Return a Meme object containing some info found about this meme using a query
  static Future<Meme> luckySearch(String query) async {
    var list = await searchMemeName('cat');
    var relevantMeme = list[0];
    return await miniMemeToMeme(relevantMeme);
  }

  /// Return List of Meme found using Type and Sort at page number
  static Future<List<MiniMeme>> listMemes(
      {Type type = Type.confirmed,
      SortedBy sortedBy = SortedBy.newest,
      int page = 1}) async {
    final webScraper = WebScraper('https://knowyourmeme.com/');
    final endpoint = 'memes/' +
        type.getValue() +
        '/page/' +
        page.toString() +
        sortedBy.getValue();
    return await _scrapEndpointToMiniMemeList(webScraper, endpoint);
  }

  /// Return List of Meme found using Unsortable Type at page number
  static Future<List<MiniMeme>> listMemesWithUnsortedType(UnsortableType type,
      {int page = 1}) async {
    final webScraper = WebScraper('https://knowyourmeme.com/');
    final endpoint = 'memes/' + type.getValue() + '/page/' + page.toString();
    return await _scrapEndpointToMiniMemeList(webScraper, endpoint);
  }

  static Future<List<MiniMeme>> _scrapEndpointToMiniMemeList(
      //TODO: scroll to find more result
      WebScraper webScraper,
      String endpoint) async {
    if (await webScraper.loadWebPage(endpoint)) {
      final titles = webScraper
          .getElement('td > a, td > a > img', ['href', 'title', 'data-src']);
      var list = <MiniMeme>[];
      for (var i = 0; i < titles.length - 2; i = i + 2) {
        var miniMeme = MiniMeme();
        var endpoint = titles[i]['attributes']['href'].toString();
        miniMeme.link = website + endpoint;
        miniMeme.name =
            endpoint.substring(endpoint.lastIndexOf('/')).replaceAll('/', '');
        miniMeme.image = titles[i + 1]['attributes']['data-src'].toString();
        miniMeme.beautifiedName =
            titles[i + 1]['attributes']['title'].toString();
        if (_isFieldOk(miniMeme.name) && _isFieldOk(miniMeme.beautifiedName)) {
          list.add(miniMeme);
        }
      }
      return list;
    } else {
      return null;
    }
  }

  static bool _isFieldOk(String field) {
    return field != null && field.isNotEmpty && field != 'null';
  }

  static Map<String, String> createMemeInfos(
      List<Map<String, dynamic>> entries) {
    var map = <String, String>{};
    var lastTitle = '';
    for (var entry in entries) {
      String txt = entry['title'];
      if (txt.isNotEmpty) {
        if (_getSpaceCount(txt) < 3) {
          map.putIfAbsent(txt, () => '');
          lastTitle = txt;
        } else {
          map.update(lastTitle, (value) {
            txt = _removeBracketNum(txt);
            txt = _removeParenthesisTxt(txt);
            return value + txt + '\n';
          });
        }
      }
    }
    return map;
  }

  static int _getSpaceCount(String str) {
    return str.length - str.replaceAll(' ', '').length;
  }

  static String _removeBracketNum(String str) {
    str = str.replaceAll(RegExp(' \\[\\d+\\]'), '');
    str = str.replaceAll(RegExp('\\[\\d+\\]'), '');
    return str;
  }

  static String _removeParenthesisTxt(String str) {
    str = str.replaceAll(RegExp(' \\([^)]*\\)'), '');
    str = str.replaceAll(RegExp('\\([^)]*\\)'), '');
    return str;
  }
}
