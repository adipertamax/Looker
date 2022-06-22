view: RealisasiVSTarget{
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

  dimension: material_number_key {
    type: string
    sql: CONCAT(${material_number},${plant}, cast(extract(month from ${posting_date}) as string), cast(extract(year from ${posting_date}) as string) ) ;;
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
    sql:extract(month from ${posting_date});;

  }
  dimension: Year_Produksi {
    type: number
    sql: extract(year from ${posting_date}) ;;

  }

  dimension: title {
    type: string
     case: {
      when:{
      sql: right(${posting_month},2)='01' ;;
        label: "Jan"
        }
      when:{
        sql: right(${posting_month},2)='02' ;;
        label: "Feb"
      }
      when:{
        sql: right(${posting_month},2)='03' ;;
        label: "Mar"
      }
      when:{
        sql: right(${posting_month},2)='04' ;;
        label: "Apr"
      }
      when:{
        sql: right(${posting_month},2)='05' ;;
        label: "May"
      }
      when:{
        sql: right(${posting_month},2)='06' ;;
        label: "Jun"
      }
      when:{
        sql: right(${posting_month},2)='07' ;;
        label: "Jul"
      }
      when:{
        sql: right(${posting_month},2)='08' ;;
        label: "Aug"
      }
      when:{
        sql: right(${posting_month},2)='09' ;;
        label: "Sep"
      }
      when:{
        sql: right(${posting_month},2)='10' ;;
        label: "Oct"
      }
      when:{
        sql: right(${posting_month},2)='11' ;;
        label: "Nov"
      }
      when:{
        sql: right(${posting_month},2)='12' ;;
        label: "Dec"
      }
      #else: "Not Defined"
    }

    html: <h1>Pencapaian Dashboard {{rendered_value}}</h1> ;;
  }


  measure: sum_realisasi {
    type: sum
    sql: ${realisasi} ;;
    value_format_name: decimal_0
    drill_fields: [details*]
  }

  measure: sum_target {
    type: sum
    sql: ${target} ;;
  }

  measure: sum_selisih {
    type: sum
    sql: ${selisih} ;;
  }

  measure: percent_of_realization_calc {
    type: number
    value_format_name: percent_2
    sql: ${sum_realisasi}/${sum_target} ;;
  }




  set: details {
    fields: [material_number, plant,kategori_kemasan, kategori_grade,material_desc, target, realisasi, presentase_realisasi]
  }
}
