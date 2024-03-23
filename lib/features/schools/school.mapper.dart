// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'school.dart';

class SchoolLeagueMapper extends EnumMapper<SchoolLeague> {
  SchoolLeagueMapper._();

  static SchoolLeagueMapper? _instance;
  static SchoolLeagueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchoolLeagueMapper._());
    }
    return _instance!;
  }

  static SchoolLeague fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SchoolLeague decode(dynamic value) {
    switch (value) {
      case 'LIESA':
        return SchoolLeague.liesa;
      case 'LIERJ':
        return SchoolLeague.lierj;
      case 'SUPERLIGA':
        return SchoolLeague.superliga;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SchoolLeague self) {
    switch (self) {
      case SchoolLeague.liesa:
        return 'LIESA';
      case SchoolLeague.lierj:
        return 'LIERJ';
      case SchoolLeague.superliga:
        return 'SUPERLIGA';
    }
  }
}

extension SchoolLeagueMapperExtension on SchoolLeague {
  String toValue() {
    SchoolLeagueMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SchoolLeague>(this) as String;
  }
}

class SchoolDivisionMapper extends EnumMapper<SchoolDivision> {
  SchoolDivisionMapper._();

  static SchoolDivisionMapper? _instance;
  static SchoolDivisionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchoolDivisionMapper._());
    }
    return _instance!;
  }

  static SchoolDivision fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SchoolDivision decode(dynamic value) {
    switch (value) {
      case 1:
        return SchoolDivision.especial;
      case 2:
        return SchoolDivision.ouro;
      case 3:
        return SchoolDivision.prata;
      case 4:
        return SchoolDivision.bronze;
      case 5:
        return SchoolDivision.avaliacao;
      case 6:
        return SchoolDivision.mirins;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SchoolDivision self) {
    switch (self) {
      case SchoolDivision.especial:
        return 1;
      case SchoolDivision.ouro:
        return 2;
      case SchoolDivision.prata:
        return 3;
      case SchoolDivision.bronze:
        return 4;
      case SchoolDivision.avaliacao:
        return 5;
      case SchoolDivision.mirins:
        return 6;
    }
  }
}

extension SchoolDivisionMapperExtension on SchoolDivision {
  dynamic toValue() {
    SchoolDivisionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SchoolDivision>(this);
  }
}

class SchoolMapper extends ClassMapperBase<School> {
  SchoolMapper._();

  static SchoolMapper? _instance;
  static SchoolMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchoolMapper._());
      SchoolLeagueMapper.ensureInitialized();
      SchoolDivisionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'School';

  static int _$id(School v) => v.id;
  static const Field<School, int> _f$id = Field('id', _$id);
  static String _$name(School v) => v.name;
  static const Field<School, String> _f$name = Field('name', _$name);
  static String _$imageUrl(School v) => v.imageUrl;
  static const Field<School, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, key: 'image_url');
  static DateTime _$foundationDate(School v) => v.foundationDate;
  static const Field<School, DateTime> _f$foundationDate = Field(
      'foundationDate', _$foundationDate,
      key: 'foundation_date', hook: DateTimeHook());
  static String _$godmotherSchool(School v) => v.godmotherSchool;
  static const Field<School, String> _f$godmotherSchool =
      Field('godmotherSchool', _$godmotherSchool, key: 'godmother_school');
  static List<Color> _$colors(School v) => v.colors;
  static const Field<School, List<Color>> _f$colors =
      Field('colors', _$colors, hook: ColorHook());
  static List<String> _$symbols(School v) => v.symbols;
  static const Field<School, List<String>> _f$symbols =
      Field('symbols', _$symbols);
  static SchoolLeague _$league(School v) => v.league;
  static const Field<School, SchoolLeague> _f$league =
      Field('league', _$league);
  static SchoolDivision _$currentDivision(School v) => v.currentDivision;
  static const Field<School, SchoolDivision> _f$currentDivision =
      Field('currentDivision', _$currentDivision, key: 'division_number');
  static bool _$isFavorite(School v) => v.isFavorite;
  static const Field<School, bool> _f$isFavorite = Field(
      'isFavorite', _$isFavorite,
      key: 'is_favorite', opt: true, def: false);

  @override
  final MappableFields<School> fields = const {
    #id: _f$id,
    #name: _f$name,
    #imageUrl: _f$imageUrl,
    #foundationDate: _f$foundationDate,
    #godmotherSchool: _f$godmotherSchool,
    #colors: _f$colors,
    #symbols: _f$symbols,
    #league: _f$league,
    #currentDivision: _f$currentDivision,
    #isFavorite: _f$isFavorite,
  };

  static School _instantiate(DecodingData data) {
    return School(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        imageUrl: data.dec(_f$imageUrl),
        foundationDate: data.dec(_f$foundationDate),
        godmotherSchool: data.dec(_f$godmotherSchool),
        colors: data.dec(_f$colors),
        symbols: data.dec(_f$symbols),
        league: data.dec(_f$league),
        currentDivision: data.dec(_f$currentDivision),
        isFavorite: data.dec(_f$isFavorite));
  }

  @override
  final Function instantiate = _instantiate;

  static School fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<School>(map);
  }

  static School fromJson(String json) {
    return ensureInitialized().decodeJson<School>(json);
  }
}

