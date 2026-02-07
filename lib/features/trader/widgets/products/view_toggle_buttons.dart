import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class ViewToggleButtons extends StatelessWidget {
  final bool isGridView;
  final VoidCallback onToggle;

  const ViewToggleButtons({
    super.key,
    required this.isGridView,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.grid_view,
              color: isGridView ? Colors.black : Colors.black38,
            ),
            onPressed: isGridView ? null : onToggle,
          ),
          IconButton(
            icon: Icon(
              Icons.view_list,
              color: !isGridView ? Colors.black : Colors.black38,
            ),
            onPressed: !isGridView ? null : onToggle,
          ),
        ],
      ),
    );
  }
}
