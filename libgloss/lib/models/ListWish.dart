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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ListWish type in your schema. */
@immutable
class ListWish extends Model {
  static const classType = const _ListWishModelType();
  final String id;
  final List<String>? _Tracking;
  final String? _Wish;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ListWishModelIdentifier get modelIdentifier {
      return ListWishModelIdentifier(
        id: id
      );
  }
  
  List<String>? get Tracking {
    return _Tracking;
  }
  
  String? get Wish {
    return _Wish;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ListWish._internal({required this.id, Tracking, Wish, createdAt, updatedAt}): _Tracking = Tracking, _Wish = Wish, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ListWish({String? id, List<String>? Tracking, String? Wish}) {
    return ListWish._internal(
      id: id == null ? UUID.getUUID() : id,
      Tracking: Tracking != null ? List<String>.unmodifiable(Tracking) : Tracking,
      Wish: Wish);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListWish &&
      id == other.id &&
      DeepCollectionEquality().equals(_Tracking, other._Tracking) &&
      _Wish == other._Wish;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ListWish {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("Tracking=" + (_Tracking != null ? _Tracking!.toString() : "null") + ", ");
    buffer.write("Wish=" + "$_Wish" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ListWish copyWith({List<String>? Tracking, String? Wish}) {
    return ListWish._internal(
      id: id,
      Tracking: Tracking ?? this.Tracking,
      Wish: Wish ?? this.Wish);
  }
  
  ListWish.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _Tracking = json['Tracking']?.cast<String>(),
      _Wish = json['Wish'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'Tracking': _Tracking, 'Wish': _Wish, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'Tracking': _Tracking, 'Wish': _Wish, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<ListWishModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<ListWishModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TRACKING = QueryField(fieldName: "Tracking");
  static final QueryField WISH = QueryField(fieldName: "Wish");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ListWish";
    modelSchemaDefinition.pluralName = "ListWishes";
    
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
      key: ListWish.TRACKING,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ListWish.WISH,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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

class _ListWishModelType extends ModelType<ListWish> {
  const _ListWishModelType();
  
  @override
  ListWish fromJson(Map<String, dynamic> jsonData) {
    return ListWish.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'ListWish';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [ListWish] in your schema.
 */
@immutable
class ListWishModelIdentifier implements ModelIdentifier<ListWish> {
  final String id;

  /** Create an instance of ListWishModelIdentifier using [id] the primary key. */
  const ListWishModelIdentifier({
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
  String toString() => 'ListWishModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ListWishModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}