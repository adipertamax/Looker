connection: "bq-int-trial-gke-conn"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


explore: realisasi_produksi {
  view_name: realisasi_produksi

  join: plant {
    type: left_outer
    view_label: "Plant"
    relationship: many_to_one
    sql_on: ${plant.plant} = ${realisasi_produksi.plant} ;;
  }

  join: rencana_produksi {
    type: left_outer
    view_label: "rencana_produksi"
    relationship: many_to_one
    sql_on: ${rencana_produksi.month} = ${realisasi_produksi.Month_Produksi}
            and  ${rencana_produksi.year}=${realisasi_produksi.Year_Produksi}
            and ${rencana_produksi.plant}= ${realisasi_produksi.plant}
            and ${rencana_produksi.kimap}= ${realisasi_produksi.material_number}
    ;;
    }
  }

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
