import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:happyco/data/data_locator.config.dart';

final dataLocator = GetIt.instance;

/// Setup data layer dependencies using @Injectable codegen
///
/// Registers:
/// - SharedPreferences
/// - All @injectable classes in data layer (repositories, datasources)
@InjectableInit(initializerName: 'initDataLocator')
Future<void> setupDataLocator() async {
  final prefs = await SharedPreferences.getInstance();
  dataLocator.registerSingleton<SharedPreferences>(prefs);

  dataLocator.initDataLocator();
}
