connection: "bq-int-trial-gke-conn"

# Include all view from all folder
include: "/**/*.view.lkml"                # include all views in the viewstry/ folder in this project

# Cache setting
datagroup: tes_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

# Explore setting
persist_with: tes_default_datagroup

explore: viewtry1  {
  join: plant {
    relationship: many_to_one
    sql_on: ${viewtry1.plant}=${plant.plant} ;;
  }
}

explore: plant {}


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
