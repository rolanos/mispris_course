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

fillTestUnits() async {
  await DataBaseService().addUnit('л', 'Литр', '112');
  await DataBaseService().addUnit('кВт', 'Киловатт', '214');
  await DataBaseService().addUnit('об/мин', 'Оборот в минуту', '331');
  await DataBaseService().addUnit('шт', 'Штука', '796');
  await DataBaseService().addUnit('100 шт', 'Сто штук', '797');
  await DataBaseService().addUnit('тыс. шт.', 'Тысяча штук', '798');
}

fillTestProd() async {
  await DataBaseService().addProd(null, 'Cummins ISB6.7', 4);
  await DataBaseService().addProd(null, 'Yanmar 2GM20', 5);
  await DataBaseService().addProd(null, 'JZ', 6);
  await DataBaseService().addProd(null, '2JZ', 6);
}
