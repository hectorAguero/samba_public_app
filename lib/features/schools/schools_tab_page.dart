import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_sliver_nav_bar.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/schools/schools_tab_providers.dart';
import 'package:samba_public_app/features/schools/widgets/school_card.dart';
import 'package:samba_public_app/features/schools/widgets/school_division_chips.dart';
import 'package:samba_public_app/router/go_route_scroll_tab.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SchoolsTabPage extends ConsumerStatefulWidget {
  const SchoolsTabPage({super.key});

  static final route = GoRouteScrollTab(
    path: '/schools',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const SchoolsTabPage(),
    ),
  );

  @override
  ConsumerState<SchoolsTabPage> createState() => _SchoolsTabState();
}

class _SchoolsTabState extends ConsumerState<SchoolsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: PrimaryScrollController.of(context),
        slivers: <Widget>[
          SliverCrossAxisConstrained(
            maxCrossAxisExtent: largeScreen,
            child: AppCupertinoSliverNavBar(largeTitle: 'Schools'.hardcoded),
          ),
          const SliverCrossAxisConstrained(
            maxCrossAxisExtent: largeScreen,
            child: SchoolDivisionChips(),
          ),
          SliverAnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: ref.watch(schoolsProvider).when(
                  data: (schools) {
                    return Consumer(
                      builder: (context, ref, child) {
                        final schools = ref.watch(filteredSchoolsProvider);
                        return SliverCrossAxisConstrained(
                          maxCrossAxisExtent: largeScreen,
                          child: SliverPadding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            sliver: SliverAlignedGrid.extent(
                              maxCrossAxisExtent: SchoolCard.cardMaxWidth,
                              itemCount: schools.length,
                              itemBuilder: (context, index) {
                                final school = schools[index];
                                return ProviderScope(
                                  overrides: [
                                    currentSchoolProvider.overrideWithValue(
                                      schools
                                          .firstWhere((s) => s.id == school.id),
                                    ),
                                  ],
                                  child: const SchoolCard(),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                  error: (error, stackTrace) => SliverFillRemaining(
                    child: Center(
                      child: Text('Error: $error'),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}