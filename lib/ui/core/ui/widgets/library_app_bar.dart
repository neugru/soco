import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soco/ui/core/styles/sizes.dart';

class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String iconPath;
  final List<Widget>? actions;

  const LibraryAppBar({
    super.key,
    required this.title,
    required this.iconPath,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          AppSizes.gap.small,
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
