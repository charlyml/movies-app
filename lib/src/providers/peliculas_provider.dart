import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_movies/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = "4a8d8e5afc13997e9f1503e94b20b1ba";
  String _url = "api.themoviedb.org";
  String language = "es-ES";

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apiKey, 'language': language});

    return await _procesarRespuesta(url);
  }
}
