import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart';

void main(){
  test('Testing the ids coming from network',() async {
    //setup the test
    final newsProvider = NewsApiProvider();

    newsProvider.client = MockClient((request) async {
      return Response(json.encode([1,2,3,4]),200);
    });

    //expectation
    final ids = await newsProvider.fetchAllIds();
    expect(ids, [1,2,3,4]);
  });

  test('Fetch itemModel by id', () async {
    final newsProvider = NewsApiProvider();
    newsProvider.client = MockClient((request) async {
      final mapJson = {'id':123};
      return Response(json.encode(mapJson),200);
    });
    final item = await newsProvider.fetchItemById(999);
    expect(item.id, 123);
  });
}