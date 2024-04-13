import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../extensions/is_ios_or_macos_platform_extension.dart';
import '../../../utils/immutable_list.dart';
import '../home_page_controller.dart';

/// Shows a widget for cupertino or material.
class AdaptiveNavigationBar extends StatelessWidget {
  const AdaptiveNavigationBar({
    required this.tabDestinations,
    required this.onDestinationSelected,
    required this.selectedIndex,
    super.key,
  });

  final ImmutableList<HomeTab> tabDestinations;
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (kIsCupertino) {
      return AnimatedTheme(
        data: Theme.of(context),
        child: CupertinoTabBar(
          onTap: onDestinationSelected,
          currentIndex: selectedIndex,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          items: [
            for (final destination in tabDestinations)
              BottomNavigationBarItem(
                icon: Icon(destination.icon),
                activeIcon: Icon(destination.selectedIcon),
                label: destination.label(context),
              ),
          ],
        ),
      );
    }
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: <Widget>[
        for (final destination in tabDestinations)
          NavigationDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            label: destination.label(context),
          ),
      ],
    );
  }
}
