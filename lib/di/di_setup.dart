import 'package:get_it/get_it.dart';

import '../controller/ebook_controller.dart';
import '../repository/ebook_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<EbookRepository>(() => EbookRepository());
  getIt.registerLazySingleton<EbookListController>(
      () => EbookListController(EbookRepository()));
}
