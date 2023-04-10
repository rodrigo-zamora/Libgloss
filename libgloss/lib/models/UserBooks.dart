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


/** This is an auto generated class representing the UserBooks type in your schema. */
@immutable
class UserBooks extends Model {
  static const classType = const _UserBooksModelType();
  final String id;
  final TemporalDateTime? _createdDate;
  final TemporalDateTime? _updatedDate;
  final List<String>? _authors;
  final List<String>? _categories;
  final List<String>? _images;
  final String? _title;
  final int? _latitude;
  final int? _longitude;
  final int? _price;
  final String? _publisher;
  final String? _sellerUUID;
  final String? _thumbnail;
  final String? _isbn;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserBooksModelIdentifier get modelIdentifier {
      return UserBooksModelIdentifier(
        id: id
      );
  }
  
  TemporalDateTime? get createdDate {
    return _createdDate;
  }
  
  TemporalDateTime? get updatedDate {
    return _updatedDate;
  }
  
  List<String>? get authors {
    return _authors;
  }
  
  List<String>? get categories {
    return _categories;
  }
  
  List<String>? get images {
    return _images;
  }
  
  String? get title {
    return _title;
  }
  
  int? get latitude {
    return _latitude;
  }
  
  int? get longitude {
    return _longitude;
  }
  
  int? get price {
    return _price;
  }
  
  String? get publisher {
    return _publisher;
  }
  
  String? get sellerUUID {
    return _sellerUUID;
  }
  
  String? get thumbnail {
    return _thumbnail;
  }
  
