import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageCard extends StatefulWidget {
  final AnimationController controller;
  final String langCode;
  final String flag;
  final String title;
  final String subtitle;
  final bool isSelected;
  final int delay;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.controller,
    required this.langCode,
    required this.flag,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.delay,
    required this.onTap,
  });

  @override
  State<LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: widget.controller,
          curve: Interval(
            widget.delay / 1000,
            (widget.delay + 500) / 1000,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
            .animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: Interval(
              widget.delay / 1000,
              (widget.delay + 500) / 1000,
              curve: Curves.easeOutCubic,
            ),
          ),
        ),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onTap();
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedScale(
            scale: _isPressed ? 0.97 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: widget.isSelected
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFD2B48C),
                          Color(0xFFB8956A),
                          Color(0xFF8B4513),
                        ],
                      )
                    : const LinearGradient(
                        colors: [Colors.white, Colors.white]),
                boxShadow: [
                  BoxShadow(
                    color: widget.isSelected
                        // ignore: deprecated_member_use
                        ? const Color(0xFFD2B48C).withOpacity(0.5)
                        // ignore: deprecated_member_use
                        : Colors.black.withOpacity(0.08),
                    blurRadius: widget.isSelected ? 28 : 20,
                    offset: Offset(0, widget.isSelected ? 12 : 6),
                    spreadRadius: widget.isSelected ? 2 : 0,
                  ),
                  if (widget.isSelected)
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: const Color(0xFF8B4513).withOpacity(0.3),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                ],
                border: Border.all(
                  color: widget.isSelected
                      ? Colors.transparent
                      // ignore: deprecated_member_use
                      : const Color(0xFFD2B48C).withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(26),
                child: Row(
                  children: [
                    // Flag container
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: widget.isSelected
                            // ignore: deprecated_member_use
                            ? Colors.white.withOpacity(0.25)
                            : const Color(0xFFFAF9F6),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: widget.isSelected
                            ? [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          widget.flag,
                          style: const TextStyle(fontSize: 38),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.cairo(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: widget.isSelected
                                  ? Colors.white
                                  : const Color(0xFF2C2416),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.subtitle,
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: widget.isSelected
                                  // ignore: deprecated_member_use
                                  ? Colors.white.withOpacity(0.95)
                                  // ignore: deprecated_member_use
                                  : const Color(0xFF8B4513).withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Check/Arrow icon
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Container(
                        key: ValueKey(widget.isSelected),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: widget.isSelected
                              // ignore: deprecated_member_use
                              ? Colors.white.withOpacity(0.3)
                              // ignore: deprecated_member_use
                              : const Color(0xFFD2B48C).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.isSelected
                              ? Icons.check_rounded
                              : Icons.arrow_forward_rounded,
                          color: widget.isSelected
                              ? Colors.white
                              : const Color(0xFF8B4513),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
