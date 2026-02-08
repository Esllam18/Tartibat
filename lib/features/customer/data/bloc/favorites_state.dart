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

class FavoriteAdded extends FavoritesState {
  final FavoriteModel favorite;

  const FavoriteAdded(this.favorite);

  @override
  List<Object?> get props => [favorite];
}

class FavoriteRemoved extends FavoritesState {
  final String productId;

  const FavoriteRemoved(this.productId);

  @override
  List<Object?> get props => [productId];
}
