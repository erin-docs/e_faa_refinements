connection: "faa"

# include all the views
include: "/views/**/*.view"

datagroup: e_faa_refinements_default_datagroup {
  sql_trigger: SELECT DATE(NOW());;
  max_cache_age: "1 hour"
}

persist_with: e_faa_refinements_default_datagroup

explore: flights {}

explore: e_faa_incr_pdt {}
explore: aircraft {
  view_name:aircraft
  join: aircraft_types {
    type: left_outer
    sql_on: ${aircraft.aircraft_type_id} =
    ${aircraft_types.aircraft_type_id} ;;
    relationship: many_to_one
  }

  join: aircraft_engine_types {
    type: left_outer
    sql_on: ${aircraft.aircraft_engine_type_id} =
    ${aircraft_engine_types.aircraft_engine_type_id} ;;
    relationship: many_to_one
  }
}

explore: aircraft_extended {
  extends: [aircraft]
  label: "Aircraft Extended"
}



# explore: +aircraft {
#   label: "Aircraft Simplified"
#   fields: [aircraft.aircraft_serial,
#     aircraft.name, aircraft.count]
# }





explore: aircraft_engine_types {}

explore: aircraft_engines {
  join: aircraft_engine_types {
    type: left_outer
    sql_on: ${aircraft_engines.aircraft_engine_type_id} = ${aircraft_engine_types.aircraft_engine_type_id} ;;
    relationship: many_to_one
  }
}

explore: aircraft_models {
  join: aircraft_types {
    type: left_outer
    sql_on: ${aircraft_models.aircraft_type_id} = ${aircraft_types.aircraft_type_id} ;;
    relationship: many_to_one
  }

  join: aircraft_engine_types {
    type: left_outer
    sql_on: ${aircraft_models.aircraft_engine_type_id} = ${aircraft_engine_types.aircraft_engine_type_id} ;;
    relationship: many_to_one
  }
}

explore: aircraft_types {}

explore: airport_remarks {}

explore: airports {}

explore: carriers {}

explore: exceptions {}

explore: ontime {}

explore: states {}

explore: zipcodes {}


view: +flights {
  dimension: air_carrier {
    type: string
    sql: ${TABLE}.air_carrier ;;
  }
}

view: +flights {
  label: "refined flights"
  final: yes
  }
