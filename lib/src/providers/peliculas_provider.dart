import 'dart:async';

import 'package:peliculon/src/models/actores_model.dart';
import 'package:peliculon/src/models/pelicula_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class PeliculasProvider{
  String _apikey ='a1c56aeeb09d7673aaabf51372a01e84';
  String _url = 'api.themoviedb.org';
  String _language= 'es-ES';
  int _popularesPage=0;
  bool _cargando=false;
  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController <List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get populatesSink => _popularesStreamController.sink.add;
  Stream <List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }
  Future <List<Actor>> getCast(String peliculaId) async{ 
    final url = Uri.https(_url, '3/movie/$peliculaId/credits',
    {
      'api_key': _apikey,
      'language': _language
    });      
    final resp= await http.get(url);
    final decodedData = jsonDecode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);        
    return cast.items;
  }

  Future <List<Pelicula>> getEnCine() async{ 
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key': _apikey,
      'language': _language
    });      
    return await _procesarRespuesta(url);
  }
  
  Future <List<Pelicula>> getPopulares() async {
    if(_cargando) return [];
    _cargando= true;

    _popularesPage++;
    final Uri url = Uri.https(_url, '3/movie/popular',{
      'api_key': _apikey,
      'language': _language,      
      'page': _popularesPage.toString(),
    }); 

    final resp= await _procesarRespuesta(url);
    _populares.addAll(resp);
    populatesSink(_populares);
    _cargando =false;
    return resp;
  }

  Future <List<Pelicula>> _procesarRespuesta(Uri url) async{
    
    final resp= await http.get(url);
    final decodedData = jsonDecode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);        
    return peliculas.items;
  }
  Future <List<Pelicula>> buscarPelicula(String query) async{ 
    final url = Uri.https(_url, '3/search/movie',{
      'api_key': _apikey,
      'language': _language,
      'query': query
    });      
    return await _procesarRespuesta(url);
  }
}