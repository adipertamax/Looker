view: kimap_category {
  sql_table_name: `test_ptpl.KIMAP_CATEGORY`
    ;;

  dimension: kategori_grade {
    type: string
    sql: ${TABLE}.KATEGORI_KEMASAN ;;
  }

  dimension: kategori_kemasan {
    type: string
    sql: ${TABLE}.KATEGORI_KEMASAN ;;
  }

  dimension: kimap {
    type: string
    sql: ${TABLE}.KIMAP ;;
  }

  dimension: minyak_lumas {
    type: string
    sql: ${TABLE}.MINYAK_LUMAS ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
