view: leadtime {
  sql_table_name: `test_ptpl.LEADTIME`
    ;;

  dimension: kimap {
    type: string
    sql: ${TABLE}.KIMAP ;;
  }

  dimension: lead_time__bulan_ {
    type: number
    sql: ${TABLE}.Lead_Time__Bulan_ ;;
  }

  dimension: lead_time__hari_ {
    type: number
    sql: ${TABLE}.Lead_Time__Hari_ ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
