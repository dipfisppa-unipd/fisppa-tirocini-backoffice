import 'package:get/get.dart';
import 'package:unipd_tirocini/models/ti/territoriality_model.dart';

import '../models/td/institute_options.dart';
import '../repos/td_repo.dart';
import '../repos/ti_repo.dart';


class GenericDataController extends GetxController{

  static GenericDataController get to => Get.find();

  final _repoTI = TIRepo();
  final _repoTD = TDRepo();
  
  List<TerritorialityModel> _territorialities = [];

  List<TerritorialityModel> get territorialities => _territorialities;

  InstituteOptions? _options;

  InstituteOptions? get options => _options;

  void _getTerritorialities() async {
    _territorialities = await _repoTI.getTerritorialities();
  }

  @override
  void onInit() {
    _getTerritorialities();
    _getOptions();
    super.onInit();
  }

  String getTerritoriality(String tid){

    return _territorialities.firstWhereOrNull((element) => element.id==tid)?.label ?? '-';
  }

  void _getOptions() async {
    var res = await _repoTD.getInstitutesOptions();

    res.when(
      (error) => null, 
      (success) => _options=success
    );
    
  }
}