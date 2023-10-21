class UpdateUserRequest {
  String updateField;
  String value;

  UpdateUserRequest(this.updateField, this.value);

  Map<String, dynamic> toJson() => {"updateField": updateField, "value": value};
}
