import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/login_model.dart';

class jwtStorageService{
  late final FlutterSecureStorage _preferences;

  jwtStorageService(){
    _preferences = FlutterSecureStorage();
  }

  Future<void> saveJwtData(LoginModel loginModel)async{

    await _preferences.write(key: 'jwt', value: loginModel.jwt);
  }
  Future<String> getJwtData()async{
    var _key = await _preferences.read(key: 'jwt');
    return _key ?? '';
  }
  Future<void> deleteJwtData() async {
    await _preferences.delete(key: 'jwt');
  }
}
