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


/** This is an auto generated class representing the Book type in your schema. */
@immutable
class Book extends Model {
  static const classType = const _BookModelType();
  final String id;
  final TemporalDateTime? _createdDate;
  final TemporalDateTime? _updatedDat;
  final String? _title;
  final String? _subtitle;
  final int? _rating;
  final String? _thumbnail;
  final String? _language;
  final String? _isbn;
  final List<String>? _authors;
  final String? _publisher;
  final List<String>? _categories;
  final String? _description;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  BookModelIdentifier get modelIdentifier {
      return BookModelIdentifier(
        id: id
      );
  }
  
  TemporalDateTime? get createdDate {
    return _createdDate;
  }
  
  TemporalDateTime? get updatedDat {
    return _updatedDat;
  }
  
  String? get title {
    return _title;
  }
  
  String? get subtitle {
    return _subtitle;
  }
  
  int? get rating {
    return _rating;
  }
  
  String? get thumbnail {
    return _thumbnail;
  }
  
  String? get language {
    return _language;
  }
  
  String? get isbn {
    return _isbn;
  }
  
  List<String>? get authors {
    return _authors;
  }
  
  String? get publisher {
    return _publisher;
  }
  
  List<String>? get categories {
    return _categories;
  }
  
  String? get description {
    return _description;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Book._internal({required this.id, createdDate, updatedDat, title, subtitle, rating, thumbnail, language, isbn, authors, publisher, categories, description, createdAt, updatedAt}): _createdDate = createdDate, _updatedDat = updatedDat, _title = title, _subtitle = subtitle, _rating = rating, _thumbnail = thumbnail, _language = language, _isbn = isbn, _authors = authors, _publisher = publisher, _categories = categories, _description = description, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Book({String? id, TemporalDateTime? createdDate, TemporalDateTime? updatedDat, String? title, String? subtitle, int? rating, String? thumbnail, String? language, String? isbn, List<String>? authors, String? publisher, List<String>? categories, String? description}) {
    return Book._internal(
      id: id == null ? UUID.getUUID() : id,
      createdDate: createdDate,
      updatedDat: updatedDat,
      title: title,
      subtitle: subtitle,
      rating: rating,
      thumbnail: thumbnail,
      language: language,
      isbn: isbn,
      authors: authors != null ? List<String>.unmodifiable(authors) : authors,
      publisher: publisher,
      categories: categories != null ? List<String>.unmodifiable(categories) : categories,
      description: description);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Book &&
      id == other.id &&
      _createdDate == other._createdDate &&
      _updatedDat == other._updatedDat &&
      _title == other._title &&
      _subtitle == other._subtitle &&
      _rating == other._rating &&
      _thumbnail == other._thumbnail &&
      _language == other._language &&
      _isbn == other._isbn &&
      DeepCollectionEquality().equals(_authors, other._authors) &&
      _publisher == other._publisher &&
      DeepCollectionEquality().equals(_categories, other._categories) &&
      _description == other._description;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Book {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("createdDate=" + (_createdDate != null ? _createdDate!.format() : "null") + ", ");
    buffer.write("updatedDat=" + (_updatedDat != null ? _updatedDat!.format() : "null") + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("subtitle=" + "$_subtitle" + ", ");
    buffer.write("rating=" + (_rating != null ? _rating!.toString() : "null") + ", ");
    buffer.write("thumbnail=" + "$_thumbnail" + ", ");
    buffer.write("language=" + "$_language" + ", ");
    buffer.write("isbn=" + "$_isbn" + ", ");
    buffer.write("authors=" + (_authors != null ? _authors!.toString() : "null") + ", ");
    buffer.write("publisher=" + "$_publisher" + ", ");
    buffer.write("categories=" + (_categories != null ? _categories!.toString() : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Book copyWith({TemporalDateTime? createdDate, TemporalDateTime? updatedDat, String? title, String? subtitle, int? rating, String? thumbnail, String? language, String? isbn, List<String>? authors, String? publisher, List<String>? categories, String? description}) {
    return Book._internal(
      id: id,
      createdDate: createdDate ?? this.createdDate,
      updatedDat: updatedDat ?? this.updatedDat,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      rating: rating ?? this.rating,
      thumbnail: thumbnail ?? this.thumbnail,
      language: language ?? this.language,
      isbn: isbn ?? this.isbn,
      authors: authors ?? this.authors,
      publisher: publisher ?? this.publisher,
      categories: categories ?? this.categories,
      description: description ?? this.description);
  }
  
  Book.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _createdDate = json['createdDate'] != null ? TemporalDateTime.fromString(json['createdDate']) : null,
      _updatedDat = json['updatedDat'] != null ? TemporalDateTime.fromString(json['updatedDat']) : null,
      _title = json['title'],
      _subtitle = json['subtitle'],
      _rating = (json['rating'] as num?)?.toInt(),
      _thumbnail = json['thumbnail'],
      _language = json['language'],
      _isbn = json['isbn'],
      _authors = json['authors']?.cast<String>(),
      _publisher = json['publisher'],
      _categories = json['categories']?.cast<String>(),
      _description = json['description'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'createdDate': _createdDate?.format(), 'updatedDat': _updatedDat?.format(), 'title': _title, 'subtitle': _subtitle, 'rating': _rating, 'thumbnail': _thumbnail, 'language': _language, 'isbn': _isbn, 'authors': _authors, 'publisher': _publisher, 'categories': _categories, 'description': _description, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'createdDate': _createdDate, 'updatedDat': _updatedDat, 'title': _title, 'subtitle': _subtitle, 'rating': _rating, 'thumbnail': _thumbnail, 'language': _language, 'isbn': _isbn, 'authors': _authors, 'publisher': _publisher, 'categories': _categories, 'description': _description, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<BookModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<BookModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CREATEDDATE = QueryField(fieldName: "createdDate");
  static final QueryField UPDATEDDAT = QueryField(fieldName: "updatedDat");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField SUBTITLE = QueryField(fieldName: "subtitle");
  static final QueryField RATING = QueryField(fieldName: "rating");
  static final QueryField THUMBNAIL = QueryField(fieldName: "thumbnail");
  static final QueryField LANGUAGE = QueryField(fieldName: "language");
  static final QueryField ISBN = QueryField(fieldName: "isbn");
  static final QueryField AUTHORS = QueryField(fieldName: "authors");
  static final QueryField PUBLISHER = QueryField(fieldName: "publisher");
  static final QueryField CATEGORIES = QueryField(fieldName: "categories");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Book";
    modelSchemaDefinition.pluralName = "Books";
    
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
      key: Book.CREATEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.UPDATEDDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.SUBTITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.RATING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.THUMBNAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.LANGUAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.ISBN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.AUTHORS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.PUBLISHER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.CATEGORIES,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Book.DESCRIPTION,
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

class _BookModelType extends ModelType<Book> {
  const _BookModelType();
  
  @override
  Book fromJson(Map<String, dynamic> jsonData) {
    return Book.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Book';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Book] in your schema.
 */
@immutable
class BookModelIdentifier implements ModelIdentifier<Book> {
  final String id;

  /** Create an instance of BookModelIdentifier using [id] the primary key. */
  const BookModelIdentifier({
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
  String toString() => 'BookModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is BookModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}