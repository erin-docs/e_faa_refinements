connection: "faa"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


datagroup: e_faa_refinements_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

  explore: all_flights {
    view_name: flights
  }

