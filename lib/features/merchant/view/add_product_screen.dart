import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/core/widgets/category_selector.dart';
import '../../../core/widgets/media_picker.dart'; // ✅ Fixed import path
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../bloc/merchant_products_cubit.dart';
import '../bloc/merchant_products_state.dart';
import '../../customer/data/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameArController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  List<String> _mediaPaths = [];
  bool _isAvailable = true;

  @override
  void dispose() {
    _nameController.dispose();
    _nameArController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return BlocListener<MerchantProductsCubit, MerchantProductsState>(
      listener: (context, state) {
        if (state is ProductAdded) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  SizedBox(width: r.spacing(12)),
                  Text('product_added_successfully'.tr(context)),
                ],
              ),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: EdgeInsets.all(r.spacing(8)),
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back,
                  color: AppColors.textPrimary, size: 20),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'add_new_product'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(r.spacing(20)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Media Picker Section
                  Container(
                    padding: EdgeInsets.all(r.spacing(16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.photo_library,
                                color: AppColors.primary, size: 24),
                            SizedBox(width: r.spacing(12)),
                            Text(
                              'product_media'.tr(context),
                              style: GoogleFonts.cairo(
                                fontSize: r.fontSize(16),
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: r.spacing(16)),
                        MediaPicker(
                          paths: _mediaPaths,
                          onChanged: (paths) {
                            setState(() {
                              _mediaPaths = paths;
                            });
                            print(
                                '✅ Media paths updated: ${paths.length} files');
                          },
                          allowVideo: true,
                          maxMedia: 5,
                        ),
                        if (_mediaPaths.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: r.spacing(8)),
                            child: Text(
                              'add_at_least_one_image'.tr(context),
                              style: GoogleFonts.cairo(
                                fontSize: r.fontSize(12),
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: EdgeInsets.only(top: r.spacing(8)),
                            child: Text(
                              '✅ ${_mediaPaths.length} ${_mediaPaths.length == 1 ? 'file' : 'files'} selected',
                              style: GoogleFonts.cairo(
                                fontSize: r.fontSize(12),
                                color: AppColors.success,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: r.spacing(20)),

                  // Product Name (English)
                  _buildTextField(
                    controller: _nameController,
                    label: 'product_name_english'.tr(context),
                    icon: Icons.label_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_product_name'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),

                  // Product Name (Arabic)
                  _buildTextField(
                    controller: _nameArController,
                    label: 'product_name_arabic'.tr(context),
                    icon: Icons.label,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_product_name_ar'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),

                  // Price
                  _buildTextField(
                    controller: _priceController,
                    label: 'price'.tr(context),
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_price'.tr(context);
                      }
                      if (double.tryParse(value) == null) {
                        return 'invalid_price'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),

                  CategorySelector(
                    initialCategory: null,
                    onCategorySelected: (category) {
                      _categoryController.text = category;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),
                  SizedBox(height: r.spacing(20)),

                  // Available Toggle
                  Container(
                    padding: EdgeInsets.all(r.spacing(16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle_outline,
                                color: AppColors.primary),
                            SizedBox(width: r.spacing(12)),
                            Text(
                              'product_available'.tr(context),
                              style: GoogleFonts.cairo(
                                fontSize: r.fontSize(14),
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: _isAvailable,
                          onChanged: (value) =>
                              setState(() => _isAvailable = value),
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: r.spacing(32)),

                  // Add Product Button
                  SizedBox(
                    width: double.infinity,
                    height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
                    child: ElevatedButton(
                      onPressed: _addProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'add_product'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(16),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final r = context.responsive;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.cairo(
        fontSize: r.fontSize(14),
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.cairo(
          fontSize: r.fontSize(14),
          color: AppColors.textSecondary,
        ),
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      // Validate media
      if (_mediaPaths.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('please_add_product_image'.tr(context)),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }

      print('🎉 Adding product with ${_mediaPaths.length} media files');

      final product = Product(
        id: 'PROD${DateTime.now().millisecondsSinceEpoch}',
        name: _nameController.text,
        nameAr: _nameArController.text,
        price: double.parse(_priceController.text),
        category: _categoryController.text,
        imageUrl: _mediaPaths.first,
        mediaUrls: _mediaPaths,
        merchant: 'My Store',
        rating: 4.5,
        isAvailable: _isAvailable,
        isFeatured: false,
      );

      context.read<MerchantProductsCubit>().addProduct(product);
    }
  }
}
