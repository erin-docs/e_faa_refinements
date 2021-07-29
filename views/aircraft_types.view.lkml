view: aircraft_types {
  sql_table_name: flightstats.aircraft_types ;;
  drill_fields: [aircraft_type_id]

  dimension: aircraft_type_id {
    primary_key: yes
    type: yesno
    sql: ${TABLE}.aircraft_type_id ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  measure: count {
    type: count
  }
}

view: +aircraft_types {
  label: "refined aircraft types"
}
