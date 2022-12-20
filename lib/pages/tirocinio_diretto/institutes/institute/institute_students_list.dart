// https://xd.adobe.com/view/52e4e83a-a5a2-4558-a64d-bc8ec69b71e7-07b7/screen/5298cbc9-fb37-4726-a9ae-f43a9ad21db0

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/pages/tirocinio_diretto/institutes/institute/institute_controller.dart';
import 'package:unipd_tirocini/widgets/ui/empty_data_box.dart';
import 'package:unipd_tirocini/widgets/ui/job_erasmus.dart';

import '../../../../app/app_colors.dart';
import '../../../../models/td/direct_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/containers/white_box.dart';
import '../../../../widgets/ui/atoms/btn_primary.dart';
import '../../../../widgets/ui/atoms/circles_annualita.dart';



class InstituteStudentsList extends StatelessWidget {
  const InstituteStudentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstituteController>(
      builder: (ctrl){
        
        if(ctrl.institute==null)
          return const SizedBox();

        if(ctrl.institute!.directInternships.isEmpty)
          return const EmptyDataBox('Non sono presenti studenti per questo istituto');
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            ...ctrl.groupedInternships.entries.map((e) 
              => _StudentsBoxPerAcademicYear(
                    e.value, 
                    instituteCode: ctrl.institute!.code,
                    calendarYear: e.key,)).toList(),

          ],
        );
        
      },
    );
  }
}


class _StudentsBoxPerAcademicYear extends StatefulWidget {

  final String instituteCode;
  final List<DirectInternship> internships;
  final int calendarYear;

  const _StudentsBoxPerAcademicYear(this.internships, {required this.instituteCode, required this.calendarYear, Key? key}) : super(key: key);

  @override
  State<_StudentsBoxPerAcademicYear> createState() => _StudentsBoxPerAcademicYearState();
}

class _StudentsBoxPerAcademicYearState extends State<_StudentsBoxPerAcademicYear> {

  // Here you check for some changes in your route that indicate you are no longer on the page you have pushed before
  void watchRouteChange() {
    if (GoRouter.of(context).location.endsWith("/istituto/${widget.instituteCode}")) {
      if(Get.isRegistered<InstituteController>())
        InstituteController.to.reload();
      GoRouter.of(context).removeListener(watchRouteChange); // remove listener
    }
  }

  @override
  Widget build(BuildContext context) {
    return WhiteBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(60, 50, 60, 70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Studenti", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                Text("${widget.calendarYear-1}/${widget.calendarYear}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: const Divider(thickness: 1, color: Color(0xFFD1D1D1),),
            ),

            Container(
              height: 70 + (widget.internships.length * 60),
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                dataRowHeight: 64,
                columns: [
                  
                  const DataColumn(
                    label: const Text('Cognome Nome\nMATRICOLA', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  const DataColumn2(
                    fixedWidth: 150,
                    label: const Text('Annualità', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  const DataColumn2(
                    fixedWidth: 100,
                    label:const  Text('Scelta', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  const DataColumn2(
                    fixedWidth: 200,
                    label:const  Text('Assegnazione', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  
                  const DataColumn2(
                    fixedWidth: 160,
                    label: const Text('Contatti', style: TextStyle(fontWeight: FontWeight.bold),),
                    numeric: false,
                  ),
                ], 
                rows: [
                  
                  for(var internship in widget.internships)
                  if(internship.enhancedUser!=null)
                  DataRow2(
                    onTap: () async {
                      context.push('/studenti/studente/${internship.enhancedUser!.id}');
                      await Future.delayed(Duration(seconds: 1),);
                      GoRouter.of(context).addListener(watchRouteChange);
                    },
                    cells: [
                      
                      // C1
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text('${internship.enhancedUser!.fullname}'),
                            ),
                            Row(
                              children: [
                                Text('${internship.enhancedUser!.university?.studentNumber}', style: TextStyle(color: AppColors.subtitleText),),
                                const SizedBox(width: 8),

                                JobErasmus(
                                  iconSize: 18,
                                  inErasmus: internship.enhancedUser!.isInErasmus(calendarYear: widget.calendarYear),
                                  hasJob: internship.enhancedUser!.isWorking(calendarYear: widget.calendarYear),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // C2
                      DataCell(
                        CirclesAnnualita(
                          annoCorso: internship.enhancedUser!.academicYear(calendarYear: internship.calendarYear??0),
                          annoTirocinio: internship.internshipYear??0,
                          // non ho i dati dei tirocini nel modello studente restituito per l'istituto
                        ),
                      ), 

                      // C3
                      DataCell(
                        Text(internship.checkDirectStatus(widget.instituteCode,).keys.first.toString())
                      ),

                      // C4 - Conferma / Assegna
                      if(internship.checkDirectStatus(widget.instituteCode,).values.first=='CONFERMATO')
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('CONFERMATO', textAlign: TextAlign.center,))
                      ),
                      if(internship.checkDirectStatus(widget.instituteCode,).values.first=='Assegnato')
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text('Assegnato'),
                        )
                      ),
                      if(internship.checkDirectStatus(widget.instituteCode,).values.first=='Non assegnato')
                      DataCell(
                        FilledBtn(text: 'ASSEGNA', onPressed: 
                          () => InstituteController.to.assignStudent(context, internship, widget.instituteCode, reloadPage: true)
                        ),
                      ),
                      if(internship.checkDirectStatus(widget.instituteCode,).values.first.startsWith('Manuale'))
                      DataCell(
                        Text(internship.checkDirectStatus(widget.instituteCode,).values.first)
                      ),
                                              
                      // C5
                      DataCell(Row(
                        children: [

                          InkWell(
                            onTap: (){
                              Utils.copyText(context, internship.enhancedUser!.registry?.personalEmail ?? internship.enhancedUser!.email!);
                            },
                            child: Text('@', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w700, fontSize: 18),),
                          ),
                  
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: InkWell(
                              onTap: ()=>Utils.copyText(context, '${internship.enhancedUser!.registry?.cellNumber ?? '000'}'),
                              child: Text('${internship.enhancedUser!.registry?.cellNumber}'),),
                          ),
                        ],
                      )
                    )],
                  ),

                ],

                
              )
            ),

            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}