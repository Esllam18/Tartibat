import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/core/widgets/category_selector.dart';
import 'package:tartibat/core/widgets/media_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../bloc/merchant_products_cubit.dart';
import '../bloc/merchant_products_state.dart';
import '../../customer/data/models/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _nameArController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late List<String> _mediaPaths;
  late bool _isAvailable;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _nameArController = TextEditingController(text: widget.product.nameAr);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _categoryController = TextEditingController(text: widget.product.category);
    _mediaPaths = List.from(widget.product.mediaUrls.isEmpty
        ? [widget.product.imageUrl]
        : widget.product.mediaUrls);
    _isAvailable = widget.product.isAvailable;
  }

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
        if (state is ProductUpdated) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  SizedBox(width: r.spacing(12)),
                  Text('product_updated_successfully'.tr(context)),
                ],
              ),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
            'edit_product'.tr(context),
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
                  // Media Picker
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
                          onChanged: (paths) =>
                              setState(() => _mediaPaths = paths),
                          allowVideo: true,
                          maxMedia: 5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: r.spacing(20)),

                  // Form fields
                  _buildTextField(
                    controller: _nameController,
                    label: 'product_name_english'.tr(context),
                    icon: Icons.label_outline,
                    validator: (v) => v?.isEmpty ?? true
                        ? 'please_enter_product_name'.tr(context)
                        : null,
                  ),
                  SizedBox(height: r.spacing(16)),
                  _buildTextField(
                    controller: _nameArController,
                    label: 'product_name_arabic'.tr(context),
                    icon: Icons.label,
                    validator: (v) => v?.isEmpty ?? true
                        ? 'please_enter_product_name_ar'.tr(context)
                        : null,
                  ),
                  SizedBox(height: r.spacing(16)),
                  _buildTextField(
                    controller: _priceController,
                    label: 'price'.tr(context),
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v?.isEmpty ?? true) {
                        return 'please_enter_price'.tr(context);
                      }
                      if (double.tryParse(v!) == null) {
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

                  // Available toggle
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

                  // Update button
                  SizedBox(
                    width: double.infinity,
                    height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
                    child: ElevatedButton(
                      onPressed: _updateProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'update_product'.tr(context),
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
          fontSize: r.fontSize(14), color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.cairo(
            fontSize: r.fontSize(14), color: AppColors.textSecondary),
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

  void _updateProduct() {
    if (_formKey.currentState!.validate()) {
      if (_mediaPaths.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('please_add_product_image'.tr(context)),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      final updatedProduct = Product(
        id: widget.product.id,
        name: _nameController.text,
        nameAr: _nameArController.text,
        price: double.parse(_priceController.text),
        category: _categoryController.text,
        imageUrl: _mediaPaths.first,
        mediaUrls: _mediaPaths,
        merchant: widget.product.merchant,
        rating: widget.product.rating,
        isAvailable: _isAvailable,
        isFeatured: widget.product.isFeatured,
      );

      context.read<MerchantProductsCubit>().updateProduct(updatedProduct);
    }
  }
}
