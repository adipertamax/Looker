view: ketahanan_stock {
  sql_table_name: `int-trial-gke.dm_ptpl.KETAHANAN_STOCK`
    ;;

  dimension: material_plant_key {
    primary_key: yes
    type: string
    hidden: yes
    sql: CONCAT(${material_number}, ${plant});;
  }

  dimension: avg_pemakaian_stock {
    type: number
    sql: ${TABLE}.AVG_PEMAKAIAN_STOCK ;;
    value_format_name: decimal_2
  }

  dimension: current_stock {
    type: number
    sql: ${TABLE}.CURRENT_STOCK ;;
    value_format_name: decimal_2
  }

  dimension: in_transit_stock {
    type: number
    sql: ${TABLE}.IN_TRANSIT_STOCK ;;
    value_format_name: decimal_2
  }

  dimension: ketahanan_stock {
    type: number
    sql: ${TABLE}.KETAHANAN_STOCK ;;
    value_format_name: decimal_2
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
    label: "Category"
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
    hidden: yes
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

#tambahan
  dimension: category_group  {
    type: string
    case: {
      when: {
        sql: ${TABLE}.material_group_type = 'ADDITIVE' ;;
        label: "Status"
      }
      when: {
        sql: ${TABLE}.advertising_channel = 'PACKAGING' ;;
        label: "Status"
      }
      when: {
        sql: ${TABLE}.advertising_channel = 'OIL BASE' ;;
        label: "Status LBO"
      }
     #else: "unknown"
    }

  }
  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_ketahanan {
    type: sum
    sql: ${ketahanan_stock};;
    drill_fields: []
  }

  measure: count_material {
    type: count_distinct
    sql: ${material_number} ;;
    drill_fields: [details*]
    value_format_name: decimal_2
  }

  set: details {
    fields: [material_desc, material_group_type, ketahanan_stock, avg_pemakaian_stock, current_stock, in_transit_stock, ketahanan_stock_inc_intransit]
  }
}
