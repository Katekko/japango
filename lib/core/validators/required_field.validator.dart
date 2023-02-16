import 'package:equatable/equatable.dart';

import '../abstractions/validators/field_validator.interface.dart';

class RequiredFieldValidator<T> extends Equatable
    implements IFieldValidator<T> {
  @override
  String? validate(T? value) {
    if (value == null) return 'Campo Obrigatório';

    if (value is String && value.isEmpty) {
      return 'Campo Obrigatório';
    } else if ((value is int || value is double || value is num) &&
        (value == 0 || value == .0)) {
      return 'Campo Obrigatório';
    }

    return null;
  }

  @override
  List<Object?> get props => [];
}
