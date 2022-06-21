view: viewtry1 {
  sql_table_name: dm_ptpl.KETAHANAN_STOCK ;;

  dimension_group: posting_date{
    type :  time
    timeframes: [date,week, month, year]
    datatype: date
    sql: ${TABLE}.POSTING_DATE ;;
  }

  dimension: material_num {
    type: string
    sql: ${TABLE}.MATERIAL_NUMBER ;;
  }

  dimension: plant {
    type: string
    sql: ${TABLE}.PLANT ;;
  }

  dimension: material_num_plant_key {
    primary_key: yes
    label : "key"
    type: string
    sql: CONCAT(${material_num},${plant}) ;;
  }

  dimension: material_desc {
    type: string
    sql: ${TABLE}.MATERIAL_DESC ;;
  }

  dimension: material_group_type {
    label: "Material Category"
    type: string
    sql: ${TABLE}.MATERIAL_GROUP_TYPE ;;
  }

  dimension: current_stock {
    type: number
    sql: ${TABLE}.CURRENT_STOCK;;
    value_format: "0.00"
  }

  dimension: in_transit_stock {
    type: number
    sql: ${TABLE}.IN_TRANSIT_STOCK;;
    value_format: "0.00"
  }

  dimension: pemakaian_stock {
    type: number
    sql: ${TABLE}.PEMAKAIAN_STOCK;;
    value_format: "0.00"
  }

  dimension: avg_pemakaian_stock {
    type: number
    sql: ${TABLE}.AVG_PEMAKAIAN_STOCK;;
    value_format: "0.00"
  }

  dimension: ketahanan_stock {
    type: number
    sql: ${TABLE}.KETAHANAN_STOCK;;
    value_format: "0.00"
  }

  dimension: ketahanan_stock_inc_transit {
    type: number
    sql: ${TABLE}.KETAHANAN_STOCK_INC_TRANSIT;;
    value_format: "0.00"
  }

  dimension: Leadtime {
    type: number
    sql: ${TABLE}.LEAD_TIME;;
  }

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: viewtry1 {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
