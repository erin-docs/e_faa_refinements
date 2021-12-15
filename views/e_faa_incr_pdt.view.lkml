view: e_faa_incr_pdt {
  derived_table: {
    datagroup_trigger: e_faa_refinements_default_datagroup
    increment_key: "event_month"
    indexes: ["id"]
    explore_source: flights {
      column: event_month {}
      column: count {}
      column: air_carrier {}
      column: id {}
    }
  }
  dimension: id {
    primary_key: yes
    type: number
  }
  dimension: event_month {
    type: date_month
  }
  dimension: count {
    type: number
  }
  dimension: air_carrier {}
}
