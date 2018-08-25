import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[newsDbProvider, NewsApiProvider()];
  List<Cache> caches = <Cache>[newsDbProvider];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchAllIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source; //changed from Source to var because newsDbProvider has the same instance
    for (source in sources) {
      item = await source.fetchItemById(id);
      if (item != null) {
        break;
      }
    }
    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }
    return item;
  }

  clearCache() async {
    for(var cache in caches){
        await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchAllIds();

  Future<ItemModel> fetchItemById(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
