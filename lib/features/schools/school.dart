// This file is "model.dart"

import 'dart:collection';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

import '../../extensions/app_localization_extension.dart';
import '../../utils/unmodifiable_list.dart';
import 'school_color_hook.dart';

// Will be generated by dart_mappable
part 'school.mapper.dart';

typedef SchoolId = int;

@MappableClass()
class School with SchoolMappable {
  const School({
    required this.id,
    required this.name,
    required this.translatedName,
    required this.imageUrl,
    required this.foundationDate,
    required this.godmotherSchool,
    required this.colors,
    required this.colorsCode,
    required this.symbols,
    required this.carnivalCategory,
    required this.currentDivision,
    required this.divisionNumber,
    required this.subdivisionNumber,
    required this.firstDivisionChampionships,
    required this.country,
    required this.leagueLocation,
    required this.lastPosition,
    required this.translatedColors,
    required this.translatedSymbols,
    required this.translatedGodmotherSchool,
    required this.translatedLeagueLocation,
    required this.translatedCountry,
  });

  final SchoolId id;
  final String name;
  final String imageUrl;
  @MappableField(hook: DateTimeHook())
  final DateTime? foundationDate;
  final String godmotherSchool;
  final UnmodifiableList<String> colors;
  final UnmodifiableList<String> symbols;
  final SchoolCategory carnivalCategory;
  final int divisionNumber;
  final int? subdivisionNumber;
  final int firstDivisionChampionships;
  final String country;
  final String leagueLocation;
  final int lastPosition;
  final String translatedName;
  final UnmodifiableList<String> translatedColors;
  final UnmodifiableList<String> translatedSymbols;
  final String translatedGodmotherSchool;
  final String translatedCountry;
  final String translatedLeagueLocation;
  @MappableField(hook: ColorHook(), key: 'colors')
  final UnmodifiableList<Color> colorsCode;
  @MappableField(key: 'divisionNumber')
  final SchoolDivision currentDivision;

  static const fromMap = SchoolMapper.fromMap;
  static const fromJson = SchoolMapper.fromJson;
}

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum SchoolCategory {
  @MappableValue('Escolas de samba')
  escolasDeSamba,
  @MappableValue('Escolas mirins')
  escolasMirins,
  @MappableValue('Blocos de enredo')
  blocoDeEnredo,
  @MappableValue('Blocos de rua')
  blocoDeRua,
}

@MappableEnum()
enum SchoolDivision {
  @MappableValue(1)
  especial,
  @MappableValue(2)
  ouro,
  @MappableValue(3)
  prata,
  @MappableValue(4)
  bronze,
  @MappableValue(5)
  avaliacao,
  @MappableValue(6)
  mirins,
  @MappableValue(7)
  blocosDeEnredo1,
  @MappableValue(8)
  blocosDeEnredo2,
  @MappableValue(9)
  blocosDeRua
}

enum SchoolSort { lastPerformance, name, location, foundationDate }

extension SchoolSortExtension on SchoolSort {
  String fullName(BuildContext context) => switch (this) {
        (SchoolSort.name) => context.loc.schoolSortByName,
        // (SchoolSort.ranking) => context.loc.schoolSortByRanking,
        (SchoolSort.lastPerformance) => context.loc.schoolSortByLastPerformance,
        (SchoolSort.location) => context.loc.schoolSortByLocation,
        (SchoolSort.foundationDate) => context.loc.schoolFoundationDate,
      };
}

class DateTimeHook extends MappingHook {
  const DateTimeHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      //1946/6/24
      if (value.isEmpty) return null;
      final data = value.trim().split('/');
      return DateTime(
        int.parse(data[0]),
        data.length > 1 ? int.parse(data[1]) : 1,
        data.length > 2 ? int.parse(data[2]) : 1,
      );
    }
    throw Exception('Date $value is not valid');
  }
}
