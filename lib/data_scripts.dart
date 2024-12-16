import 'dart:developer';

import 'database_service.dart';

initDbData() async {
  final testVal1 = await DataBaseService().getAllChemClass();
  final testVal2 = await DataBaseService().getAllUnits();
  final testVal3 = await DataBaseService().getAllProds();
  final testVal4 = await DataBaseService().getAllSpecProds();
  if (testVal1.isEmpty) {
    await fillTestUnits();
    final units = await DataBaseService().getAllUnits();
    log(units.toString());
  }
  if (testVal2.isEmpty) {
    await fillTestChemClass();
    final chemClass = await DataBaseService().getAllChemClass();
    log(chemClass.toString());
  }
  if (testVal3.isEmpty) {
    await fillTestProd();
    final testProd = await DataBaseService().getAllProds();
    log(testProd.toString());
  }
  if (testVal4.isEmpty) {
    await fillTestSpecProd();
    final testSpecProd = await DataBaseService().getAllSpecProds();
    log(testSpecProd.toString());
  }
  final res = await DataBaseService().countClassAmount(3);
  res.forEach((idProdPart, quantity) {
    print('idProdPart: $idProdPart, Quantity: $quantity');
  });
}

fillTestChemClass() async {
  await DataBaseService().addChemClass('Изд', 'Изделия', null, null);
  await DataBaseService()
      .addChemClass('Ср рельс тр', 'Средства рельсового транспорта', null, 1);
  await DataBaseService().addChemClass(null, 'Локомотивы', 5, 2);
  await DataBaseService().addChemClass(null, 'Тепловозы', 6, 3);
  await DataBaseService().addChemClass(null, 'Электровозы магистральные', 6, 3);
  await DataBaseService().addChemClass(null, 'Электровозы промышленные', 6, 3);
  await DataBaseService().addChemClass(null, 'Магнитопланы с подвесом', 6, 3);
  await DataBaseService().addChemClass(
      null, 'Вагоны магистральные жд городского транспорта', 2, 2);
  await DataBaseService().addChemClass(null, 'Электропоезд', 2, 8);
  await DataBaseService().addChemClass(null, 'Дизель-поезд', 2, 8);
  await DataBaseService().addChemClass(null, 'Метрополитен', 2, 8);
  await DataBaseService().addChemClass(null, 'Трамвай', 2, 8);
  await DataBaseService()
      .addChemClass(null, 'Вагоны магистральных жд груз', 7, 2);
  await DataBaseService().addChemClass(null, 'Платформы', 2, 13);
}

fillTestUnits() async {
  await DataBaseService().addUnit('шт', 'Штука', '796');
  await DataBaseService().addUnit('кг', 'Килограмм', '166');
  await DataBaseService().addUnit('Вт', 'Ватт', '212');
  await DataBaseService().addUnit('л', 'Литр', '112');
  await DataBaseService().addUnit('квт/ч', 'Мощность', '213');
  await DataBaseService().addUnit('км/ч', 'Километр в час', '333');
  await DataBaseService().addUnit('м^3', 'Тысяча кубических метров', '444');
}

fillTestProd() async {
  await DataBaseService().addProd(null, 'Трамвай1', 12);
  await DataBaseService().addProd(null, 'Платформа1', 14);
  await DataBaseService().addProd(null, 'Поезд метро1', 11);
}

fillTestSpecProd() async {
  await DataBaseService().addSpecProd(3, 1, 1, 1);
  await DataBaseService().addSpecProd(3, 2, 2, 9);
  await DataBaseService().addSpecProd(1, 2, 2, 2);
}
