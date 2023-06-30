class WithdrawModel {
  int id;
  String methodName;
  List<MethodFields> methodFields;
  int isDefault;
  int isActive;
  String createdAt;
  String updatedAt;

  WithdrawModel(
      {this.id,
        this.methodName,
        this.methodFields,
        this.isDefault,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  WithdrawModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodName = json['method_name'];
    if (json['method_fields'] != null) {
      methodFields = <MethodFields>[];
      json['method_fields'].forEach((v) {
        methodFields.add(new MethodFields.fromJson(v));
      });
    }
    isDefault = json['is_default'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['method_name'] = this.methodName;
    if (this.methodFields != null) {
      data['method_fields'] =
          this.methodFields.map((v) => v.toJson()).toList();
    }
    data['is_default'] = this.isDefault;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MethodFields {
  String inputType;
  String inputName;
  String placeholder;
  int isRequired;

  MethodFields(
      {this.inputType, this.inputName, this.placeholder, this.isRequired});

  MethodFields.fromJson(Map<String, dynamic> json) {
    inputType = json['input_type'];
    inputName = json['input_name'];
    placeholder = json['placeholder'];
    isRequired = json['is_required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['input_type'] = this.inputType;
    data['input_name'] = this.inputName;
    data['placeholder'] = this.placeholder;
    data['is_required'] = this.isRequired;
    return data;
  }
}
