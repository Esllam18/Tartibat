import 'package:equatable/equatable.dart';
import 'package:tartibat/features/customer/data/models/favorite_model.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteModel> favorites;

  const FavoritesLoaded(this.favorites);

  int get count => favorites.length;
  bool get isEmpty => favorites.isEmpty;

  bool isFavorite(String productId) {
    return favorites.any((f) => f.id == productId);
  }

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteAddedSuccess extends FavoritesState {
  final String productName;

  const FavoriteAddedSuccess(this.productName);

  @override
  List<Object?> get props => [productName];
}

class FavoriteRemovedSuccess extends FavoritesState {
  final String productName;

  const FavoriteRemovedSuccess(this.productName);

  @override
  List<Object?> get props => [productName];
}
