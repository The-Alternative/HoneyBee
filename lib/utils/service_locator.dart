

import 'package:get_it/get_it.dart';

import '../Modules/children/service/childService/childService.dart';
import '../Modules/children/service/childService/childServiceDataBase.dart';
import '../Modules/children/service/childHabitService/childHabitService.dart';
import '../Modules/children/service/childHabitService/childHabitServiceDataBase.dart';
import '../Modules/children/service/developmentService/developmentService.dart';
import '../Modules/children/service/developmentService/developmentServiceDatabase.dart';
import '../Modules/children/service/eventService/eventService.dart';
import '../Modules/children/service/eventService/eventServiceDatabase.dart';
import '../Modules/children/service/habitService/habitService.dart';
import '../Modules/children/service/habitService/habitServiceDatabase.dart';
import '../Modules/children/service/habitTypeService/habitTypeService.dart';
import '../Modules/children/service/habitTypeService/habitTypeServiceDatabase.dart';
import '../Modules/children/service/healthService/healthService.dart';
import '../Modules/children/service/healthService/healthServiceDatabase.dart';
import '../Modules/children/service/mediaService/mediaService.dart';
import '../Modules/children/service/mediaService/mediaServiceDatabase.dart';
import '../Modules/bmi/service/descService.dart';
import '../Modules/bmi/service/descServiceDatabase.dart';
import '../Modules/medicine/service/cardinfoService/cardinfoService.dart';
import '../Modules/medicine/service/cardinfoService/cardinfoServiceDatabase.dart';
import '../Modules/medicine/service/diagonService/diagonService.dart';
import '../Modules/medicine/service/diagonService/diagonServiceDatabase.dart';
import '../Modules/medicine/service/medicineDayService/medicineDayService.dart';
import '../Modules/medicine/service/medicineDayService/medicineDayServiceDatabase.dart';
import '../Modules/medicine/service/medicineService/medicineService.dart';
import '../Modules/medicine/service/medicineService/medicineServiceDatabase.dart';
import '../Modules/medicine/service/medicineViewService/medicineViewService.dart';
import '../Modules/medicine/service/medicineViewService/medicineViewDatabase.dart';
import '../Modules/medicine/service/patientService/patientService.dart';
import '../Modules/medicine/service/patientService/patientServiceDatabase.dart';
import '../Modules/medicine/service/timesDayesService/timesDayesService.dart';
import '../Modules/medicine/service/timesDayesService/timesDayesServiceDatabase.dart';

import '../Modules/study/service/courseService.dart';
import '../Modules/study/service/courseServiceDatabase.dart';


GetIt locator = GetIt.instance;

setupServiceLocator (){
  locator.registerLazySingleton<ChildServic>(() => ChildServerDateBase());
  locator.registerLazySingleton<ChildHabitService>(() => ChildHabitServiceDatabase());
  locator.registerLazySingleton<DevelopmentService>(() => DevelopmentServiceDatabase());
  locator.registerLazySingleton<EventService>(() => EventServiceDatabase());
  locator.registerLazySingleton<HabitService>(() => HabitServiceDatabase());
  locator.registerLazySingleton<HabitTypeService>(() => HabitTypeServiceDatabase());
  locator.registerLazySingleton<HealthService>(() => HealthServiceDatabase());
  locator.registerLazySingleton<MediaService>(() => MediaServiceDatabase());
  locator.registerLazySingleton<DescService>(() => DescServiceDatabase());
  locator.registerLazySingleton<CardinfoService>(() => CardinfoServiceDatabase());
  locator.registerLazySingleton<DiagonService>(() => DiagonServiceDatabase());
  locator.registerLazySingleton<MedicineDayService>(() => MedicineDayServiceDatabase());
  locator.registerLazySingleton<MedicineService>(() => MedicineServiceDatabase());
  locator.registerLazySingleton<MedicineViewService>(() => MedicineViewServiceDatabase());
  locator.registerLazySingleton<PatientService>(() => PatientServiceDatabase());
  locator.registerLazySingleton<TimesDayesService>(() => TimesDayesServiceDatabase());
  locator.registerLazySingleton<CourseService>(() => CourseServiceDatabase());
}

