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
      emit(FavoritesLoaded(List.from(_cachedFavorites)));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(Product product) async {
    final isFav = _cachedFavorites.any((f) => f.id == product.id);

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
        emit(FavoriteAddedSuccess(favorite.name));
        emit(FavoritesLoaded(List.from(_cachedFavorites)));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
      emit(FavoritesLoaded(List.from(_cachedFavorites)));
    }
  }

  Future<void> removeFavorite(String productId) async {
    try {
      // Get product name before removing
      final favorite = _cachedFavorites.firstWhere(
        (f) => f.id == productId,
        orElse: () => FavoriteModel(
          id: '',
          name: 'Product',
          nameAr: 'المنتج',
          price: 0,
          imageUrl: '',
          merchant: '',
          category: '',
          addedAt: DateTime.now(),
        ),
      );

      final success = await _service.removeFavorite(productId);

      if (success) {
        _cachedFavorites.removeWhere((f) => f.id == productId);
        emit(FavoritesLoaded(List.from(_cachedFavorites)));
        emit(FavoriteRemovedSuccess(favorite.name));
        emit(FavoritesLoaded(List.from(_cachedFavorites)));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
      emit(FavoritesLoaded(List.from(_cachedFavorites)));
    }
  }

  Future<void> clearAll() async {
    try {
      await _service.clearAll();
      _cachedFavorites.clear();
      emit(FavoritesLoaded(const []));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(String productId) {
    return _cachedFavorites.any((f) => f.id == productId);
  }
}
