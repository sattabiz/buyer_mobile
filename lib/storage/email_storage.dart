import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class emailStorageService{
  late final FlutterSecureStorage _preferences;

  emailStorageService(){
    _preferences = FlutterSecureStorage();
  }

  Future<void> saveEmailData(String _email)async{

    await _preferences.write(key: 'email', value: _email);
  }
  Future<String> getEmailData()async{
    var _key = await _preferences.read(key: 'email');
    return _key ?? '';
  }
  Future<void> deleteEmailData() async {
    await _preferences.delete(key: 'email');
  }
}
