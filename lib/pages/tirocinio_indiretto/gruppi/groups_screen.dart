import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/app/app_colors.dart';
import 'package:unipd_tirocini/pages/tirocinio_indiretto/gruppi/views/groups_filters.dart';
import 'package:unipd_tirocini/pages/tirocinio_indiretto/ti_controller.dart';
import 'package:unipd_tirocini/utils/utils.dart';
import 'package:unipd_tirocini/widgets/containers/main_wrapper.dart';
import 'package:unipd_tirocini/widgets/loader.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/btn_primary.dart';
import 'package:unipd_tirocini/widgets/ui/atoms/circles_annualita.dart';

import '../../../models/ti/group_model.dart';


class GroupsScreen extends StatelessWidget {

  GroupsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TIController>(
      init: TIController(),
      builder: (ctrl) {
        return MainWrapper(
          title: 'Gruppi',
          actions: [
            BtnPrimary(
              text: 'Crea nuovo gruppo',
              onTap: (){
                context.pushNamed('crea-gruppo');
              },
            ),

            const SizedBox(width: 30,),

            BtnPrimary(
              text: 'Scarica dati',
              onTap: (){
                Utils.showToast(context: context, isWarning: true, text: 'Non disponibile');
              },
            ),
            
          ],
          child: Stack(
            children: [
              
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const GroupsFilters(),

                  const SizedBox(height: 26),

                  Container(
                    height: Get.height-400,
                    child: ctrl.obx(
                      (state){
                        return _PaginatedGroupTable(groups: state!);
                      },
                      onEmpty: const Text('Nessun gruppo trovato'),
                      onError: (error) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: const Text('Errore, si prega di riprovare'),
                          ),
                          TextButton.icon(
                            onPressed: ctrl.getGroups, 
                            icon: const Icon(Icons.update), 
                            label: const Text('Ricarica'),
                          )
                        ],
                      ),
                      onLoading: const Loader(),
                    ),
                  ),

                  const SizedBox(height: 70),
                ],
              ),

            ],
          ),
        );
      }
    );
  }
}


class _PaginatedGroupTable extends GetView<TIController> {

  final List<GroupModel> groups;

  const _PaginatedGroupTable({required this.groups, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      dataRowHeight: 60,
      decoration: BoxDecoration(
        color: AppColors.secondary,
      ),
      columns: [
        DataColumn2(
          size: ColumnSize.M,
          label: const Text('Denominazione', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        
        DataColumn(
          label: const Text('Territorialità', style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        DataColumn2(
          size: ColumnSize.M,
          label: const Text('Anno fondazione', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        DataColumn(
          label: const Text('Tutor Coordinatore', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        DataColumn(
          label: const Text('Tutor Organizzatore', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        
        DataColumn(
          label: const Text('Annualità', style: TextStyle(fontWeight: FontWeight.bold),),
          numeric: false,
        ),
      ],
      rows: [

        for(var g in groups)
        DataRow2(
          color: MaterialStateColor.resolveWith((states) => groups.indexOf(g) % 2 == 1 ? AppColors.secondary : Colors.white),
          onTap: () {
            context.pushNamed('gruppo', params: {'gid': g.id!}, queryParams: {'internshipYear': '${controller.currentYear-(g.foundationYear)}'});
          },
          cells: [

              DataCell(Text('${g.name}'),),

              DataCell(Text('${g.territorialityName}'),),

              DataCell(Text('${g.foundationYear}'),),

              DataCell(
                Text('${(g.coordinatorTutor?.fullname!='nd'?g.coordinatorTutor?.fullname:g.coordinatorTutor?.email) ?? '-'}'),
              ),

              DataCell(
                Text('${(g.organizerTutor?.fullname!='nd'?g.organizerTutor?.fullname:g.organizerTutor?.email) ?? '-'}'),
              ),

              DataCell(
                CirclesAnnualita(
                  annoCorso: 0,
                  annoTirocinio: controller.currentYear-(g.foundationYear),
                ),
              ),
          ]
        ),
      ]
    );
  }
}