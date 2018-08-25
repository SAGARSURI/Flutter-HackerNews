import 'dart:async';

import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'dart:convert';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchAllIds() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItemById(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final parseJson = json.decode(response.body);
    final itemModel = ItemModel.fromJson(parseJson);
    return itemModel;
  }
}
