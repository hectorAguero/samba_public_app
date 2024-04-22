import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/providers/client_network_provider.dart';
import '../../utils/immutable_list.dart';
import 'details/instrument_details_page.dart';
import 'instrument.dart';

part 'instruments_repo.g.dart';

@riverpod
InstrumentsRepo instrumentsRepo(InstrumentsRepoRef ref) {
  return InstrumentsRepoImpls(ref);
}

abstract class InstrumentsRepo {
  Future<ImmutableList<Instrument>> getInstruments();

  Future<Instrument> getDetails(InstrumentId id);
}

class InstrumentsRepoImpls implements InstrumentsRepo {
  InstrumentsRepoImpls(this.ref);

  final InstrumentsRepoRef ref;

  @override
  Future<ImmutableList<Instrument>> getInstruments() async {
    try {
      final response = await ref
          .watch(clientNetworkProvider)
          .value!
          .get<Iterable<dynamic>>(Endpoint.instruments.path);
      final data = response.data!.cast<Map<String, dynamic>>();
      return ImmutableList([
        for (final item in data) Instrument.fromMap(item),
      ]);
    } catch (e) {
      throw AppNetworkError.fromNetworkClientException(e);
    }
  }

  @override
  Future<Instrument> getDetails(InstrumentId id) async {
    try {
      final response = await ref
          .watch(clientNetworkProvider)
          .value!
          .get<Map<String, dynamic>>(
            '${Endpoint.instruments.pathId}/$id',
          );
      return Instrument.fromMap(response.data!);
    } catch (e) {
      throw AppNetworkError.fromNetworkClientException(e);
    }
  }
}
