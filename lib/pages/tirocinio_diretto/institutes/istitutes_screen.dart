// https://xd.adobe.com/view/52e4e83a-a5a2-4558-a64d-bc8ec69b71e7-07b7/screen/fe468f5b-8186-4424-83b1-956abc887678

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/pages/tirocinio_diretto/institutes/institutes_controller.dart';
import 'package:unipd_tirocini/pages/tirocinio_diretto/institutes/views/institutes_filters.dart';
import 'package:unipd_tirocini/utils/ucfirst.dart';
import 'package:unipd_tirocini/widgets/containers/main_wrapper.dart';
import 'package:unipd_tirocini/widgets/loader.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';

import '../../../app/app_config.dart';
import '../../../models/td/institute_model.dart';
import '../../../utils/utils.dart';


class InstitutesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstitutesController>(
      init: InstitutesController(),
      builder: (ctrl) {
        return MainWrapper(
          title: 'Istituti scolastici',
          actions: [
            
            BtnPrimary(
              text: 'Crea istituto',
              onTap: (){
                context.pushNamed('nuovo-istituto');
              },
            ),

          ],
          child: Stack(
            children: [
        
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [

                  const SizedBox(
                    height: 90,
                    child: const InstitutesFilters(),
                  ),
        
                  const SizedBox(height: 26),
        
                  Container(
                    height: Get.height-400,
                    child: ctrl.obx((state) {
                        return _InstitutesPaginated(state!.institutes ?? []);
                      },
                      onLoading: ctrl.showStudents ? const LoaderPro('Questa ricerca può richiedere alcuni secondi') : const Loader(),
                      onEmpty: const Text('Nessun risultato'),
                      onError: (e) => Text(e ?? 'Si è verificato un errore')
                    ),
                  ),

                  const SizedBox(height: 70),
                ],
              ),

              ctrl.obx((state) { 
                return state?.institutes?.isNotEmpty ?? false ? Positioned(
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
                            
                            if(!ctrl.showStudents)...[

                              Text(' ${ctrl.total} risultati',),
                              const Spacer(),
                              Text('pagina ${ctrl.page} di ${ctrl.maxPage}',),

                            ],
                            
                            if(ctrl.showStudents)
                              const Spacer(),
                            
                            const SizedBox(width: 20,),
                            IconButton(
                              onPressed: ctrl.isPrevEnabled ? ()=>ctrl.prevPage() : null, 
                              icon: const Icon(Icons.chevron_left),
                            ),
                            const SizedBox(width: 40,),
                            IconButton(
                              onPressed: ctrl.isNextEnabled ? ()=>ctrl.nextPage() : null, 
                              icon: const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ) : const SizedBox();
                },
                onLoading: const SizedBox(),
                onEmpty: const SizedBox(),
                onError: (error) => const SizedBox(),
              ),
        
              
        
            ],
          )
        );
      }
    );
  }
}


class _InstitutesPaginated extends GetView<InstitutesController> {

  final List<Institute> data;
  
  const _InstitutesPaginated(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      dataRowHeight: AppConfig.DAT_ROW_HEIGHT,
      decoration: BoxDecoration(
        color: AppColors.secondary,
      ),
      columns: [

        DataColumn2(
          fixedWidth: 40,
          label: const SizedBox(),
        ),

        DataColumn2(
          label: Text('Denominazione', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        DataColumn(
          label: Text('Comune e indirizzo', style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        DataColumn(
          label: Text('Ordine', style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        DataColumn(
          label: Text('Istituto e provincia', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        
        
        DataColumn(
          label: Text('Convenzione', style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        if(controller.showStudents)
        DataColumn(
          label: Text('Studenti', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        
      ],
      rows:  [
          
        for(var i in data)
          DataRow2(
            onTap: (){
              context.pushNamed('istituto', params: {'code': i.code});
            },
            color: MaterialStateColor.resolveWith((states) => data.indexOf(i) % 2 == 1 ? AppColors.secondary : Colors.white),
            cells: [

              DataCell(
                IconButton(
                  icon: Icon(Icons.copy, size: 20, color: AppColors.iconDefault,),
                  onPressed: () => Utils.copyText(context, i.code),
                )
              ),
              
              DataCell(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(i.name.toClean().toUCFirst()),
                    ),
                    Text(i.code, style: TextStyle(color: AppColors.subtitleText),),
                  ],
                ),
              ),

              DataCell(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(i.city.toUCFirst()),
                    ),
                    Text(i.address.toUCFirst(), style: TextStyle(color: AppColors.subtitleText), maxLines: 1,),
                  ],
                ),
              ),

              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SvgPicture.asset(
                      i.schoolIcon(),
                      width: 15,
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(i.educationDegree.replaceAll('SCUOLA ', '').toUCFirst()),
                    ),
                  ],
                ),
              ),

              DataCell(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(i.referenceInstituteName.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(i.referenceInstituteName.toClean().toUCFirst()),
                  ),
                  Text(i.province),
                ],
              ),),


              DataCell(Text(i.conventionEnds(),),),

              if(controller.showStudents)
              DataCell(Text(i.directInternshipsCount.toString()),),

              
            ],
          )
      ],
    );
  }
}