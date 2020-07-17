
view: flights_base_1 {
  label: "Flights Base 1"
  extension: required
  sql_table_name: flightstats.accidents ;;

  dimension: airport_name {
    label: "Base 1 Name"
    type: string
    sql: ${TABLE}.airport_name ;;
  }
  dimension: airport_code {
    label: "Base 1 Name"
    type: string
    sql: ${TABLE}.airport_code ;;
  }


}

view: flights_base_2 {
  label: "Flights Base 2"
  extension: required
  sql_table_name: flightstats.accidents ;;

  dimension: airport_name {
    label: "Base 2 Name"
    type: string
    sql: ${TABLE}.airport_name ;;
  }
}

view: flights_extended {
  label: "Flights Base 1 Extended"
  extends: [flights_base_1]

  dimension: airport_name {
    label: "Name from Flights Base 1 Extended"
  }
}

view: +flights_extended {
  label: "Flights Refined to Extend Base 2"
  extends: [flights_base_2]

  dimension: airport_name {
  }

  dimension: airport_code {
    label: "Refined dimension from Base 1"
  }


}
