import 'dart:async';
import 'dart:convert';
import 'package:app_flutter_film/src/models/actors_model.dart';
import 'package:http/http.dart' as http;

import 'package:app_flutter_film/src/models/film_model.dart';

class FilmsProvider{
  String _apiKey    = '24eea1a4dd8a4b6122aade032afb97fb';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';
  
  int _popularesPage = 0;
  bool _loading = false;

  List<Film> _populares = new List();

  final _popularesStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Film>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Film>> _processResult (Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final films = new Films.fromJsonList(decodedData['results']);

    //print(decodedData['results']);
    //print(films.items[0].title);

    return films.items;
  }

  Future<List<Film>> getNowMovie() async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language
    });

    return await _processResult(url);
  }

  Future<List<Film>> getPopulares() async{
    
    if(_loading) return [];
    
    _loading=true;
    _popularesPage++;

    print('Loading nexts...');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language,
      'page' : _popularesPage.toString()
    });

    final resp = await _processResult(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _loading=false;
    return resp;
  }

  Future<List<Actor>> getActors(String filmId) async{
    final url = Uri.https(_url, '3/movie/$filmId/credits',{
      'api_key' : _apiKey,
      'language' : _language,
    });

    final resp = await http.get(url);

    final decodeData = json.decode(resp.body);

    final actors = new Actors.fromJsonList(decodeData['cast']);

    return actors.actors;
  }

  Future<List<Film>> searchFilm(String query) async{
    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apiKey,
      'language' : _language,
      'query' : query
    });

    return await _processResult(url);
  }

}