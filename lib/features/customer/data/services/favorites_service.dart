import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite_model.dart';

class FavoritesService {
  static const String _key = 'user_favorites';
  static FavoritesService? _instance;
  SharedPreferences? _prefs;

  FavoritesService._();

  static Future<FavoritesService> getInstance() async {
    _instance ??= FavoritesService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<List<FavoriteModel>> getFavorites() async {
    try {
      final String? favoritesJson = _prefs?.getString(_key);
      if (favoritesJson == null || favoritesJson.isEmpty) return [];

      final List<dynamic> decoded = jsonDecode(favoritesJson);
      return decoded.map((item) => FavoriteModel.fromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addFavorite(FavoriteModel favorite) async {
    try {
      final favorites = await getFavorites();

      if (favorites.any((f) => f.id == favorite.id)) {
        return false;
      }

      favorites.add(favorite);
      final success = await _saveFavorites(favorites);
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFavorite(String productId) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere((f) => f.id == productId);
      final success = await _saveFavorites(favorites);
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isFavorite(String productId) async {
    final favorites = await getFavorites();
    return favorites.any((f) => f.id == productId);
  }

  Future<bool> clearAll() async {
    try {
      return await _prefs?.remove(_key) ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _saveFavorites(List<FavoriteModel> favorites) async {
    try {
      final String encoded = jsonEncode(
        favorites.map((f) => f.toJson()).toList(),
      );
      final success = await _prefs?.setString(_key, encoded) ?? false;
      return success;
    } catch (e) {
      return false;
    }
  }
}
