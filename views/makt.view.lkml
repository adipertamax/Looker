view: makt {
  sql_table_name: `test_ptpl.MAKT`
    ;;

  dimension: _key_makt_mandt_matnr_spras {
    type: string
    sql: ${TABLE}._KEY_MAKT_MANDT_MATNR_SPRAS ;;
  }

  dimension: client_mandt_makt {
    type: number
    sql: ${TABLE}.Client_MANDT_MAKT ;;
  }

  dimension: description_maktg_makt {
    type: string
    sql: ${TABLE}.Description_MAKTG_MAKT ;;
  }

  dimension: description_maktx_makt {
    type: string
    sql: ${TABLE}.Description_MAKTX_MAKT ;;
  }

  dimension: language_spras_makt {
    type: string
    sql: ${TABLE}.Language_SPRAS_MAKT ;;
  }

  dimension: material_matnr_makt {
    type: string
    sql: ${TABLE}.Material_MATNR_MAKT ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
