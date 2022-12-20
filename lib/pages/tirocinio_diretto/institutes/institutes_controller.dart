import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/controllers/calendar_controller.dart';
import 'package:unipd_tirocini/models/td/institute_model.dart';
import 'package:unipd_tirocini/utils/utils.dart';

import '../../../models/td/institute_options.dart';
import '../../../repos/td_repo.dart';


class InstitutesController extends GetxController with StateMixin<InstitutesModel>{

  final _repo = TDRepo();

  final searchCtrl = TextEditingController();
  final calendarYearCtrl = TextEditingController(text: CalendarController.to.currentYear.toString());
  String schoolType = '';
  InstituteOptions? options;

  bool unassigned = false;
  bool assigned = false;
  bool confirmed = false;

  bool get showStudents => unassigned || assigned || confirmed;

  int _page = 1;
  int _size = 20;
  int _total = 0;

  // Paginazione
  bool get isNextEnabled => page<maxPage;
  bool get isPrevEnabled => page>1 && page<=maxPage;
  int get total => _total;
  int get page => _page;
  int get maxPage => showStudents ? 100 : _total<=_size ? 1 : (_total/_size).ceil();

  bool get hasFilters => searchCtrl.text.isNotEmpty || unassigned || confirmed || assigned || schoolType.isNotEmpty;

  @override
  void onInit() {
    _getOptions();
    _getInstitutes();
    super.onInit();
  }

  void _getOptions() async {
    var res = await _repo.getInstitutesOptions();

    res.when(
      (error) => null, 
      (success) => options=success
    );
    update(['institutes-filters']);
    
  }

  void reload() => _getInstitutes();

  void _getInstitutes() async {
    change(null, status: RxStatus.loading());

    var institutes = await _repo.getInstitutes(
      page: _page, size: _size, 
      schoolType: schoolType,
      terms: searchCtrl.text,
      showStudents: showStudents,
      confirmedOnly: confirmed,
      assignedOnly: assigned,
      unassignedOnly: unassigned,
      calendarYear: int.tryParse(calendarYearCtrl.text),
    );

    institutes.when(
      (error) => change(null, status: RxStatus.error()), 
      (success) {
        if(success==null || success.institutes!.isEmpty)
          change(null, status: RxStatus.empty());
        else{
          change(success, status: RxStatus.success());
          _total = success.total ?? 0;
        }
      } 
    );

  }

  void loadPage(int page){
    _page = page;
    _getInstitutes();
  }

  void nextPage(){
    if (isNextEnabled) {
      _page++;
      _getInstitutes();
    } 
  }

  void prevPage(){
    if(isPrevEnabled){
      _page--;
      _getInstitutes();
    }
  }

  void setSchoolType(String s){
    schoolType = s;
    update(['institutes-filters']);
    loadPage(1);
  }

  void toggleShowStudents({bool? u, bool? a, bool? c,}){
    if(u!=null)
      unassigned = u;

    if(a!=null)
      assigned = a;

    if(c!=null)
      confirmed = c;

    update(['institutes-filters']);
    loadPage(1);
  }

  void pickDate(context) async {
    var res = await Utils.pickDate(context);

    if(res!=null){
      calendarYearCtrl.text = res.year.toString();
      update(['institutes-filters']);
      loadPage(1);
    }
  }

  void resetFilters(){
    unassigned = false;
    assigned = false;
    confirmed = false;
    calendarYearCtrl.text = DateTime.now().year.toString();
    searchCtrl.clear();
    schoolType = '';
    update(['institutes-filters']);
    loadPage(1);
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    calendarYearCtrl.dispose();
    super.onClose();
  }
}