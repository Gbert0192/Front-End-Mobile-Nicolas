import 'package:flutter/material.dart';

class DateController extends ValueNotifier<DateTime?> {
  DateController([DateTime? initialDate]) : super(initialDate);

  DateTime? get date => value;
  set date(DateTime? newDate) => value = newDate;
}

class DropdownController<T> extends ValueNotifier<T?> {
  DropdownController([T? initialValue]) : super(initialValue);

  T? get selected => value;
  set selected(T? newValue) => value = newValue;
}
