import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class passwordStorageService{
  late final FlutterSecureStorage _preferences;

  passwordStorageService(){
    _preferences = FlutterSecureStorage();
  }

  Future<void> savePasswordData(String _password)async{

    await _preferences.write(key: 'password', value: _password);
  }
  Future<String> getPasswordData()async{
    var _key = await _preferences.read(key: 'password');
    return _key ?? '';
  }
  Future<void> deletePasswordData() async {
    await _preferences.delete(key: 'password');
  }
}
