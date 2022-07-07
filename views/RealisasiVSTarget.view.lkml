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

  dimension: Month_Produksi {
    type: string
     case: {
      when:{
      sql: right(${posting_month},2)='01' ;;
        label:"JANUARI"
        }
      when:{
        sql: right(${posting_month},2)='02' ;;
        label: "FEBRUARI"
      }
      when:{
        sql: right(${posting_month},2)='03' ;;
        label: "MARET"
      }
      when:{
        sql: right(${posting_month},2)='04' ;;
        label: "APRIL"
      }
      when:{
        sql: right(${posting_month},2)='05' ;;
        label: "MEI"
      }
      when:{
        sql: right(${posting_month},2)='06' ;;
        label: "JUNI"
      }
      when:{
        sql: right(${posting_month},2)='07' ;;
        label: "JULI"
      }
      when:{
        sql: right(${posting_month},2)='08' ;;
        label: "AGUSTUS"
      }
      when:{
        sql: right(${posting_month},2)='09' ;;
        label: "SEPTEMBER"
      }
      when:{
        sql: right(${posting_month},2)='10' ;;
        label: "OKTOBER"
      }
      when:{
        sql: right(${posting_month},2)='11' ;;
        label: "NOVEMBER"
      }
      when:{
        sql: right(${posting_month},2)='12' ;;
        label: "DESEMBER"
      }
      #else: "Not Defined"
    }

    html: <p><b><font color="black" size="10" >      PENCAPAIAN DASHBOARD {{rendered_value}}</font><b><p> ;;
  }

  dimension: TitleFull {
    type: string
    sql: concat(${Month_Produksi},' ',${posting_year}) ;;
    html: <p><b><font color="black" size="8" >      PENCAPAIAN  {{rendered_value}} </font><b><p> ;;
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
    label: "Plan"
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

  measure: jumlah_kemasan {
    type: count_distinct
    sql: ${kategori_kemasan} ;;

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
      <li>Realisasi: {{ sum_realisasi._rendered_value }} </li>
      <li>Target: {{ sum_target._rendered_value }}</li>
      <li>Selisih: {{ sum_selisih._rendered_value }}</li>
    ;;
  }

  measure: percent_of_diff_calc {
    label: "% of Difference"
    type: number
    value_format_name: percent_0
    sql: 1-${percent_of_realization_calc}  ;;
    drill_fields: [details*]
    html:
      {{ rendered_value }}
      <li>Realisasi: {{ sum_realisasi._rendered_value }} </li>
      <li>Target: {{ sum_target._rendered_value }}</li>
      <li>Selisih: {{ sum_selisih._rendered_value }}</li>
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
      <p style="background-color: lightgreen; font-size: 100%; text-align:center">{{rendered_value}}</p>
    {% else %}
      <p style="background-color: lightblue; font-size:100%; text-align:center">{{rendered_value}}</p>
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

dimension: flag {
  type: string
  case: {
    when:{
      sql: ${realisasi}>${target} ;;
      label:"Yes"
    }
    when:{
      sql: ${realisasi}<=${target} ;;
      label:"No"
    }
    }

}

  measure: flag_dim {
    type: yesno
    sql: ${sum_realisasi}>${sum_target} ;;
  }

  set: details {
    fields: [material_number, plant, kategori_kemasan, kategori_grade, material_desc,
      sum_realisasi, sum_target,  percent_of_realization]
  }
}
