import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final _imageUrlController = TextEditingController();
  bool _isAvailable = true;

  @override
  void dispose() {
    _nameController.dispose();
    _nameArController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _imageUrlController.dispose();
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
                  _buildTextField(
                    controller: _categoryController,
                    label: 'category'.tr(context),
                    icon: Icons.category_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_category'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),
                  _buildTextField(
                    controller: _imageUrlController,
                    label: 'image_url'.tr(context),
                    icon: Icons.image_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_image_url'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(20)),
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
      final product = Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        nameAr: _nameArController.text,
        price: double.parse(_priceController.text),
        category: _categoryController.text,
        imageUrl: _imageUrlController.text,
        merchant: 'My Store',
        rating: 4.5,
        isAvailable: _isAvailable,
      );

      context.read<MerchantProductsCubit>().addProduct(product);
    }
  }
}
