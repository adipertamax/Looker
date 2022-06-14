view: status_ketahanan {
  sql_table_name: `test_ptpl.STATUS_KETAHANAN`
    ;;

  dimension: category {
    type: string
    sql: ${TABLE}.CATEGORY ;;
  }

  dimension: color {
    type: string
    sql: ${TABLE}.COLOR ;;
  }

  dimension: condition {
    type: string
    sql: ${TABLE}.CONDITION ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.LABEL ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.UNIT ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
