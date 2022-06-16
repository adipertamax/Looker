view: ketahanan_stock {
  sql_table_name: `int-trial-gke.dm_ptpl.KETAHANAN_STOCK`
    ;;

  dimension: avg_pemakaian_stock {
    type: number
    sql: ${TABLE}.AVG_PEMAKAIAN_STOCK ;;
  }

  dimension: current_stock {
    type: number
    sql: ${TABLE}.CURRENT_STOCK ;;
  }

  dimension: in_transit_stock {
    type: number
    sql: ${TABLE}.IN_TRANSIT_STOCK ;;
  }

  dimension: ketahanan_stock {
    type: number
    sql: ${TABLE}.KETAHANAN_STOCK ;;
  }

  dimension: ketahanan_stock_inc_intransit {
    type: number
    sql: ${TABLE}.KETAHANAN_STOCK_INC_INTRANSIT ;;
  }

  dimension: lead_time {
    type: number
    sql: ${TABLE}.LEAD_TIME ;;
  }

  dimension: material_desc {
    type: string
    sql: ${TABLE}.MATERIAL_DESC ;;
  }

  dimension: material_group_type {
    type: string
    sql: ${TABLE}.MATERIAL_GROUP_TYPE ;;
  }

  dimension: material_number {
    type: string
    sql: ${TABLE}.MATERIAL_NUMBER ;;
  }

  dimension: pemakaian_stock {
    type: number
    sql: ${TABLE}.PEMAKAIAN_STOCK ;;
  }

  dimension: plant {
    type: string
    sql: ${TABLE}.PLANT ;;
  }

  dimension_group: posting {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.POSTING_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
