import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/shared_preferences_provider.dart';
import '../../utils/immutable_list.dart';
import '../../utils/main_logger.dart';
import 'school.dart';
import 'schools_repo.dart';
import 'widgets/school_card.dart';

part 'schools_tab_providers.g.dart';

@riverpod
class Schools extends _$Schools {
  static const _pageSize = 10;

  @override
  FutureOr<ImmutableList<School>> build() async {
    final sort = ref.read(selectedSchoolSortProvider);
    return getSchools(sort: sort);
  }

  Future<bool?> fetchNextPage({int pageSize = _pageSize}) async {
    try {
      final sort = ref.read(selectedSchoolSortProvider);
      final schools = await getSchools(
        page: state.value!.length ~/ pageSize + 1,
        pageSize: pageSize,
        sort: sort,
      );
      if (schools.isNotEmpty) {
        state = AsyncData(ImmutableList([...state.value!, ...schools]));
        return true;
      }
      ref.read(schoolReachedMaxProvider.notifier).reached();
      return false;
    } catch (e, st) {
      logViews.warning('Failed to fetch next page $e', e, st);
      return null;
    }
  }

  Future<ImmutableList<School>> getSchools({
    required SchoolSort sort,
    int page = 1,
    int pageSize = _pageSize,
  }) async {
    final schools = await ref.watch(schoolsRepoProvider).getSchools(
          page: page,
          pageSize: pageSize,
          sort: sort.name.toLowerCase(),
        );
    if (schools.isEmpty) {
      ref.read(schoolReachedMaxProvider.notifier).reached();
      return schools;
    }
    return schools;
  }
}

@riverpod
class FavoriteSchools extends _$FavoriteSchools {
  @override
  ImmutableList<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider).value!;
    return ImmutableList(prefs.getStringList('favoriteSchools') ?? []);
  }

  void toggleFavorite(SchoolId id) {
    final prefs = ref.watch(sharedPreferencesProvider).value!;
    final favoriteSchools = prefs.getStringList('favoriteSchools') ?? [];
    if (favoriteSchools.contains('$id')) {
      favoriteSchools.remove('$id');
    } else {
      favoriteSchools.add('$id');
    }
    prefs.setStringList('favoriteSchools', favoriteSchools);
    state = ImmutableList(favoriteSchools);
  }

  bool isFavorite(SchoolId id) {
    final favoriteSchools = state;
    return favoriteSchools.contains('$id');
  }
}

@riverpod
class SchoolDivisions extends _$SchoolDivisions {
  @override
  Map<SchoolDivision, bool> build() {
    final schools = ref.watch(schoolsProvider).value;
    final divisions = schools?.map((e) => e.currentDivision).toSet() ?? {};
    return <SchoolDivision, bool>{
      for (final division in divisions) division: true,
    };
  }

  void selectDivision(SchoolDivision division) {
    state = {...state, division: true};
  }

  void removeDivision(SchoolDivision division) =>
      state = {...state, division: false};

  void removeAll() {
    state = <SchoolDivision, bool>{
      for (final division in state.keys) division: false,
    };
  }

  void selectAll() {
    state = <SchoolDivision, bool>{
      for (final division in state.keys) division: true,
    };
  }
}

@riverpod
class SearchSchool extends _$SearchSchool {
  @override
  String build() => '';

  void setSearch(String value) {
    state = value.trim().toLowerCase();
  }
}

@riverpod
class SelectedSchoolSort extends _$SelectedSchoolSort {
  @override
  SchoolSort build() => SchoolSort.lastPerformance;

  void setSort(SchoolSort sort) => state = sort;
}

@riverpod
class ShowOnlyFavoriteSchools extends _$ShowOnlyFavoriteSchools {
  @override
  bool build() => false;

  void turnOffShowFavorites() => state = false;

  void turnOnShowFavorites() => state = true;

  void toggleShowFavorites() {
    state = !state;
    if (state) ref.read(schoolDivisionsProvider.notifier).selectAll();
  }
}

final filteredSchoolsProvider =
    Provider.autoDispose<ImmutableList<School>>((ref) {
  final filter = ref.watch(schoolDivisionsProvider);
  final schools = ref.watch(schoolsProvider);
  final favoritesIds = ref.watch(favoriteSchoolsProvider);
  final onlyFavorites = ref.watch(showOnlyFavoriteSchoolsProvider);
  if (schools.value == null) return ImmutableList(const []);
  return ImmutableList([
    for (final school in schools.value!)
      if (filter[school.currentDivision]! &&
          (!onlyFavorites || favoritesIds.contains('$school.id')))
        school,
  ]);
});

@riverpod
class SchoolReachedMax extends _$SchoolReachedMax {
  @override
  bool build() => false;
  void reached() => state = true;
  void reset() => state = false;
}

/// By retrieving the [School] through a provider instead of through its
/// constructor, this allows [SchoolCard] to be instantiated using the `const`
/// keyword.
/// This ensures that when we add/remove/edit schools, only what the
/// impacted widgets rebuilds, instead of the entire list of items.
final currentSchoolProvider =
    Provider<School>((ref) => throw UnimplementedError());
