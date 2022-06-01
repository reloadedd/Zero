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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _username;
  final String? _profilePictureUrl;
  final String? _status;
  final TemporalDateTime? _createdOn;
  final List<Chat>? _chats;
  final List<Message>? _Messages;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get profilePictureUrl {
    return _profilePictureUrl;
  }
  
  String? get status {
    return _status;
  }
  
  TemporalDateTime? get createdOn {
    return _createdOn;
  }
  
  List<Chat>? get chats {
    return _chats;
  }
  
  List<Message>? get Messages {
    return _Messages;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, required username, profilePictureUrl, status, createdOn, chats, Messages, createdAt, updatedAt}): _username = username, _profilePictureUrl = profilePictureUrl, _status = status, _createdOn = createdOn, _chats = chats, _Messages = Messages, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String username, String? profilePictureUrl, String? status, TemporalDateTime? createdOn, List<Chat>? chats, List<Message>? Messages}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      profilePictureUrl: profilePictureUrl,
      status: status,
      createdOn: createdOn,
      chats: chats != null ? List<Chat>.unmodifiable(chats) : chats,
      Messages: Messages != null ? List<Message>.unmodifiable(Messages) : Messages);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _username == other._username &&
      _profilePictureUrl == other._profilePictureUrl &&
      _status == other._status &&
      _createdOn == other._createdOn &&
      DeepCollectionEquality().equals(_chats, other._chats) &&
      DeepCollectionEquality().equals(_Messages, other._Messages);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("profilePictureUrl=" + "$_profilePictureUrl" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? username, String? profilePictureUrl, String? status, TemporalDateTime? createdOn, List<Chat>? chats, List<Message>? Messages}) {
    return User._internal(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      status: status ?? this.status,
      createdOn: createdOn ?? this.createdOn,
      chats: chats ?? this.chats,
      Messages: Messages ?? this.Messages);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _profilePictureUrl = json['profilePictureUrl'],
      _status = json['status'],
      _createdOn = json['createdOn'] != null ? TemporalDateTime.fromString(json['createdOn']) : null,
      _chats = json['chats'] is List
        ? (json['chats'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Chat.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _Messages = json['Messages'] is List
        ? (json['Messages'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Message.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'profilePictureUrl': _profilePictureUrl, 'status': _status, 'createdOn': _createdOn?.format(), 'chats': _chats?.map((Chat? e) => e?.toJson()).toList(), 'Messages': _Messages?.map((Message? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField PROFILEPICTUREURL = QueryField(fieldName: "profilePictureUrl");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static final QueryField CHATS = QueryField(
    fieldName: "chats",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Chat).toString()));
  static final QueryField MESSAGES = QueryField(
    fieldName: "Messages",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Message).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
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
      key: User.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFILEPICTUREURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.CHATS,
      isRequired: false,
      ofModelName: (Chat).toString(),
      associatedKey: Chat.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.MESSAGES,
      isRequired: false,
      ofModelName: (Message).toString(),
      associatedKey: Message.SENDERID
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

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}