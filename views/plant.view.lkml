view: plant {
  sql_table_name: `test_ptpl.PLANT`
    ;;

  dimension: plant {
    type: string
    hidden: yes
    sql: ${TABLE}.PLANT ;;
  }

  dimension: plant_desc {
    label: "Plant Name"
    type: string
    sql: ${TABLE}.PLANT_DESC ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
