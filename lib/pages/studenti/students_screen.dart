
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:unipd_tirocini/pages/studenti/students_controller.dart';
import 'package:unipd_tirocini/pages/studenti/views/filtri_studenti_view.dart';
import 'package:unipd_tirocini/utils/utils.dart';
import 'package:unipd_tirocini/widgets/containers/main_wrapper.dart';
import 'package:unipd_tirocini/widgets/loader.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';

import '../../app/app_colors.dart';
import '../../controllers/download_controller.dart';
import '../../models/students/students_model.dart';
import '../../widgets/logo_unipd.dart';
import '../../widgets/ui/atoms/circles_annualita.dart';
import '../../widgets/ui/contacts.dart';
import '../../widgets/ui/job_erasmus.dart';


class StudentsScreen extends StatelessWidget {
  
  const StudentsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentsController>(
      init: StudentsController(),
      builder: (ctrl) {
        return ScreenTypeLayout(
          breakpoints: ScreenBreakpoints(
            tablet: 600,
            desktop: 950,
            watch: 300
          ),
          desktop:
        
            MainWrapper(
              title: 'Studenti',
              actions: [

                FilledBtn(
                  text: 'SCARICA DATI',
                  rounded: true,
                  onPressed: () async {
                    Utils.showToast(context: context, text: 'Download in cordo... attendere');
                    await DownloadController.to.downloadAll();
                  },
                ),
                
              ],
              child: Stack(
                children: [
            
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      const FiltriStudentiView(),
            
                      const SizedBox(height: 26),
            
                      Container(
                        height: Get.height-400,
                        child: ctrl.obx((state) {
                            return _PaginatedStudentsTable(state!.students ?? []);
                          },
                          onEmpty: const Text('Nessuno studente trovato'),
                          onError: (e) => const Text('Errore, si prega di riprovare'),
                          onLoading: const Loader(),
                        ),
                      ),

                      const SizedBox(height: 70),
                    ],
                  ),

                  ctrl.obx((state) { 
                    return state?.students?.isNotEmpty ?? false ? Positioned(
                      bottom: 0, left: 0, right: 0,
                      child: Container(
                        height: 62,
                        color: AppColors.white,
                        child: Column(
                          children: [

                            const Divider(height: 1,),

                            const SizedBox(height: 15,),

                            Row(
                              children: [
                                
                                Text(' ${ctrl.total} risultati',),
                                const Spacer(),
                                Text('pagina ${ctrl.page} di ${ctrl.maxPage}',),
                                const SizedBox(width: 20,),
                                IconButton(
                                  onPressed: ctrl.isPrevEnabled ? ()=>ctrl.prevPage() : null, 
                                  icon: Icon(Icons.chevron_left),
                                ),
                                const SizedBox(width: 40,),
                                IconButton(
                                  onPressed: ctrl.isNextEnabled ? ()=>ctrl.nextPage() : null, 
                                  icon: Icon(Icons.chevron_right),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ) : SizedBox();
                    },
                    onLoading: SizedBox(),
                    onEmpty: SizedBox(),
                    onError: (error) => SizedBox(),
                  ),
                ],
              ),
            ),
            

            mobile: Container(
              color: AppColors.primary,
              child: Logo(),
            ),
        
        );
      }
    );
  }
}


class _PaginatedStudentsTable extends GetView<StudentsController> {

  final List<Student> data;

  _PaginatedStudentsTable(this.data);

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      dataRowHeight: 64,
      columns: [

        DataColumn2(
          fixedWidth: 40,
          label: const SizedBox(),
        ),
        
        DataColumn(
          label: Text('Cognome Nome\nMATRICOLA', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        
        DataColumn2(
          fixedWidth: 130,
          label: Text('Annualità', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        
        DataColumn(
          label: Text('Gruppo assegnato', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        
        DataColumn2(
          size: ColumnSize.M,
          label: Text('Istituto assegnato', style: TextStyle(fontWeight: FontWeight.w700,),),
        ),
        
        DataColumn2(
          fixedWidth: 160,
          label: Text('Contatti', style: TextStyle(fontWeight: FontWeight.bold),),
          numeric: false,
        ),
      ], 
      rows: [

        for(var student in data)
        DataRow2(
          onTap: (){
            context.push('/studenti/studente/${student.id}');
          },
          color: MaterialStateColor.resolveWith((states) => data.indexOf(student) % 2 == 1 ? AppColors.secondary : Colors.white),
          cells: [

            DataCell(
              IconButton(
                icon: Icon(Icons.copy, size: 20, color: AppColors.iconDefault,),
                onPressed: () => Utils.copyText(context, student.university?.studentNumber ?? 'nessuna matricola'),
              )
            ),

            DataCell(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text('${student.fullname}'),
                  ),
                  Row(
                    children: [
                      Text('${student.university?.studentNumber}', style: TextStyle(color: AppColors.subtitleText),),
                      const SizedBox(width: 8),
                      
                      JobErasmus(
                        iconSize: 18,
                        inErasmus: student.isInErasmus(calendarYear: controller.currentYear),
                        hasJob: student.isWorking(calendarYear: controller.currentYear),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
            
            DataCell(
              CirclesAnnualita(
                annoCorso: student.academicYear(calendarYear: controller.currentYear),
                annoTirocinio: student.getInternshipYear(calendarYear: controller.currentYear),
              ),
            ),

            DataCell(Text(student.getConfirmedIndirect(calendarYear: controller.currentYear)),),

            DataCell(Text(student.getConfirmedDirect(calendarYear: controller.currentYear), maxLines: 3, overflow: TextOverflow.ellipsis,),),

            DataCell(
              Contacts(email: student.email, phoneNumber: student.registry?.cellNumber,),
          )],
        ),

      ],

      
    );
  }
}
