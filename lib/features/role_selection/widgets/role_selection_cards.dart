import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import '../data/role_data.dart';
import 'role_card.dart';

class RoleSelectionCards extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String> onRoleSelect;

  const RoleSelectionCards({
    super.key,
    required this.selectedRole,
    required this.onRoleSelect,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < roleOptions.length; i++) ...[
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 600 + (i * 150)),
              child: RoleCard(
                role: roleOptions[i].id,
                icon: roleOptions[i].icon,
                titleKey: roleOptions[i].titleKey,
                descriptionKey: roleOptions[i].descriptionKey,
                gradient: roleOptions[i].gradient,
                isSelected: selectedRole == roleOptions[i].id,
                onTap: () => onRoleSelect(roleOptions[i].id),
              ),
            ),
            if (i < roleOptions.length - 1) SizedBox(height: r.spacing(18)),
          ],
        ],
      ),
    );
  }
}
