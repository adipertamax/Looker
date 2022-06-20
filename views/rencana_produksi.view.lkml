view: rencana_produksi {
  derived_table: {
    sql:
      SELECT
        SELECT * FROM RENCANA_PRODUKSI` where  KIMAP<>'A060103727' and qty>0  ;;
  }

  dimension: kimap_material_key {
    primary_key: yes
    type: string
    sql:concat(${kimap},${plant},${month},${year}) ;;
  }

  dimension: kimap {
    type: string
    sql:${TABLE}.KIMAP ;;
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
