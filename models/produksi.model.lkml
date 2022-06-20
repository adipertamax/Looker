connection: "bq-int-trial-gke-conn"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
 include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


explore: ketahanan_stok {
  view_name: ketahanan_stock

  join: plant {
    type: left_outer
    view_label: "Plant"
    relationship: many_to_one
    sql_on: ${plant.plant} = ${ketahanan_stock.plant} ;;
  }

  join: status_ketahanan {
    type: left_outer
    relationship: many_to_one
    sql_on: ${status_ketahanan.category} = ${ketahanan_stock.material_group_type}
            AND ${ketahanan_stock.ketahanan_stock} > ${status_ketahanan.min}
            AND ${ketahanan_stock.ketahanan_stock} <= (${status_ketahanan.max}+1)
      ;;

  }



}
explore: RealisasiVSTarget {
  view_name: RealisasiVSTarget

  join: plant {
    type: left_outer
    view_label: "Plant"
    relationship: many_to_one
    sql_on: ${plant.plant} = ${RealisasiVSTarget.plant} ;;
  }

  join: rencana_produksi {
    type: left_outer
    view_label: "rencana_produksi"
    relationship: many_to_one
    sql_on: ${rencana_produksi.month} = cast (${RealisasiVSTarget.Month_Produksi} as string)
            and  ${rencana_produksi.year}=cast (${RealisasiVSTarget.Year_Produksi} as string)
            and ${rencana_produksi.plant}= ${RealisasiVSTarget.plant}
            and ${rencana_produksi.kimap}= ${RealisasiVSTarget.material_number}
    ;;
  }
}

# VISUALIZATION AND FORMATTING PARAMETERS
map_layer: region_indonesia {
  url: "https://github.com/yusufsyaifudin/wilayah-indonesia/blob/54c4f4003292c39e5033ccc3b4df886bafa42046/data/list_of_area/regencies.json"
  property_key: "map_ptpl"
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
