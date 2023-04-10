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


/** This is an auto generated class representing the TrackingListItem type in your schema. */
@immutable
class TrackingListItem extends Model {
  static const classType = const _TrackingListItemModelType();
  final String id;
  final List<String>? _authors;
  final String? _isbn;
  final int? _price;
  final String? _store;
  final String? _thumbnail;
  final int? _time;
  final String? _title;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TrackingListItemModelIdentifier get modelIdentifier {
      return TrackingListItemModelIdentifier(
        id: id
      );
  }
  
  List<String>? get authors {
    return _authors;
  }
  
  String? get isbn {
    return _isbn;
  }
  
  int? get price {
    return _price;
  }
  
  String? get store {
    return _store;
  }
  
  String? get thumbnail {
    return _thumbnail;
  }
  
  int? get time {
    return _time;
  }
  
  String? get title {
    return _title;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const TrackingListItem._internal({required this.id, authors, isbn, price, store, thumbnail, time, title, createdAt, updatedAt}): _authors = authors, _isbn = isbn, _price = price, _store = store, _thumbnail = thumbnail, _time = time, _title = title, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory TrackingListItem({String? id, List<String>? authors, String? isbn, int? price, String? store, String? thumbnail, int? time, String? title}) {
    return TrackingListItem._internal(
      id: id == null ? UUID.getUUID() : id,
      authors: authors != null ? List<String>.unmodifiable(authors) : authors,
      isbn: isbn,
      price: price,
      store: store,
      thumbnail: thumbnail,
      time: time,
      title: title);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrackingListItem &&
      id == other.id &&
      DeepCollectionEquality().equals(_authors, other._authors) &&
      _isbn == other._isbn &&
      _price == other._price &&
      _store == other._store &&
      _thumbnail == other._thumbnail &&
      _time == other._time &&
      _title == other._title;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TrackingListItem {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("authors=" + (_authors != null ? _authors!.toString() : "null") + ", ");
    buffer.write("isbn=" + "$_isbn" + ", ");
    buffer.write("price=" + (_price != null ? _price!.toString() : "null") + ", ");
    buffer.write("store=" + "$_store" + ", ");
    buffer.write("thumbnail=" + "$_thumbnail" + ", ");
    buffer.write("time=" + (_time != null ? _time!.toString() : "null") + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TrackingListItem copyWith({List<String>? authors, String? isbn, int? price, String? store, String? thumbnail, int? time, String? title}) {
    return TrackingListItem._internal(
      id: id,
      authors: authors ?? this.authors,
      isbn: isbn ?? this.isbn,
      price: price ?? this.price,
      store: store ?? this.store,
      thumbnail: thumbnail ?? this.thumbnail,
      time: time ?? this.time,
      title: title ?? this.title);
  }
  
  TrackingListItem.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _authors = json['authors']?.cast<String>(),
      _isbn = json['isbn'],
      _price = (json['price'] as num?)?.toInt(),
      _store = json['store'],
      _thumbnail = json['thumbnail'],
      _time = (json['time'] as num?)?.toInt(),
      _title = json['title'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'authors': _authors, 'isbn': _isbn, 'price': _price, 'store': _store, 'thumbnail': _thumbnail, 'time': _time, 'title': _title, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'authors': _authors, 'isbn': _isbn, 'price': _price, 'store': _store, 'thumbnail': _thumbnail, 'time': _time, 'title': _title, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<TrackingListItemModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<TrackingListItemModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField AUTHORS = QueryField(fieldName: "authors");
  static final QueryField ISBN = QueryField(fieldName: "isbn");
  static final QueryField PRICE = QueryField(fieldName: "price");
  static final QueryField STORE = QueryField(fieldName: "store");
  static final QueryField THUMBNAIL = QueryField(fieldName: "thumbnail");
  static final QueryField TIME = QueryField(fieldName: "time");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TrackingListItem";
    modelSchemaDefinition.pluralName = "TrackingListItems";
    
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
      key: TrackingListItem.AUTHORS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TrackingListItem.ISBN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TrackingListItem.PRICE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TrackingListItem.STORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TrackingListItem.THUMBNAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TrackingListItem.TIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: TrackingListItem.TITLE,
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

class _TrackingListItemModelType extends ModelType<TrackingListItem> {
  const _TrackingListItemModelType();
  
  @override
  TrackingListItem fromJson(Map<String, dynamic> jsonData) {
    return TrackingListItem.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'TrackingListItem';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [TrackingListItem] in your schema.
 */
@immutable
class TrackingListItemModelIdentifier implements ModelIdentifier<TrackingListItem> {
  final String id;

  /** Create an instance of TrackingListItemModelIdentifier using [id] the primary key. */
  const TrackingListItemModelIdentifier({
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
  String toString() => 'TrackingListItemModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TrackingListItemModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}