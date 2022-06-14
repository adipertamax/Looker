connection: "bq-int-trial-gke-conn"

# include all the views
include: "/views/**/*.view"

datagroup: tes_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
##tes

#tes kedua
persist_with: tes_default_datagroup

explore: leadtime {}

explore: mard {}

explore: kimap_category {}

explore: status_ketahanan {}

explore: mseg {}

explore: makt {}

explore: mara {}

explore: rencana_produksi {}

explore: plant {}

explore: marc {}
