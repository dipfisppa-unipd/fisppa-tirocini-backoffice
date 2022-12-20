import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_tirocini/controllers/calendar_controller.dart';
import 'package:unipd_tirocini/utils/utils.dart';

import '../../models/students/students_model.dart';

import '../../repos/students_repo.dart';



class StudentsController extends GetxController with StateMixin<StudentsModel>{

  static StudentsController get to => Get.find();

  final _repo = StudentsRepo();

  StudentsModel? _students;
  int _page = 1;
  int _size = 20;
  int _total = 0;

  // Paginazione
  bool get isNextEnabled => page<maxPage;
  bool get isPrevEnabled => page>1 && page<=maxPage;
  int get total => _total;
  int get page => _page;
  int get maxPage => _total<=_size ? 1 : (_total/_size).ceil();

  // Filters
  final termsCtrl = TextEditingController();
  int yearOfStudy = 1;
  int _calendarYear = DateTime.now().year;
  final calendarYearCtrl = TextEditingController();

  int get currentYear => _calendarYear;

  @override
  void onInit() {
    _calendarYear = CalendarController.to.currentYear;
    calendarYearCtrl.text = CalendarController.to.currentAcademicYear;
    getStudents();
    super.onInit();
  }

  @override
  void onClose() {
    termsCtrl.dispose();
    calendarYearCtrl.dispose();
    super.onClose();
  }

  void getStudents() async {
    change(null, status: RxStatus.loading());

    _students = await _repo.getStudents(size: _size, page: _page, 
      yearOfStudy: yearOfStudy,
      text: termsCtrl.text,
    );

    if(_students==null || _students!.students==null || _students!.students!.isEmpty){
      change(_students, status: RxStatus.empty());
      return;
    }

    if(_students!.students!.isNotEmpty){
      change(_students, status: RxStatus.success());
      _total = _students!.total!;
    }
  }

  void loadPage(int page){
    _page = page;
    getStudents();
  }

  void nextPage(){
    if (isNextEnabled) {
      _page++;
      getStudents();
    } 
  }

  void prevPage(){
    if(isPrevEnabled){
      _page--;
      getStudents();
    }
  }

  // Filters

  void changeInternshipYear(int v){
    yearOfStudy = v;
    update();
    getStudents();
  }

  void pickDate(context) async {

    final choice = await Utils.pickDate(context);

    if(choice!=null){
      _calendarYear = choice.year;
      calendarYearCtrl.text = '${_calendarYear-1}/$_calendarYear';
      update();
      getStudents();
    }
  }


}