import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:unipd_tirocini/models/user.dart';
import 'package:unipd_tirocini/widgets/containers/main_wrapper.dart';

import '../../app/app_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/ui/atoms/btn_primary.dart';
import '../../widgets/ui/contacts.dart';
import 'operators_controller.dart';


class OperatorsScreen extends StatelessWidget {
  const OperatorsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      title: 'Operatori della piattaforma',
      actions: [
            
        BtnPrimary(
          text: 'Crea nuovo operatore',
          onTap: (){
            context.pushNamed('crea-operatore');
          },
        ),

      ],
      child: GetBuilder<OperatorsController>(
            init: OperatorsController(),
            builder: (ctrl) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      
                      const Text('Filtra operatori: '),

                      const SizedBox(width: 10),
                      
                      DropdownButton2<UserType>(
                        buttonHeight: 40,
                        buttonWidth: 200,
                        buttonDecoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightText, width:1), //border of dropdown button
                          borderRadius: BorderRadius.circular(4), 
                        ),
                        buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                        isExpanded: true,
                        items: [
                          
                          DropdownMenuItem(
                            value: UserType.superadmin,
                            child: Text('Admins'),
                          ),

                          DropdownMenuItem(
                            value: UserType.organizerTutor,
                            child: Text('Tutor organizzatore'),
                          ),
                          
                          DropdownMenuItem(
                            value: UserType.coordinatorTutor,
                            child: Text('Tutor coordinatore'),
                          ),

                          DropdownMenuItem(
                            value: UserType.administration,
                            child: Text('Amministrazione'),
                          ),

                        ],
                        value: ctrl.userTypeFilter,
                        onChanged: (v){
                          if(v!=null) ctrl.onFilterChanged(v);
                        },
                        underline: const SizedBox(),
                      )
                    ],
                  ),

                  const SizedBox(height: 26,),

                  Container(
                    height: Get.height-400,
                    child: ctrl.obx((state) {
                        return _PaginatedTable(state!.users ?? []);
                      },
                      onEmpty: Text('Nessun utente trovato'),
                      onError: (e) => Text('Si è verificato un errore: $e')
                    ),
                  ),

                  const SizedBox(height: 70),
                ],
              );
            }
      ),
    );
  }
}


class _PaginatedTable extends StatelessWidget {

  final List<UserModel> data;

  _PaginatedTable(this.data);

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      dataRowHeight: 64,
      columns: [
        
        DataColumn(
          label: Text('Cognome e nome', style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        DataColumn(
          label: Text('E-mail Unipd', style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        DataColumn2(
          fixedWidth: 190,
          label: Text('Contatti', style: TextStyle(fontWeight: FontWeight.bold),),
          numeric: false,
        ),
        
        DataColumn2(
          fixedWidth: 190,
          label: Text('Ruolo', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        
      ], 
      rows: [

        for(var user in data)
        DataRow2(
          // onTap: (){
          //   context.push('/utenti/operatore/${user.id}');
          // },
          color: MaterialStateColor.resolveWith((states) => data.indexOf(user) % 2 == 1 ? AppColors.secondary : Colors.white),
          cells: [
            DataCell(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text('${user.fullname}'),
                  ),
                  
                ],
              ),
            ),

            DataCell(
              InkWell(
                onTap: (){
                  Utils.copyText(context, user.email!);
                },
                child: Text(user.email ?? '-', style: TextStyle(color: AppColors.primary),)
              )
            ),

            DataCell(
              Contacts(email: user.registry?.personalEmail ?? user.email, phoneNumber: user.registry?.cellNumber,),
            ),

            DataCell(Text(user.userRole())),  

          ],
        ),

      ],

      
    );
  }
}