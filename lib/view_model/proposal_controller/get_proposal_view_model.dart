import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/api_url.dart';
import '../../model/proposal_model.dart';
import '../../service/get_services.dart';

final getProposalProvider =
    FutureProvider.autoDispose<List<ProposalModel>>((ref) async {
  final apiService = ApiService();

  Response response;

  try {
    response = await apiService.get(url: ApiUrls.proposals);
  } catch (e) {
    rethrow;
  }

  List<ProposalModel> _proposalList = [];
  if (response.data['proposals'] != null) {
    _proposalList = (response.data['proposals'] as List)
        .map((e) => ProposalModel.fromMap(e))
        .toList();
  }

  _proposalList.sort((a, b) => b.proposalId!.compareTo(a.proposalId!));
  return _proposalList;
});

final proposalIndexProvider = StateProvider<ProposalModel?>((ref) {
  ProposalModel();
}, );
