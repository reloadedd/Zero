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


/** This is an auto generated class representing the Message type in your schema. */
@immutable
class Message extends Model {
  static const classType = const _MessageModelType();
  final String id;
  final String? _content;
  final bool? _seenByReceiver;
  final String? _receiverID;
  final String? _senderID;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get content {
    return _content;
  }
  
  bool? get seenByReceiver {
    return _seenByReceiver;
  }
  
  String get receiverID {
    try {
      return _receiverID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get senderID {
    try {
      return _senderID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Message._internal({required this.id, content, seenByReceiver, required receiverID, required senderID, createdAt, updatedAt}): _content = content, _seenByReceiver = seenByReceiver, _receiverID = receiverID, _senderID = senderID, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Message({String? id, String? content, bool? seenByReceiver, required String receiverID, required String senderID}) {
    return Message._internal(
      id: id == null ? UUID.getUUID() : id,
      content: content,
      seenByReceiver: seenByReceiver,
      receiverID: receiverID,
      senderID: senderID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
      id == other.id &&
      _content == other._content &&
      _seenByReceiver == other._seenByReceiver &&
      _receiverID == other._receiverID &&
      _senderID == other._senderID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Message {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("seenByReceiver=" + (_seenByReceiver != null ? _seenByReceiver!.toString() : "null") + ", ");
    buffer.write("receiverID=" + "$_receiverID" + ", ");
    buffer.write("senderID=" + "$_senderID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Message copyWith({String? id, String? content, bool? seenByReceiver, String? receiverID, String? senderID}) {
    return Message._internal(
      id: id ?? this.id,
      content: content ?? this.content,
      seenByReceiver: seenByReceiver ?? this.seenByReceiver,
      receiverID: receiverID ?? this.receiverID,
      senderID: senderID ?? this.senderID);
  }
  
  Message.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _content = json['content'],
      _seenByReceiver = json['seenByReceiver'],
      _receiverID = json['receiverID'],
      _senderID = json['senderID'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'content': _content, 'seenByReceiver': _seenByReceiver, 'receiverID': _receiverID, 'senderID': _senderID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "message.id");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField SEENBYRECEIVER = QueryField(fieldName: "seenByReceiver");
  static final QueryField RECEIVERID = QueryField(fieldName: "receiverID");
  static final QueryField SENDERID = QueryField(fieldName: "senderID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Message";
    modelSchemaDefinition.pluralName = "Messages";
    
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
      key: Message.CONTENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Message.SEENBYRECEIVER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Message.RECEIVERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Message.SENDERID,
      isRequired: true,
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

class _MessageModelType extends ModelType<Message> {
  const _MessageModelType();
  
  @override
  Message fromJson(Map<String, dynamic> jsonData) {
    return Message.fromJson(jsonData);
  }
}