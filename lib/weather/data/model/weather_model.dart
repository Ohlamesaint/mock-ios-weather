import 'package:json_annotation/json_annotation.dart'
    show JsonKey, JsonSerializable;

@JsonSerializable()
class WeatherModel {
  final String? success;
  final Result? result;
  final Record? records;

  WeatherModel({
    required this.success,
    required this.result,
    required this.records,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      success: json['success'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      records: json['records'] == null
          ? null
          : Record.fromJson(json['records'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result?.toJson(),
      'records': records?.toJson(),
    };
  }

  @override
  String toString() {
    return 'WeatherModel{success: $success, result: $result, records: $records}';
  }
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'resource_id')
  final String? resourceId;
  final List<Field>? fields;

  Result({
    required this.resourceId,
    required this.fields,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      resourceId: json['resource_id'] as String?,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resource_id': resourceId,
      'fields': fields?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Result{resourceId: $resourceId, fields: $fields}';
  }
}

class Field {
  final String? id;
  final String? type;

  Field({
    required this.id,
    required this.type,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'Field{id: $id, type: $type}';
  }
}

class Record {
  final String? datasetDescription;
  final List<Location>? location;

  Record({
    required this.datasetDescription,
    required this.location,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      datasetDescription: json['datasetDescription'] as String?,
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datasetDescription': datasetDescription,
      'location': location?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Record{datasetDescription: $datasetDescription, location: $location}';
  }
}

class Location {
  final String? locationName;
  final List<WeatherElement>? weatherElement;

  Location({
    required this.locationName,
    required this.weatherElement,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationName: json['locationName'] as String?,
      weatherElement: (json['weatherElement'] as List<dynamic>?)
          ?.map((e) => WeatherElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationName': locationName,
      'weatherElement': weatherElement?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Location{locationName: $locationName, weatherElement: $weatherElement}';
  }
}

class WeatherElement {
  final String? elementName;
  final List<Time>? time;

  WeatherElement({
    required this.elementName,
    required this.time,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) {
    return WeatherElement(
      elementName: json['elementName'] as String?,
      time: (json['time'] as List<dynamic>?)
          ?.map((e) => Time.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'elementName': elementName,
      'time': time?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'WeatherElement{elementName: $elementName, time: $time}';
  }
}

class Time {
  final DateTime? startTime;
  final DateTime? endTime;
  final Parameter? parameter;

  Time({
    required this.startTime,
    required this.endTime,
    required this.parameter,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      parameter: json['parameter'] == null
          ? null
          : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'parameter': parameter?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Time{startTime: $startTime, endTime: $endTime, parameter: $parameter}';
  }
}

class Parameter {
  final String? parameterName;
  final String? parameterValue;
  final String? parameterUnit;

  Parameter({
    required this.parameterName,
    required this.parameterValue,
    required this.parameterUnit,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      parameterName: json['parameterName'] as String?,
      parameterValue: json['parameterValue'] as String?,
      parameterUnit: json['parameterUnit'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parameterName': parameterName,
      'parameterValue': parameterValue,
      'parameterUnit': parameterUnit,
    };
  }

  @override
  String toString() {
    return 'Parameter{parameterName: $parameterName, parameterValue: $parameterValue, parameterUnit: $parameterUnit}';
  }
}
