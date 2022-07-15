view: RealisasiVSTarget{
  sql_table_name: `int-trial-gke.dm_ptpl.REALISASI_PRODUKSI`
    ;;

  dimension: kategori_grade {
    label: "Grade Category"
    type: string
    sql: ${TABLE}.KATEGORI_GRADE ;;
  }

  dimension: kategori_kemasan {
    label: "Packaging Category"
    type: string
    sql: ${TABLE}.KATEGORI_KEMASAN ;;
  }

  dimension: material_desc {
    type: string
    sql: ${TABLE}.MATERIAL_DESC ;;
  }

  dimension: material_number {
    label: "Kimap"
    type: string
    hidden: yes
    sql: ${TABLE}.MATERIAL_NUMBER ;;
  }

  dimension: material_number_key {
    type: string
    hidden: yes
    sql: CONCAT(${material_number},${plant}, cast(extract(month from ${posting_date}) as string), cast(extract(year from ${posting_date}) as string) ) ;;
  }

  dimension: plant {
    hidden: yes
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
      month_name,
      month_num,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.POSTING_DATE ;;
  }

  dimension: presentase_realisasi {
    type: number
    hidden: yes
    sql: ${TABLE}.PRESENTASE_REALISASI ;;
  }

  dimension: presentase_selisih {
    type: number
    hidden: yes
    sql: ${TABLE}.PRESENTASE_SELISIH ;;
  }

  dimension: realisasi {
    type: number
    sql: ${TABLE}.REALISASI ;;
  }



  dimension: target {
    hidden: yes
    type: number
    sql: ${TABLE}.TARGET ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  ####################==============TAMBAHAN=====================#####################


  dimension: Year_Produksi {
    type: number
    sql: extract(year from ${posting_date}) ;;

  }


  measure: sum_realisasi {
    label: "Realization"
    type: sum
    sql: ${realisasi} ;;
    value_format_name: decimal_0
    drill_fields: [details*]
    html: {{ rendered_value }} KL ;;
  }

  measure: sum_target {
    label: "Target"
    type: sum
    sql: ${target} ;;
    drill_fields: [details*]
  }

  measure: sum_selisih {
    label: "SelisihTooltip"
    type: number
    hidden: yes
    value_format_name: decimal_0
    sql: ${sum_realisasi}-${sum_target} ;;
  }



  measure: percent_of_realization_calc {
    label: "% of Realization"
    type: number
    value_format_name: percent_0
    sql:
      case when ${sum_target}=0 and ${sum_realisasi}>0 then 1
      when ${sum_target}=0 and ${sum_realisasi}=0 then 0
       else ${sum_realisasi}/${sum_target} end  ;;
    drill_fields: [details*]
    html:
      {{ rendered_value }}
      <br>
      <br>Realization: {{ sum_realisasi._rendered_value }}
      <br>Target: {{ sum_target._rendered_value }}
      <br>Difference: {{ sum_selisih._rendered_value }}
    ;;
  }

  measure: percent_of_diff_calc {
    label: "% of Difference"
    type: number
    value_format_name: percent_0
    sql: 1-${percent_of_realization_calc}  ;;
    drill_fields: [details*]
    html:
      <br>
      <br>Realization: {{ sum_realisasi._rendered_value }}
      <br>Target: {{ sum_target._rendered_value }}
      <br>Difference: {{ sum_selisih._rendered_value }}
    ;;
  }

  #hanya untuk detail
  measure: percent_of_realization {
    label: "% of Realization"
    type: number
    hidden: yes
    value_format_name: percent_0
    sql:  case when ${sum_target}=0 and ${sum_realisasi}>0 then 1
      when ${sum_target}=0 and ${sum_realisasi}=0 then 0
       else ${sum_realisasi}/${sum_target} end  ;;
    drill_fields: [details*]
    html:
    {% if value > 1 %}
      <p style="background-color: #91C483 ; font-size: 100%; text-align:center">{{rendered_value}}</p>
    {% else %}
      <p style="background-color: #FFE162; font-size:100%; text-align:center">{{rendered_value}}</p>
    {% endif %};;
  }

  measure: achievement {
    label: "achievement"
    type: number
    value_format_name: percent_0
    sql:
       case when ${sum_target}=0 and ${sum_realisasi}>0 then 1
      when ${sum_target}=0 and ${sum_realisasi}=0 then 0
       else ${sum_realisasi}/${sum_target} end  ;;
    drill_fields: [details*]
    }


  set: details {
    fields: [material_number, plant, kategori_kemasan, kategori_grade, material_desc,
      sum_target,sum_realisasi,percent_of_realization]
  }
}
