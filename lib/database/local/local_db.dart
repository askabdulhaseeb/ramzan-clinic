import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../enums/day.dart';
import '../../enums/gender.dart';
import '../../enums/procigar_type.dart';
import '../../models/case/case.dart';
import '../../models/case/case_item.dart';
import '../../models/case/counter.dart';
import '../../models/core/address.dart';
import '../../models/core/department.dart';
import '../../models/core/routine.dart';
import '../../models/patient/patient.dart';
import '../../models/procigar/procigar.dart';
import '../../models/user/app_user.dart';
import 'local_address.dart';
import 'local_auth.dart';
import 'local_case.dart';
import 'local_counter.dart';
import 'local_department.dart';
import 'local_patient.dart';
import 'local_procigar.dart';
import 'local_user.dart';

class LocalDB {
  static Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.initFlutter();
    await LocalAuth.init();

    // ADAPTERS
    // User 11...19
    Hive.registerAdapter(AppUserAdapter()); // 11

    // PATIENT 21...29
    Hive.registerAdapter(PatientAdapter()); // 21

    // PROCIGER 31...39
    Hive.registerAdapter(ProcigarAdapter()); // 31
    Hive.registerAdapter(ProcigarTypeAdapter()); // 32

    // PROCIGER 51...59
    Hive.registerAdapter(CaseAdapter()); // 51
    Hive.registerAdapter(CaseItemAdapter()); // 52
    Hive.registerAdapter(CounterAdapter()); // 53

    //

    // CORE 200...210
    Hive.registerAdapter(AddressAdapter()); // 200
    Hive.registerAdapter(DepartmentAdapter()); // 201
    Hive.registerAdapter(RoutineAdapter()); // 202

    // ENUMS 211...220
    Hive.registerAdapter(DayAdapter()); // 211
    Hive.registerAdapter(GenderAdapter()); // 212

    // OPEN BOXES
    await LocalUser.openBox;
    await LocalPatient.openBox;
    await LocalAddress.openBox;
    await LocalDepartment.openBox;
    await LocalProcigar.openBox;
    await LocalCase.openBox;
    await LocalCounter.openBox;
  }
}
