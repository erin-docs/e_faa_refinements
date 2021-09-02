view: e_faa_materialized_view {
  derived_table: {
    materialized_view: yes
    explore_source: ontime {
      column: flight_num {}
      column: carrier {}
      column: arr_date {}
    }
  }
  dimension: flight_num {}
  dimension: carrier {}
  dimension: arr_date {
    type: date
  }
}
