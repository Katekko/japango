import 'package:flutter/cupertino.dart';

import '../../../features/home/domain/abstractions/home_controller.interface.dart';
import '../../../features/home/presentation/controller/home.controller.dart';
import '../../abstractions/field.interface.dart';
import '../../builders/field_validator.builder.dart';
import '../../inject.dart';
import '../../models/react_field.model.dart';

class HomeControllerBinding {
  static void inject({String? password}) {
    if (!Inject.exists<IHomeController>()) {
      Inject.lazyPut<IHomeController>(() => makeHomeController());
    } else {
      HomeControllerBinding.dipose();
      inject(password: password);
    }
  }

  static void dipose() {
    Inject.remove<IHomeController>(
      disposeFunction: (controller) => controller.dispose(),
    );
  }
}

IHomeController makeHomeController() => HomeController(answer: makeNameField());

IField<String> makeNameField() {
  return ReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
    controller: TextEditingController(),
  );
}
