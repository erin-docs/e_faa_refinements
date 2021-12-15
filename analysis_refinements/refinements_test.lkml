include: "/models/e_faa_refinements.model.lkml"
include: "/views/flights.view.lkml"
include: "/views/ontime.view.lkml"

explore: +flights {
  join: distance_stats {
    relationship: one_to_one
    type: cross
  }
}

view: distance_stats {
  derived_table: {
    explore_source: flights {
      bind_all_filters: yes
      column: distance_avg {field:flights.distance_avg}
      column: distance_stddev {field:flights.distance_stddev}
    }
  }
  dimension: avg {
    type:number
    sql: CAST(${TABLE}.distance_avg as INT64) ;;
  }
  dimension: stddev {
    type:number
    sql: CAST(${TABLE}.distance_stddev as INT64) ;;
  }
  dimension: distance_auto_tier {
    sql:
      CASE
        WHEN ${ontime.distance} < ${avg} + ${stddev} * -2
          THEN CONCAT('T00 (-inf,', CAST(${avg} + ${stddev} * -2 AS STRING),')')
        WHEN ${ontime.distance} < ${avg} + ${stddev} * -1
          THEN CONCAT('T01 [', CAST(${avg} + ${stddev} * -2 AS STRING),',',
                CAST(${avg} + ${stddev} * -1 AS STRING),')')
        WHEN ${ontime.distance} < ${avg} + ${stddev} * 0
          THEN CONCAT('T02 [', CAST(${avg} + ${stddev} * -1 AS STRING),',',
                CAST(${avg} + ${stddev} * 0 AS STRING),')')
        WHEN ${ontime.distance} < ${avg} + ${stddev} * 1
          THEN CONCAT('T03 [', CAST(${avg} + ${stddev} * 0 AS STRING),',',
                CAST(${avg} + ${stddev} * 1 AS STRING),')')
        WHEN ${ontime.distance} < ${avg} + ${stddev} * 2
          THEN CONCAT('T04 [', CAST(${avg} + ${stddev} * 1 AS STRING),',',
                CAST(${avg} + ${stddev} * 2 AS STRING),')')
        WHEN ${ontime.distance} >= ${avg} + ${stddev} * 2
          THEN CONCAT('T05 [', CAST(${avg} + ${stddev} * 2 AS STRING),',',
                'inf',')')
        ELSE
          'yea'
      END
    ;;
  }
}
view: +flights {
  measure: distance_avg {
    type: average
    sql: ${TABLE}.distance ;;
  }
  measure: distance_stddev {
    type: number
    sql: STDDEV(${TABLE}.distance) ;;
  }
  dimension: distance_tiered2 {
    type: tier
    sql: ${TABLE}.distance ;;
    tiers: [500,1300]
  }
}
