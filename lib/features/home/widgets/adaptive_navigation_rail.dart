import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/home/home_page_controller.dart';
import 'package:samba_public_app/theme/theme_provider.dart';

class AdaptiveNavigationRail extends StatelessWidget {
  const AdaptiveNavigationRail({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final List<TabDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
          height: size.height - 56,
          child: NavigationRail(
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.library_music,
                color: context.colorScheme.primary,
                size: 80,
              ),
            ),
            onDestinationSelected: onDestinationSelected,
            extended: size.isLargeScreen || size.isExtraLargeScreen,
            selectedIndex: selectedIndex,
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            indicatorColor: context.colorScheme.secondary,
            destinations: [
              for (final destination in destinations)
                NavigationRailDestination(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: Text(
                    destination.label,
                    style: context.textTheme.titleMedium,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          child: Divider(
            thickness: 1,
            height: 1,
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            return SizedBox(
              height: 55,
              width: size.isLargeScreen || size.isExtraLargeScreen ? 256 : 96,
              child: ListTile(
                tileColor: context.colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                title: size.isLargeScreen || size.isExtraLargeScreen
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          context.isLight ? 'Light Theme' : 'Dark Theme',
                          style: context.textTheme.titleMedium,
                        ),
                      )
                    : Icon(
                        context.isLight ? Icons.light_mode : Icons.dark_mode,
                      ),
                leading: size.isLargeScreen || size.isExtraLargeScreen
                    ? Icon(
                        context.isLight ? Icons.light_mode : Icons.dark_mode,
                      )
                    : null,
                onTap: ref.read(appThemeModeProvider.notifier).toggleTheme,
              ),
            );
          },
        ),
      ],
    );
  }
}
