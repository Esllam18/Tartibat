import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class LanguageOptionTile extends StatelessWidget {
  final String code;
  final bool selected;
  final VoidCallback onTap;
  const LanguageOptionTile(
      {super.key,
      required this.code,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final titleKey = code == 'en' ? 'english' : 'arabic';
    final subtitleKey = code == 'en' ? 'english_native' : 'arabic_native';
    final bg = selected ? Colors.white : Colors.white.withOpacity(.14);
    final fg = selected ? const Color(0xFF0D6E69) : Colors.white;
    final titleSize = code == 'en' ? r.fontSize(20) : r.fontSize(18);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: EdgeInsets.symmetric(horizontal: r.spacing(24)),
        padding: EdgeInsets.all(r.spacing(18)),
        decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: Colors.white.withOpacity(selected ? .55 : .20),
                width: 1.2)),
        child: Row(children: [
          _CodeBadge(code: code, selected: selected),
          SizedBox(width: r.spacing(14)),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(titleKey.tr(context),
                    style: GoogleFonts.cairo(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                        color: fg)),
                Text(subtitleKey.tr(context),
                    style: GoogleFonts.cairo(
                        fontSize: r.fontSize(13), color: fg.withOpacity(.75))),
              ])),
          if (selected)
            Icon(Icons.check_circle, color: fg, size: r.spacing(22)),
        ]),
      ),
    );
  }
}

class _CodeBadge extends StatelessWidget {
  final String code;
  final bool selected;
  const _CodeBadge({required this.code, required this.selected});
  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Container(
      width: r.spacing(54),
      height: r.spacing(54),
      decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF0D6E69).withOpacity(.10)
              : Colors.white24,
          borderRadius: BorderRadius.circular(14)),
      alignment: Alignment.center,
      child: Text(code.toUpperCase(),
          style: TextStyle(
              fontSize: r.fontSize(14),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: selected ? const Color(0xFF0D6E69) : Colors.white)),
    );
  }
}
