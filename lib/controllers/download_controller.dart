import 'package:file_saver/file_saver.dart';
import 'package:get/get.dart';

import '../repos/download_repo.dart';


class DownloadController extends GetxController{

  static DownloadController get to => Get.find();

  final _repo = DownloadRepo();

  Future<void> downloadAll() async {
    var data = await _repo.exportAll();

    if(data!=null)
    await FileSaver.instance.saveFile('Unipd_FISPPA_${DateTime.now().year}', data, 'csv', mimeType: MimeType.CSV);
  } 
}