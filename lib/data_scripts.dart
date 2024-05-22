import 'database_service.dart';

fillTestChemClass() async {
  await DataBaseService().addChemClass(null, 'Изделия', 4, null);
  await DataBaseService().addChemClass(null, 'Двигатели', 4, 1);
  await DataBaseService()
      .addChemClass(null, 'Поршневые внутреннего сгорания', 4, 2);
  await DataBaseService().addChemClass(null,
      'С самовоспламенением дизели 4-х тактные жидкостного охлаждения', 4, 3);
  await DataBaseService().addChemClass(null,
      'С самовоспламенением дизели 2-х тактные воздушного охлаждения', 4, 3);
  await DataBaseService().addChemClass(null,
      'С самовоспламенением дизели 2-х тактные жидкостного охлаждения', 4, 3);
}
