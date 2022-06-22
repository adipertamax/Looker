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
    sql: case when left(${posting_month})='01' then concat('Jan', ${posting_year})
    when left(${posting_month})='02' then concat('Feb', ${posting_year})
     when left(${posting_month})='03' then concat('Mar', ${posting_year})
     when left(${posting_month})='04' then concat('Apr', ${posting_year})
     when left(${posting_month})='05' then concat('May', ${posting_year})
     when left(${posting_month})='06' then concat('Jun', ${posting_year})
     when left(${posting_month})='07' then concat('Jul', ${posting_year})
     when left(${posting_month})='08' then concat('Aug', ${posting_year})
     when left(${posting_month})='09' then concat('Sep', ${posting_year})
     when left(${posting_month})='10' then concat('Oct', ${posting_year})
     when left(${posting_month})='11' then concat('Nov', ${posting_year})
     when left(${posting_month})='12' then concat('Dec', ${posting_year})
    else ${posting_month}
    end


    ;;
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
