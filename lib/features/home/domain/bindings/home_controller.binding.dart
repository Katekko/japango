import 'package:flutter/cupertino.dart';
import 'package:japango/features/home/domain/usecases/get_one_question.usecase.dart';

import '../abstractions/controllers/home_controller.interface.dart';
import '../../presentation/controller/home.controller.dart';
import '../../../../core/abstractions/field.interface.dart';
import '../../../../core/builders/field_validator.builder.dart';
import '../../../../core/inject.dart';
import '../../../../core/models/react_field.model.dart';

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

IHomeController makeHomeController() => HomeController(
      answer: makeNameField(),
      getOneQuestionUseCase: GetOneQuestionUseCase(),
    );

IField<String> makeNameField() {
  return ReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
    controller: TextEditingController(),
  );
}
