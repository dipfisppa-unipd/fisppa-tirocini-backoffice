

/// Configurazione app
/// [production] usato per i services 
/// 
/// 
abstract class AppConfig {
  static const String BUILDNUMBER = '15'; 

  static const bool PRODUCTION = true;

  static const String EMAIL = '<YOUR_EMAIL>?subject=Richiesta accesso';
  static const String API_PRODUCTION = '<YOUR_BASE_URL>/api';
  static const String SHIBBOLETH_URL = '<YOUR_BASE_URL>/api/shibboleth/login';
  static const String SHIBBOLETH_ENDPOINT = '<YOUR_BASE_URL>/api/shibboleth';
  
  static const String REGOLAMENTO = '<PRIVACY_URL>';
  static const String PRIVACY = '<PRIVACY_URL>';

  /// The height of each row in DataTable2
  static const double DAT_ROW_HEIGHT = 66;

  // Breakpoints
  static const double DESKTOP_MAX_WIDTH = 1320;
}


abstract class StudentCreditsPerYear {

  static const Map<int, int> limits = {
    1: 40,
    2: 85,
    3: 135,
    4: 185,
    5: 185,
    6: 185,
    7: 185,
    8: 185,
    9: 185,
    10: 185,
  };
  
}