import 'package:arcade/theme/theme_tokens.dart';
import 'package:flutter/material.dart';

class GlossyContainer extends StatelessWidget {
  const GlossyContainer({super.key, required this.child});

  final Widget child;

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: ThemeTokens.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(8, 8),
            blurRadius: 7,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5, // Adjust to make the gloss stronger
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.05),
                      Colors.transparent,
                      Colors.white.withOpacity(0.05),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0], // Enhance metallic reflection
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          // Second gradient layer for additional gloss
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Lighter secondary gloss
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(-0.8, -0.8), // Off-center light source
                    radius: 1.2,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          child,
        ],
      ),
    );
  }
}
