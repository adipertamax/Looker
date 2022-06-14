view: plant {
  sql_table_name: `test_ptpl.PLANT`
    ;;

  dimension: plant {
    type: string
    sql: ${TABLE}.PLANT ;;
  }

  dimension: plant_desc {
    type: string
    sql: ${TABLE}.PLANT_DESC ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
