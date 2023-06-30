class EmergencyContactModel {
  List<ContactList> contactList;

  EmergencyContactModel({this.contactList});

  EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    if (json['contact_list'] != null) {
      contactList = <ContactList>[];
      json['contact_list'].forEach((v) {
        contactList.add(new ContactList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contactList != null) {
      data['contact_list'] = this.contactList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactList {
  int id;
  int userId;
  String name;
  String phone;
  int status;
  String createdAt;
  String updatedAt;

  ContactList(
      {this.id,
        this.userId,
        this.name,
        this.phone,
        this.status,
        this.createdAt,
        this.updatedAt});

  ContactList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
