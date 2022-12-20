import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/controllers/calendar_controller.dart';
import 'package:unipd_tirocini/models/ti/group_model.dart';
import 'package:unipd_tirocini/repos/ti_repo.dart';

import '../../controllers/generic_data_controller.dart';
import '../../utils/utils.dart';

/// internshipYear è da considerarsi per il nextYear. 
/// Se voglio l'anno di internshipYear corrente => anno attuale - foundationyear
class TIController extends GetxController with StateMixin<List<GroupModel>>{

  static TIController get to => Get.find();

  final _repo = TIRepo();

  int internshipYear = 0;
  List<GroupModel> groups = [], _initialGroups = [];
  
  int currentYear = CalendarController.to.currentYear;
  TextEditingController foundationYearCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();

  int _page = 1;
  int _size = 30;
  int _total = 0;

  // Paginazione
  bool get isNextEnabled => page<maxPage;
  bool get isPrevEnabled => page>1 && page<=maxPage;
  int get total => _total;
  int get page => _page;
  int get maxPage => _total<=_size ? 1 : (_total/_size).ceil();

  // Filters
  String selectedTerritorialityId = '';
  int selectedFoundationYear = 0;

  bool get hasFilters => searchCtrl.text.isNotEmpty || selectedFoundationYear>0 || selectedTerritorialityId.isNotEmpty;

  @override
  void onInit() {
    getGroups();
    
    super.onInit();
  }

  @override
  void onClose() {
    foundationYearCtrl.dispose();
    searchCtrl.dispose();
    super.onClose();
  }

  void reload() {
    change(null, status: RxStatus.loading());
    searchCtrl.clear();
    groups.clear();
    getGroups();
  }

  void getGroups() async {

    _initialGroups = await _repo.getGroups(internshipYear: internshipYear);

    if(_initialGroups.isEmpty){
      change(_initialGroups, status: RxStatus.empty());
    } else {
      for(var g in _initialGroups){
        if(g.territorialityId!=null)
        g.territorialityName = GenericDataController.to.territorialities.firstWhereOrNull(
          (element) => element.id==g.territorialityId,)?.label ?? '';
      }
      // reorder by foundationYear
      _initialGroups.sort(((a, b) => b.foundationYear.compareTo(a.foundationYear)));
      change(_initialGroups, status: RxStatus.success());
      groups.addAll(_initialGroups);
      _total = groups.length;
    }

  }

  void loadPage(int page){
    _page = page;
    getGroups();
  }

  void nextPage(){
    if (isNextEnabled) {
      _page++;
      getGroups();
    } 
  }

  void prevPage(){
    if(isPrevEnabled){
      _page--;
      getGroups();
    }
  }

  // Filters

  void onSearch(String term) {
    selectedFoundationYear = 0;
    foundationYearCtrl.clear();
    selectedTerritorialityId = '';
    groups.clear();
    groups = _initialGroups.where(
      (element) => (element.coordinatorTutor?.registry?.lastName?.toLowerCase().contains(term.toLowerCase()) ?? false)
                || (element.organizerTutor?.registry?.lastName?.toLowerCase().contains(term.toLowerCase()) ?? false)
    ).toList();

    if(groups.length>0)
      change(groups, status: RxStatus.success());
    else
      change(groups, status: RxStatus.empty());
  }

  void changeTerritoriality(String v){
    selectedTerritorialityId = v; print(v);
    _filterGroups();
  }

  void pickDate(context) async {

    final choice = await Utils.pickDate(context);

    if(choice!=null){
      selectedFoundationYear = choice.year;
      foundationYearCtrl.text = '$selectedFoundationYear';
      _filterGroups();
      
    }
  }

  void resetFilters(){
    searchCtrl.clear();
    selectedFoundationYear = 0;
    foundationYearCtrl.clear();
    selectedTerritorialityId = '';
    
    groups.clear();
    groups.addAll(_initialGroups);
    change(groups, status: RxStatus.success());
  }

  void _filterGroups() {
    searchCtrl.clear();
    groups.clear();

    groups = _initialGroups.where(
      (element) => (element.foundationYear==selectedFoundationYear)
      || (selectedTerritorialityId.isNotEmpty && element.territorialityId!=null ? element.territorialityId==selectedTerritorialityId : element.territorialityId!=null)
    ).toList();

    change(groups, status: RxStatus.success());
  }

}