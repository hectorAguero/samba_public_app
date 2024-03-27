import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/features/schools/school.dart';

enum SchoolSort {
  name,
  ranking,
  lastPerformance,
  location,
  foundationDate,
  favorite,
}

extension SchoolSortExtension on SchoolSort {
  int sortSwitch(School first, School second) => switch (this) {
        (SchoolSort.name) => first.name.compareTo(second.name),
        (SchoolSort.ranking) => first.id.compareTo(second.id),
        (SchoolSort.lastPerformance) => first.id.compareTo(second.id),
        (SchoolSort.location) => first.id.compareTo(second.id),
        (SchoolSort.foundationDate) =>
          first.foundationDate.compareTo(second.foundationDate),
        (SchoolSort.favorite) => first.isFavorite ? -1 : 1,
      };

  String fullName(BuildContext context) => switch (this) {
        (SchoolSort.name) => context.loc.schoolSortByName,
        (SchoolSort.ranking) => context.loc.schoolSortByRanking,
        (SchoolSort.lastPerformance) => context.loc.schoolSortByLastPerformance,
        (SchoolSort.location) => context.loc.schoolSortByLocation,
        (SchoolSort.foundationDate) => context.loc.schoolFoundationDate,
        (SchoolSort.favorite) => context.loc.shoolSortByFavorite,
      };
}
