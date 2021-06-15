import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_pelicula/constant/constant.dart';
import 'package:flutter_application_pelicula/providers/models/movie_model.dart';

class MoviesApi with ChangeNotifier {
  MoviesApi() {
    this.getMovies();
    this.getPopularMovies();
  }
  List<MovieModel> movies = [];
  List<MovieModel> popularMovies = [];
  bool _isLoading = true;
  bool get isLoading => this._isLoading;

  getMovies() async {
    final url = Uri.https(kurl, '3/movie/now_playing', {
      'api_key': kApiKey,
      'language': kLanguage,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dataJson = json.decode(response.body);
      this.movies.addAll((dataJson['results'] as List)
          .map((item) => MovieModel.fromJson(item))
          .toList());
    } else
      print('Request failed, status: ${response.statusCode}.');

    this._isLoading = false;
    notifyListeners();
  }

  getPopularMovies() async {
    final url = Uri.https(kurl, '3/movie/popular', {
      'api_key': kApiKey,
      'language': kLanguage,
    });

    this._isLoading = true;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dataJson = json.decode(response.body);
      this.popularMovies.addAll((dataJson['results'] as List)
          .map((item) => MovieModel.fromJson(item))
          .toList());
    } else
      print('Request failed, status: ${response.statusCode}.');

    this._isLoading = false;
    notifyListeners();
  }

  Future<List<MovieModel>> getMovies2() async {
    final url = Uri.https(kurl, '3/movie/now_playing', {
      'api_key': kApiKey,
      'language': kLanguage,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dataJson = json.decode(response.body);
      return (dataJson['results'] as List)
          .map((item) => MovieModel.fromJson(item))
          .toList();
    } else
      return [];
  }
}
