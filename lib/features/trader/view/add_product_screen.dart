import 'package:flutter/material.dart';
import '../widgets/products/product_submission_dialog.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _price = TextEditingController();
  final _category = TextEditingController();
  final _stock = TextEditingController();
  final _location = TextEditingController();
  final _description = TextEditingController();

  final List<String> _images = [];
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _category.dispose();
    _stock.dispose();
    _location.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('add_at_least_one_image'.tr(context)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _saving = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _saving = false);

    // Show success dialog
    await ProductSubmissionDialog.show(context);
  }

  void _mockAddImage() {
    setState(() {
      _images.add(
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800');
    });
  }

  void _removeImage(int index) => setState(() => _images.removeAt(index));

  void _showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('select_category'.tr(context),
                  style: AppTextStyles.h3(context)),
            ),
            Expanded(
              child: ListView(
                children: [
                  _categoryTile('all'),
                  _categoryTile('sofas'),
                  _categoryTile('chairs'),
                  _categoryTile('tables'),
                  _categoryTile('beds'),
                  _categoryTile('storage'),
                  _categoryTile('desks'),
                  _categoryTile('cabinets'),
                  _categoryTile('lighting'),
                  _categoryTile('carpets'),
                  _categoryTile('curtains'),
                  _categoryTile('shelves'),
                  _categoryTile('outdoor'),
                  _categoryTile('kids'),
                  _categoryTile('office'),
                  _categoryTile('kitchen'),
                  _categoryTile('bathroom'),
                  _categoryTile('decor'),
                  _categoryTile('antique'),
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(Icons.add_circle, color: AppColors.primary),
                    title: Text('add_new_category'.tr(context)),
                    onTap: () {
                      Navigator.pop(context);
                      _showAddCategoryDialog();
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryTile(String catId) {
    return ListTile(
      title: Text('categories_$catId'.tr(context)),
      onTap: () {
        setState(() => _category.text = 'categories_$catId'.tr(context));
        Navigator.pop(context);
      },
    );
  }

  void _showAddCategoryDialog() {
    final newCatController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('add_new_category'.tr(context)),
        content: TextField(
          controller: newCatController,
          decoration: InputDecoration(
            hintText: 'category_name'.tr(context),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr(context)),
          ),
          ElevatedButton(
            onPressed: () {
              if (newCatController.text.trim().isEmpty) return;

              setState(() => _category.text = newCatController.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('category_added'.tr(context)),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('add'.tr(context)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            Text('add_product'.tr(context), style: AppTextStyles.h3(context)),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        children: [
          _SectionCard(
            icon: Icons.photo_library_outlined,
            title: 'product_images'.tr(context),
            child: _ImagesGalleryPicker(
              images: _images,
              onAdd: _mockAddImage,
              onRemove: _removeImage,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          _SectionCard(
            icon: Icons.inventory_2_outlined,
            title: 'product_info'.tr(context),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _TraderTextField(
                    label: 'product_name'.tr(context),
                    prefixIcon: Icons.text_fields,
                    controller: _name,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'required_field'.tr(context)
                        : null,
                  ),
                  const SizedBox(height: 14),
                  _TraderTextField(
                    label: 'price'.tr(context),
                    prefixIcon: Icons.payments_outlined,
                    controller: _price,
                    keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'required_field'.tr(context)
                        : null,
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () => _showCategoryPicker(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _category,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'required_field'.tr(context)
                            : null,
                        decoration: InputDecoration(
                          labelText: 'category'.tr(context),
                          labelStyle:
                              AppTextStyles.bodyMedium(context).copyWith(
                            color: AppColors.textSecondary,
                          ),
                          filled: true,
                          fillColor: AppColors.background,
                          prefixIcon: const Icon(Icons.category_outlined,
                              color: AppColors.primary),
                          suffixIcon: const Icon(Icons.arrow_drop_down,
                              color: AppColors.primary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMedium),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _TraderTextField(
                    label: 'stock'.tr(context),
                    prefixIcon: Icons.numbers_outlined,
                    controller: _stock,
                    keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'required_field'.tr(context)
                        : null,
                  ),
                  const SizedBox(height: 14),
                  _TraderTextField(
                    label: 'made_in_or_location'.tr(context),
                    prefixIcon: Icons.location_on_outlined,
                    controller: _location,
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _description,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'description'.tr(context),
                      hintStyle: AppTextStyles.bodyMedium(context)
                          .copyWith(color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          _PrimaryButton(
            text: 'save'.tr(context),
            icon: Icons.check_circle_outline,
            isLoading: _saving,
            onPressed: _save,
          ),
          const SizedBox(height: 110),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SectionCard(
      {required this.icon, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Text(title, style: AppTextStyles.h4(context)),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _ImagesGalleryPicker extends StatelessWidget {
  final List<String> images;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;

  const _ImagesGalleryPicker({
    required this.images,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: images.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _AddTile(onTap: onAdd);
          }

          final url = images[index - 1];
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  url,
                  width: 92,
                  height: 92,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 92,
                    height: 92,
                    color: AppColors.background,
                    child: const Icon(Icons.image_not_supported,
                        color: AppColors.primaryLight),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () => onRemove(index - 1),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: AppColors.shadowLight, blurRadius: 8)
                      ],
                    ),
                    child: const Icon(Icons.close,
                        size: 16, color: AppColors.error),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  final VoidCallback onTap;
  const _AddTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(Icons.add_photo_alternate_outlined,
            color: Colors.white, size: 28),
      ),
    );
  }
}

class _TraderTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const _TraderTextField({
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.keyboardType,
    // ignore: unused_element_parameter
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodyMedium(context).copyWith(
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.background,
        prefixIcon: Icon(prefixIcon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isLoading;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(text, style: AppTextStyles.buttonStatic),
                ],
              ),
      ),
    );
  }
}
