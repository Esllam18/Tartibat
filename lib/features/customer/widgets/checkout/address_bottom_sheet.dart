import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/delivery_address_model.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _buildingController = TextEditingController();
  final _apartmentController = TextEditingController();
  bool _isDefault = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _buildingController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is AddressSaved) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('address_saved_successfully'.tr(context)),
              backgroundColor: AppColors.success,
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(r.spacing(20)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'add_delivery_address'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(20),
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: r.spacing(20)),
                  _buildTextField(
                    controller: _nameController,
                    label: 'full_name'.tr(context),
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_name'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),
                  _buildTextField(
                    controller: _phoneController,
                    label: 'phone_number'.tr(context),
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_phone'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),
                  _buildTextField(
                    controller: _cityController,
                    label: 'city'.tr(context),
                    icon: Icons.location_city_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_city'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),
                  _buildTextField(
                    controller: _areaController,
                    label: 'area'.tr(context),
                    icon: Icons.map_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_area'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),
                  _buildTextField(
                    controller: _streetController,
                    label: 'street'.tr(context),
                    icon: Icons.signpost_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_street'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spacing(16)),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _buildingController,
                          label: 'building'.tr(context),
                          icon: Icons.business_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'required'.tr(context);
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: r.spacing(12)),
                      Expanded(
                        child: _buildTextField(
                          controller: _apartmentController,
                          label: 'apartment'.tr(context),
                          icon: Icons.home_outlined,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.spacing(16)),
                  CheckboxListTile(
                    value: _isDefault,
                    onChanged: (value) =>
                        setState(() => _isDefault = value ?? false),
                    title: Text(
                      'set_as_default'.tr(context),
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(height: r.spacing(24)),
                  SizedBox(
                    width: double.infinity,
                    height: r.responsive(mobile: 54, tablet: 58, desktop: 62),
                    child: ElevatedButton(
                      onPressed: _saveAddress,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'save_address'.tr(context),
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
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = DeliveryAddress(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        phone: _phoneController.text,
        street: _streetController.text,
        city: _cityController.text,
        area: _areaController.text,
        building: _buildingController.text,
        apartment: _apartmentController.text.isEmpty
            ? null
            : _apartmentController.text,
        isDefault: _isDefault,
      );

      context.read<CheckoutCubit>().saveAddress(address);
    }
  }
}
