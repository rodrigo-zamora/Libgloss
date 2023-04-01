/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Users type in your schema. */
@immutable
class Users extends Model {
  static const classType = const _UsersModelType();
  final String id;
  final TemporalDateTime? _createdDate;
  final TemporalDateTime? _updatedDate;
  final String? _sellerID;
  final String? _settingsID;
  final String? _phoneNumber;
  final String? _profilePicture;
  final String? _token;
  final String? _username;
  final String? _zipCode;
  final String? _email;
  final bool? _isAdministrator;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UsersModelIdentifier get modelIdentifier {
      return UsersModelIdentifier(
        id: id
      );
  }
  
  TemporalDateTime? get createdDate {
    return _createdDate;
  }
  
  TemporalDateTime? get updatedDate {
    return _updatedDate;
  }
  
  String? get sellerID {
    return _sellerID;
  }
  
  String? get settingsID {
    return _settingsID;
  }
  
  String? get phoneNumber {
    return _phoneNumber;
  }
  
  String? get profilePicture {
    return _profilePicture;
  }
  
  String? get token {
    return _token;
  }
  
  String? get username {
    return _username;
  }
  
  String? get zipCode {
    return _zipCode;
  }
  
  String? get email {
    return _email;
  }
  
  bool? get isAdministrator {
    return _isAdministrator;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Users._internal({required this.id, createdDate, updatedDate, sellerID, settingsID, phoneNumber, profilePicture, token, username, zipCode, email, isAdministrator, createdAt, updatedAt}): _createdDate = createdDate, _updatedDate = updatedDate, _sellerID = sellerID, _settingsID = settingsID, _phoneNumber = phoneNumber, _profilePicture = profilePicture, _token = token, _username = username, _zipCode = zipCode, _email = email, _isAdministrator = isAdministrator, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Users({String? id, TemporalDateTime? createdDate, TemporalDateTime? updatedDate, String? sellerID, String? settingsID, String? phoneNumber, String? profilePicture, String? token, String? username, String? zipCode, String? email, bool? isAdministrator}) {
    return Users._internal(
      id: id == null ? UUID.getUUID() : id,
      createdDate: createdDate,
      updatedDate: updatedDate,
      sellerID: sellerID,
      settingsID: settingsID,
      phoneNumber: phoneNumber,
      profilePicture: profilePicture,
      token: token,
      username: username,
      zipCode: zipCode,
      email: email,
      isAdministrator: isAdministrator);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Users &&
      id == other.id &&
      _createdDate == other._createdDate &&
      _updatedDate == other._updatedDate &&
      _sellerID == other._sellerID &&
      _settingsID == other._settingsID &&
      _phoneNumber == other._phoneNumber &&
      _profilePicture == other._profilePicture &&
      _token == other._token &&
      _username == other._username &&
      _zipCode == other._zipCode &&
      _email == other._email &&
      _isAdministrator == other._isAdministrator;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Users {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("createdDate=" + (_createdDate != null ? _createdDate!.format() : "null") + ", ");
    buffer.write("updatedDate=" + (_updatedDate != null ? _updatedDate!.format() : "null") + ", ");
    buffer.write("sellerID=" + "$_sellerID" + ", ");
    buffer.write("settingsID=" + "$_settingsID" + ", ");
    buffer.write("phoneNumber=" + "$_phoneNumber" + ", ");
    buffer.write("profilePicture=" + "$_profilePicture" + ", ");
    buffer.write("token=" + "$_token" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("zipCode=" + "$_zipCode" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("isAdministrator=" + (_isAdministrator != null ? _isAdministrator!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Users copyWith({TemporalDateTime? createdDate, TemporalDateTime? updatedDate, String? sellerID, String? settingsID, String? phoneNumber, String? profilePicture, String? token, String? username, String? zipCode, String? email, bool? isAdministrator}) {
    return Users._internal(
      id: id,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      sellerID: sellerID ?? this.sellerID,
      settingsID: settingsID ?? this.settingsID,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      token: token ?? this.token,
      username: username ?? this.username,
      zipCode: zipCode ?? this.zipCode,
      email: email ?? this.email,
      isAdministrator: isAdministrator ?? this.isAdministrator);
  }
  
  Users.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _createdDate = json['createdDate'] != null ? TemporalDateTime.fromString(json['createdDate']) : null,
      _updatedDate = json['updatedDate'] != null ? TemporalDateTime.fromString(json['updatedDate']) : null,
      _sellerID = json['sellerID'],
      _settingsID = json['settingsID'],
      _phoneNumber = json['phoneNumber'],
      _profilePicture = json['profilePicture'],
      _token = json['token'],
      _username = json['username'],
      _zipCode = json['zipCode'],
      _email = json['email'],
      _isAdministrator = json['isAdministrator'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'createdDate': _createdDate?.format(), 'updatedDate': _updatedDate?.format(), 'sellerID': _sellerID, 'settingsID': _settingsID, 'phoneNumber': _phoneNumber, 'profilePicture': _profilePicture, 'token': _token, 'username': _username, 'zipCode': _zipCode, 'email': _email, 'isAdministrator': _isAdministrator, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'createdDate': _createdDate, 'updatedDate': _updatedDate, 'sellerID': _sellerID, 'settingsID': _settingsID, 'phoneNumber': _phoneNumber, 'profilePicture': _profilePicture, 'token': _token, 'username': _username, 'zipCode': _zipCode, 'email': _email, 'isAdministrator': _isAdministrator, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UsersModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UsersModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CREATEDDATE = QueryField(fieldName: "createdDate");
  static final QueryField UPDATEDDATE = QueryField(fieldName: "updatedDate");
  static final QueryField SELLERID = QueryField(fieldName: "sellerID");
  static final QueryField SETTINGSID = QueryField(fieldName: "settingsID");
  static final QueryField PHONENUMBER = QueryField(fieldName: "phoneNumber");
  static final QueryField PROFILEPICTURE = QueryField(fieldName: "profilePicture");
  static final QueryField TOKEN = QueryField(fieldName: "token");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField ZIPCODE = QueryField(fieldName: "zipCode");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField ISADMINISTRATOR = QueryField(fieldName: "isAdministrator");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Users";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.CREATEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.UPDATEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.SELLERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.SETTINGSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.PHONENUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.PROFILEPICTURE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.TOKEN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.ZIPCODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.ISADMINISTRATOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UsersModelType extends ModelType<Users> {
  const _UsersModelType();
  
  @override
  Users fromJson(Map<String, dynamic> jsonData) {
    return Users.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Users';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Users] in your schema.
 */
@immutable
class UsersModelIdentifier implements ModelIdentifier<Users> {
  final String id;

  /** Create an instance of UsersModelIdentifier using [id] the primary key. */
  const UsersModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'UsersModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UsersModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}