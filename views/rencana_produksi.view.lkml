view: rencana_produksi {
  sql_table_name: `test_ptpl.RENCANA_PRODUKSI`
    ;;

  dimension: kimap {
    primary_key: yes
    type: string
    sql:distinct ${TABLE}.KIMAP ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.MONTH ;;
  }



  dimension: plant {
    type: string
    sql: ${TABLE}.PLANT ;;
  }

  dimension: qty {
    type: number
    sql: ${TABLE}.QTY ;;
  }

  dimension: random {
    type: number
    sql: ${TABLE}.RANDOM ;;
  }

  dimension: unk {
    type: number
    sql: ${TABLE}.UNK ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.YEAR ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  ####################======================TAMBAHAN===================#####################
  measure: sum_qty {
    type: sum
    sql: ${qty} ;;
    drill_fields: []
  }

}