mixin SchoolMappable {
  String toJson() {
    return SchoolMapper.ensureInitialized().encodeJson<School>(this as School);
  }

  Map<String, dynamic> toMap() {
    return SchoolMapper.ensureInitialized().encodeMap<School>(this as School);
  }

  SchoolCopyWith<School, School, School> get copyWith =>
      _SchoolCopyWithImpl(this as School, $identity, $identity);
  @override
  String toString() {
    return SchoolMapper.ensureInitialized().stringifyValue(this as School);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SchoolMapper.ensureInitialized()
                .isValueEqual(this as School, other));
  }

  @override
  int get hashCode {
    return SchoolMapper.ensureInitialized().hashValue(this as School);
  }
}

extension SchoolValueCopy<$R, $Out> on ObjectCopyWith<$R, School, $Out> {
  SchoolCopyWith<$R, School, $Out> get $asSchool =>
      $base.as((v, t, t2) => _SchoolCopyWithImpl(v, t, t2));
}

abstract class SchoolCopyWith<$R, $In extends School, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Color, ObjectCopyWith<$R, Color, Color>> get colors;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get symbols;
  $R call(
      {int? id,
      String? name,
      String? imageUrl,
      DateTime? foundationDate,
      String? godmotherSchool,
      List<Color>? colors,
      List<String>? symbols,
      SchoolLeague? league,
      SchoolDivision? currentDivision,
      bool? isFavorite});
  SchoolCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SchoolCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, School, $Out>
    implements SchoolCopyWith<$R, School, $Out> {
  _SchoolCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<School> $mapper = SchoolMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Color, ObjectCopyWith<$R, Color, Color>> get colors =>
      ListCopyWith($value.colors, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(colors: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get symbols =>
      ListCopyWith($value.symbols, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(symbols: v));
  @override
  $R call(
          {int? id,
          String? name,
          String? imageUrl,
          DateTime? foundationDate,
          String? godmotherSchool,
          List<Color>? colors,
          List<String>? symbols,
          SchoolLeague? league,
          SchoolDivision? currentDivision,
          bool? isFavorite}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (imageUrl != null) #imageUrl: imageUrl,
        if (foundationDate != null) #foundationDate: foundationDate,
        if (godmotherSchool != null) #godmotherSchool: godmotherSchool,
        if (colors != null) #colors: colors,
        if (symbols != null) #symbols: symbols,
        if (league != null) #league: league,
        if (currentDivision != null) #currentDivision: currentDivision,
        if (isFavorite != null) #isFavorite: isFavorite
      }));
  @override
  School $make(CopyWithData data) => School(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      foundationDate: data.get(#foundationDate, or: $value.foundationDate),
      godmotherSchool: data.get(#godmotherSchool, or: $value.godmotherSchool),
      colors: data.get(#colors, or: $value.colors),
      symbols: data.get(#symbols, or: $value.symbols),
      league: data.get(#league, or: $value.league),
      currentDivision: data.get(#currentDivision, or: $value.currentDivision),
      isFavorite: data.get(#isFavorite, or: $value.isFavorite));

  @override
  SchoolCopyWith<$R2, School, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SchoolCopyWithImpl($value, $cast, t);
}