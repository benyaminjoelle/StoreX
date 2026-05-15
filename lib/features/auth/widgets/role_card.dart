import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isSelected;

  const RoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: cs.surface,
        border: Border.all(
          color: isSelected ? color : color.withOpacity(0.25),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSelected ? 0.08 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,

        /// 🧠 IMPORTANT FIX: prevents overflow inside fixed grid height
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),

              const SizedBox(width: 12),

              /// 🧠 KEY FIX AREA
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// title always safe
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 3),

                        /// 🔥 FIX: allows wrapping WITHOUT overflow
                        Flexible(
                          child: Text(
                            description,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurface.withOpacity(0.55),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: color.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}