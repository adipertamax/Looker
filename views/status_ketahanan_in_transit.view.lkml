view: ketahanan_in_transit {
sql_table_name: `test_ptpl.STATUS_KETAHANAN`
  ;;

  dimension: category {
    type: string
    sql: ${TABLE}.CATEGORY ;;
    hidden: yes
  }

  dimension: color {
    type: string
    sql: ${TABLE}.COLOR ;;
    hidden: yes
  }

  dimension: condition {
    type: string
    sql: ${TABLE}.CONDITION ;;
    hidden: yes
  }

  dimension: status_in_transit {
    type: string
    sql: ${TABLE}.LABEL ;;
    view_label: "Ketahanan Stock"
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.UNIT ;;
    hidden: yes
  }

  dimension: min {
    type: number
    sql: ${TABLE}.min ;;
    hidden: yes
  }

  dimension: max {
    type: number
    sql: ${TABLE}.max ;;
    hidden: yes
  }

  # dimension: status_ketahanan {
  #   type: string
  #   sql: CASE
  #     WHEN
  #       ketahanan_stock.sum_ketahanan > ${min}
  #       AND ketahanan_stock.sum_ketahanan < ${max}
  #       AND ${category} = ketahanan_stock.material_group_type
  #       THEN ${label}
  #     END
  #   ;;
  # }

  measure: count {
    type: count
    drill_fields: []
  }

  set: details {
    fields: [ketahanan_stock.material_desc, ketahanan_stock.material_group_type, ketahanan_stock.ketahanan_stock,
      ketahanan_stock.in_transit_stock, ketahanan_stock.ketahanan_stock_inc_intransit]
  }
}