  String? get isbn {
    return _isbn;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserBooks._internal({required this.id, createdDate, updatedDate, authors, categories, images, title, latitude, longitude, price, publisher, sellerUUID, thumbnail, isbn, createdAt, updatedAt}): _createdDate = createdDate, _updatedDate = updatedDate, _authors = authors, _categories = categories, _images = images, _title = title, _latitude = latitude, _longitude = longitude, _price = price, _publisher = publisher, _sellerUUID = sellerUUID, _thumbnail = thumbnail, _isbn = isbn, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserBooks({String? id, TemporalDateTime? createdDate, TemporalDateTime? updatedDate, List<String>? authors, List<String>? categories, List<String>? images, String? title, int? latitude, int? longitude, int? price, String? publisher, String? sellerUUID, String? thumbnail, String? isbn}) {
    return UserBooks._internal(
      id: id == null ? UUID.getUUID() : id,
      createdDate: createdDate,
      updatedDate: updatedDate,
      authors: authors != null ? List<String>.unmodifiable(authors) : authors,
      categories: categories != null ? List<String>.unmodifiable(categories) : categories,
      images: images != null ? List<String>.unmodifiable(images) : images,
      title: title,
      latitude: latitude,
      longitude: longitude,
      price: price,
      publisher: publisher,
      sellerUUID: sellerUUID,
      thumbnail: thumbnail,
      isbn: isbn);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserBooks &&
      id == other.id &&
      _createdDate == other._createdDate &&
      _updatedDate == other._updatedDate &&
      DeepCollectionEquality().equals(_authors, other._authors) &&
      DeepCollectionEquality().equals(_categories, other._categories) &&
      DeepCollectionEquality().equals(_images, other._images) &&
      _title == other._title &&
      _latitude == other._latitude &&
      _longitude == other._longitude &&
      _price == other._price &&
      _publisher == other._publisher &&
      _sellerUUID == other._sellerUUID &&
      _thumbnail == other._thumbnail &&
      _isbn == other._isbn;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserBooks {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("createdDate=" + (_createdDate != null ? _createdDate!.format() : "null") + ", ");
    buffer.write("updatedDate=" + (_updatedDate != null ? _updatedDate!.format() : "null") + ", ");
    buffer.write("authors=" + (_authors != null ? _authors!.toString() : "null") + ", ");
    buffer.write("categories=" + (_categories != null ? _categories!.toString() : "null") + ", ");
    buffer.write("images=" + (_images != null ? _images!.toString() : "null") + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("latitude=" + (_latitude != null ? _latitude!.toString() : "null") + ", ");
    buffer.write("longitude=" + (_longitude != null ? _longitude!.toString() : "null") + ", ");
    buffer.write("price=" + (_price != null ? _price!.toString() : "null") + ", ");
    buffer.write("publisher=" + "$_publisher" + ", ");
    buffer.write("sellerUUID=" + "$_sellerUUID" + ", ");
    buffer.write("thumbnail=" + "$_thumbnail" + ", ");
    buffer.write("isbn=" + "$_isbn" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserBooks copyWith({TemporalDateTime? createdDate, TemporalDateTime? updatedDate, List<String>? authors, List<String>? categories, List<String>? images, String? title, int? latitude, int? longitude, int? price, String? publisher, String? sellerUUID, String? thumbnail, String? isbn}) {
    return UserBooks._internal(
      id: id,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      authors: authors ?? this.authors,
      categories: categories ?? this.categories,
      images: images ?? this.images,
      title: title ?? this.title,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      price: price ?? this.price,
      publisher: publisher ?? this.publisher,
      sellerUUID: sellerUUID ?? this.sellerUUID,
      thumbnail: thumbnail ?? this.thumbnail,
      isbn: isbn ?? this.isbn);
  }
  
  UserBooks.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _createdDate = json['createdDate'] != null ? TemporalDateTime.fromString(json['createdDate']) : null,
      _updatedDate = json['updatedDate'] != null ? TemporalDateTime.fromString(json['updatedDate']) : null,
      _authors = json['authors']?.cast<String>(),
      _categories = json['categories']?.cast<String>(),
      _images = json['images']?.cast<String>(),
      _title = json['title'],
      _latitude = (json['latitude'] as num?)?.toInt(),
      _longitude = (json['longitude'] as num?)?.toInt(),
      _price = (json['price'] as num?)?.toInt(),
      _publisher = json['publisher'],
      _sellerUUID = json['sellerUUID'],
      _thumbnail = json['thumbnail'],
      _isbn = json['isbn'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'createdDate': _createdDate?.format(), 'updatedDate': _updatedDate?.format(), 'authors': _authors, 'categories': _categories, 'images': _images, 'title': _title, 'latitude': _latitude, 'longitude': _longitude, 'price': _price, 'publisher': _publisher, 'sellerUUID': _sellerUUID, 'thumbnail': _thumbnail, 'isbn': _isbn, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'createdDate': _createdDate, 'updatedDate': _updatedDate, 'authors': _authors, 'categories': _categories, 'images': _images, 'title': _title, 'latitude': _latitude, 'longitude': _longitude, 'price': _price, 'publisher': _publisher, 'sellerUUID': _sellerUUID, 'thumbnail': _thumbnail, 'isbn': _isbn, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UserBooksModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserBooksModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CREATEDDATE = QueryField(fieldName: "createdDate");
  static final QueryField UPDATEDDATE = QueryField(fieldName: "updatedDate");
  static final QueryField AUTHORS = QueryField(fieldName: "authors");
  static final QueryField CATEGORIES = QueryField(fieldName: "categories");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField LATITUDE = QueryField(fieldName: "latitude");
  static final QueryField LONGITUDE = QueryField(fieldName: "longitude");
  static final QueryField PRICE = QueryField(fieldName: "price");
  static final QueryField PUBLISHER = QueryField(fieldName: "publisher");
  static final QueryField SELLERUUID = QueryField(fieldName: "sellerUUID");
  static final QueryField THUMBNAIL = QueryField(fieldName: "thumbnail");
  static final QueryField ISBN = QueryField(fieldName: "isbn");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserBooks";
    modelSchemaDefinition.pluralName = "UserBooks";
    
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
      key: UserBooks.CREATEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.UPDATEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.AUTHORS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.CATEGORIES,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.IMAGES,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.LATITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.LONGITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.PRICE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.PUBLISHER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.SELLERUUID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.THUMBNAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserBooks.ISBN,
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

class _UserBooksModelType extends ModelType<UserBooks> {
  const _UserBooksModelType();
  
  @override
  UserBooks fromJson(Map<String, dynamic> jsonData) {
    return UserBooks.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UserBooks';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UserBooks] in your schema.
 */
@immutable
class UserBooksModelIdentifier implements ModelIdentifier<UserBooks> {
  final String id;

  /** Create an instance of UserBooksModelIdentifier using [id] the primary key. */
  const UserBooksModelIdentifier({
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
  String toString() => 'UserBooksModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserBooksModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}