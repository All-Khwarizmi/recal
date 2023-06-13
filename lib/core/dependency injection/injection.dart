import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/core/dependency%20injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async => await getIt.init();
