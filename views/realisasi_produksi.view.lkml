view: realisasi_produksi {
  sql_table_name: `int-trial-gke.dm_ptpl.REALISASI_PRODUKSI`
    ;;

  dimension: kategori_grade {
    type: string
    sql: ${TABLE}.KATEGORI_GRADE ;;
  }

  dimension: kategori_kemasan {
    type: string
    sql: ${TABLE}.KATEGORI_KEMASAN ;;
  }

  dimension: material_desc {
    type: string
    sql: ${TABLE}.MATERIAL_DESC ;;
  }

  dimension: material_number {
    type: string
    sql: ${TABLE}.MATERIAL_NUMBER ;;
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

  dimension: presentase_realisasi {
    type: number
    sql: ${TABLE}.PRESENTASE_REALISASI ;;
  }

  dimension: presentase_selisih {
    type: number
    sql: ${TABLE}.PRESENTASE_SELISIH ;;
  }

  dimension: realisasi {
    type: number
    sql: ${TABLE}.REALISASI ;;
  }

  dimension: selisih {
    type: number
    sql: ${TABLE}.SELISIH ;;
  }

  dimension: target {
    type: number
    sql: ${TABLE}.TARGET ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  ####################==============TAMBAHAN=====================#####################

  dimension: Month_Produksi {
    type: number
    sql: MONTH(${posting_date}) ;;

  }
  dimension: Year_Produksi {
    type: number
    sql: YEAR(${posting_date}) ;;
  }

  measure: sum_realisasi {
    type: sum
    sql: ${realisasi} ;;
  }

  measure: sum_target {
    type: sum
    sql: ${target} ;;
  }

  measure: sum_selisih {
    type: sum
    sql: ${selisih} ;;
  }

  measure: percent_of_diff {
    type: sum
    sql: ${presentase_selisih} ;;
  }

  measure: percent_of_realization {
    type: sum
    sql: ${presentase_realisasi} ;;
  }


}
