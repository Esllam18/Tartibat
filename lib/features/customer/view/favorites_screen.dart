import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/loading_state.dart';
import '../widgets/favorites/favorites_app_bar.dart';
import '../widgets/favorites/favorites_grid.dart';
import '../widgets/favorites/favorites_empty.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isLoading = true;
  final List<Map<String, dynamic>> _favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _removeItem(int index) {
    setState(() => _favoriteItems.removeAt(index));
  }

  void _clearAll() {
    setState(() => _favoriteItems.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: FavoritesAppBar(
        itemCount: _favoriteItems.length,
        onClearAll: _favoriteItems.isNotEmpty ? _clearAll : null,
      ),
      body: _isLoading
          ? const LoadingState()
          : _favoriteItems.isEmpty
              ? const FavoritesEmpty()
              : FavoritesGrid(items: _favoriteItems, onRemove: _removeItem),
    );
  }
}
