import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/models/favorite_model.dart';
import 'package:tartibat/features/customer/data/models/product_model.dart';
import 'package:tartibat/features/customer/data/services/favorites_service.dart';

import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesService _service;
  List<FavoriteModel> _cachedFavorites = [];

  FavoritesCubit(this._service) : super(const FavoritesInitial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      emit(const FavoritesLoading());
      _cachedFavorites = await _service.getFavorites();
      emit(FavoritesLoaded(_cachedFavorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(Product product) async {
    final isFav = await _service.isFavorite(product.id);

    if (isFav) {
      await removeFavorite(product.id);
    } else {
      await addFavorite(product);
    }
  }

  Future<void> addFavorite(Product product) async {
    try {
      final favorite = FavoriteModel(
        id: product.id,
        name: product.name,
        nameAr: product.nameAr,
        price: product.price,
        imageUrl: product.imageUrl,
        merchant: product.merchant,
        category: product.category,
        addedAt: DateTime.now(),
      );

      final success = await _service.addFavorite(favorite);

      if (success) {
        _cachedFavorites.add(favorite);
        emit(FavoritesLoaded(List.from(_cachedFavorites)));
        emit(FavoriteAdded(favorite));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> removeFavorite(String productId) async {
    try {
      final success = await _service.removeFavorite(productId);

      if (success) {
        _cachedFavorites.removeWhere((f) => f.id == productId);
        emit(FavoritesLoaded(List.from(_cachedFavorites)));
        emit(FavoriteRemoved(productId));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> clearAll() async {
    try {
      await _service.clearAll();
      _cachedFavorites.clear();
      emit(FavoritesLoaded([]));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(String productId) {
    return _cachedFavorites.any((f) => f.id == productId);
  }
}
