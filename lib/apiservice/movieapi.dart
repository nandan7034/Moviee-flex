import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_1/model/model.dart';
import 'package:http/http.dart' as http;

const apiKey = "f95a6d45558dee5ab593965b75e80dfd";

class Movieapi {
  final trending =
      "https://api.themoviedb.org/3/trending/all/week?api_key=$apiKey";

  final upcoming =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";

  final popular = "https://api.themoviedb.org/3/person/popular?api_key=$apiKey";

  /// TRENDING MOVIES
  Future<List<Movie>> getdata() async {
    try {
      Uri url = Uri.parse(trending);

      final response = await http.get(url);

      log(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];

        return data.map((e) => Movie.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load data : ${response.statusCode}");
      }
    } catch (e) {
      log("ERROR : $e");
      return [];
    }
  }

  /// UPCOMING MOVIES
  Future<List<Movie>> upgetdata() async {
    try {
      Uri url = Uri.parse(upcoming);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];

        return data.map((e) => Movie.fromJson(e)).toList();
      } else {
        throw Exception("Failed : ${response.statusCode}");
      }
    } catch (e) {
      log("ERROR : $e");
      return [];
    }
  }

  Future<List<MoviePop>> popget() async {
    try {
      Uri url = Uri.parse(popular);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];
        return data.map((e) => MoviePop.fromJson(e)).toList();
      } else {
        throw Exception("failed");
      }
    } catch (e) {
      log("error$e");
      return [];
    }
  }
}
