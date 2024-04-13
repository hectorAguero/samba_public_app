import 'package:flutter/material.dart';

import '../../../extensions/media_query_context_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../../../utils/immutable_list.dart';
import '../home_page_controller.dart';
import 'adaptive_navigation_rail_footer.dart';

class AdaptiveNavigationRail extends StatelessWidget {
  const AdaptiveNavigationRail({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final ImmutableList<HomeTab> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const footerSize = 162.0;
  static const largeRailWidth = 256.0;
  static const smallRailWidth = 80.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        SizedBox(
          height: size.height - footerSize,
          child: NavigationRail(
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.library_music,
                color: context.colorScheme.primary,
                size: (context.querySize.height * 0.1).clamp(24, 80),
              ),
            ),
            backgroundColor: context.colorScheme.surface,
            onDestinationSelected: onDestinationSelected,
            extended: size.isLargeScreen || size.isExtraLargeScreen,
            selectedIndex: selectedIndex,
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            destinations: [
              for (final destination in destinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: Text(
                    destination.label(context),
                    style: context.textTheme.titleMedium,
                  ),
                ),
            ],
          ),
        ),
        ColoredBox(
          color: context.colorScheme.surface,
          child: SafeArea(
            bottom: false,
            left: Directionality.of(context) == TextDirection.ltr,
            right: Directionality.of(context) == TextDirection.rtl,
            child: SizedBox(
              height: footerSize,
              width: size.isLargeScreen || size.isExtraLargeScreen
                  ? largeRailWidth
                  : smallRailWidth,
              child: ColoredBox(
                color: context.colorScheme.surface,
                child: const AdaptiveNavigationRailFooter(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
