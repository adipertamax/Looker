view: ketahanan_stock {
  sql_table_name: `int-trial-gke.dm_ptpl.KETAHANAN_STOCK`
    ;;

  dimension: material_plant_key {
    primary_key: yes
    type: string
    hidden: yes
    sql: CONCAT(${material_number}, ${plant});;
  }

  dimension: avg_pemakaian_stock {
    type: number
    sql: ${TABLE}.AVG_PEMAKAIAN_STOCK ;;
    value_format_name: decimal_2
  }

  dimension: current_stock {
    type: number
    hidden: yes
    sql: ${TABLE}.CURRENT_STOCK ;;
    value_format_name: decimal_2
  }

  dimension: in_transit_stock {
    type: number
    hidden: yes
    sql: ${TABLE}.IN_TRANSIT_STOCK ;;
    value_format_name: decimal_2
  }

  dimension: ketahanan_stock {
    type: number
    sql: ${TABLE}.KETAHANAN_STOCK ;;
    value_format_name: decimal_2
    html:
    {% if material_group_type.rendered_value =="ADDITIVE" and value > 3 %}
    <p style="background-color: #12B5CB; font-size: 100%; text-align:center">{{rendered_value}}</p>
    {% else %}
    <p style="background-color: lightblue; font-size:100%; text-align:center">{{rendered_value}}</p>
    {% endif %};;
  }

  dimension: ketahanan_stock_inc_intransit {
    type: number
    sql: ${TABLE}.KETAHANAN_STOCK_INC_INTRANSIT ;;
  }

  dimension: lead_time {
    type: number
    sql: ${TABLE}.LEAD_TIME ;;
  }

  dimension: material_desc {
    type: string
    sql: ${TABLE}.MATERIAL_DESC ;;
  }

  dimension: material_group_type {
    label: "Category"
    type: string
    sql: ${TABLE}.MATERIAL_GROUP_TYPE ;;
  }

  dimension: material_number {
    type: string
    sql: ${TABLE}.MATERIAL_NUMBER ;;
  }

  dimension: pemakaian_stock {
    type: number
    hidden: yes
    sql: ${TABLE}.PEMAKAIAN_STOCK ;;
  }

  dimension: plant {
    type: string
    hidden: yes
    sql: ${TABLE}.PLANT ;;
  }

  dimension_group: posting {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.POSTING_DATE ;;
  }

#tambahan
  dimension: category_group  {
    type: string
    case: {
      when: {
        sql: ${TABLE}.material_group_type = 'ADDITIVE' ;;
        label: "Status"
      }
      when: {
        sql: ${TABLE}.material_group_type = 'PACKAGING' ;;
        label: "Status"
      }
      when: {
        sql: ${TABLE}.material_group_type = 'OIL BASE' ;;
        label: "Status LBO"
      }
     #else: "unknown"
    }

  }
  measure: count {
    label: "Jumlah Material"
    type: count
    drill_fields: [details*]
    # html:
    # {% if status_stock_ap.rendered_value = 'Safe' %}
    # <p style="background-color: #12B5CB; font-size: 100%; text-align:center">{{ketahanan_stock.rendered_value}}</p>
    # {% else %}
    # <p style="background-color: lightblue; font-size:100%; text-align:center">{{rendered_value}}</p>
    # {% endif %};;
}

  measure: sum_ketahanan {
    type: sum
    sql: ${ketahanan_stock};;
    drill_fields: []
  }

  measure: sum_ketahanan_intransit {
    type: sum
    sql: ${ketahanan_stock_inc_intransit};;
    drill_fields: []
  }

  measure: total_material {
    type: count_distinct
    sql: ${material_number} ;;
    drill_fields: [details*]
    value_format_name: decimal_2
  }

#Parameter ini Tidak bisa show di dashboard ?
  parameter: stock_granularity {
    type: string
    allowed_value: { value: "Stock" }
    allowed_value: { value: "In-Transit Stock" }
  }

  measure: stock_resistance {
    type:  number
    value_format: "#,###.00"
    label_from_parameter: stock_granularity
    sql:
    {% if stock_granularity._parameter_value == "'Stock'" %}
      ${sum_ketahanan}
    {% elsif stock_granularity._parameter_value == "'In-Transit Stock'" %}
      ${sum_ketahanan_intransit}
    {% else %}
      NULL
    {% endif %} ;;
    drill_fields: [details*]
  }

####Tambahan_anas#####
  dimension: status_stock_ap {
    type: string
   case: {
    when:{
      sql: ${material_group_type}="ADDITIVE" and ${ketahanan_stock}>=3 ;;
      label:"Safe"
    }
    when:{
      sql: ${material_group_type}="ADDITIVE" and ${ketahanan_stock}<3 and ${ketahanan_stock}>=1 ;;
      label:"Warning"
    }
    when:{
      sql: ${material_group_type}="ADDITIVE" and  ${ketahanan_stock}<1 ;;
      label:"Critical"
    }
    when:{
      sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock}>=3 ;;
      label:"Safe"
    }
    when:{
      sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock}<3 and ${ketahanan_stock}>=1 ;;
      label:"Warning"
    }
    when:{
      sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock}<1 ;;
      label:"Critical"
    }
    when:{
      sql: ${material_group_type}="LBO" and ${ketahanan_stock}>=15 ;;
      label:"Safe"
    }
    when:{
      sql: ${material_group_type}="LBO" and  ${ketahanan_stock}<15 ;;
      label:"Critical"
    }
    }
    }

  dimension: status_stock_in_transit_ap {
    type: string
    case: {
      when:{
        sql: ${material_group_type}="ADDITIVE" and ${ketahanan_stock_inc_intransit}>=3 ;;
        label:"Safe"
      }
      when:{
        sql: ${material_group_type}="ADDITIVE" and ${ketahanan_stock_inc_intransit}<3 and ${ketahanan_stock_inc_intransit}>=1 ;;
        label:"Warning"
      }
      when:{
        sql: ${material_group_type}="ADDITIVE" and  ${ketahanan_stock_inc_intransit}<1 ;;
        label:"Critical"
      }
      when:{
        sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock_inc_intransit}>=3 ;;
        label:"Safe"
      }
      when:{
        sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock_inc_intransit}<3 and ${ketahanan_stock_inc_intransit}>=1 ;;
        label:"Warning"
      }
      when:{
        sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock_inc_intransit}<1 ;;
        label:"Critical"
      }
      when:{
        sql: ${material_group_type}="LBO" and ${ketahanan_stock_inc_intransit}>=15 ;;
        label:"Safe"
      }
      when:{
        sql: ${material_group_type}="LBO" and ${ketahanan_stock_inc_intransit}<15 ;;
        label:"Critical"
      }
    }
  }


  parameter: param_stock {
    type: unquoted
    allowed_value: {

      label: "Status by Stock"
      value: "stock"
    }
    allowed_value: {
      label: "Status by InTransit"
      value: "inTransit"
    }
  }

  dimension: stock_test {
    type:  string
    sql:
    {% if param_stock._parameter_value == 'stock' %}
      ${status_stock_ap}
    {% elsif param_stock._parameter_value == 'inTransit' %}
      ${status_stock_in_transit_ap}
    {% else %}
     "Not Enable"
    {% endif %} ;;
  }

  dimension: param_status {
    type:  string
    sql:
    {% if stock_granularity._parameter_value == "'Stock'" %}
      ${status_stock_ap}
    {% elsif stock_granularity._parameter_value == "'In-Transit Stock'" %}
      ${status_stock_in_transit_ap}
    {% else %}
     "Not Enable"
    {% endif %} ;;
  }

  measure: jumlah {
    type: sum
    sql: CASE
        WHEN
          ${material_group_type}="ADDITIVE" THEN 1
        WHEN
          ${material_group_type}="PACKAGING" THEN 0
        WHEN
        ${material_group_type}="LBO" THEN 0
        END
      ;;
  }

  measure: sum_pemakaian_stock {
    type: sum
    label: "Pemakaian Bahan"
    sql: ${pemakaian_stock} ;;
  }

  measure: sum_current_stock {
    type: sum
    label: "Current Stock"
    sql: ${current_stock} ;;
    value_format_name: decimal_2
  }

  measure: sum_in_transit_stock {
    type: sum
    label: "In Transit Stock"
    sql: ${in_transit_stock} ;;
    value_format_name: decimal_2
  }

  measure: percent_of_current_usage {
    type: number
    label: "% of Current Usage"
    sql:  ${sum_pemakaian_stock}/${sum_current_stock};;
  }

  measure: percent_of_intransit_usage {
    type: number
    label: "% of In Transit Usage"
    sql:  ${sum_pemakaian_stock}/(${sum_in_transit_stock}+${sum_current_stock});;
  }

  measure: param_current_in_stock {
    label: "Stock"
    type:  number
    sql:
    {% if stock_granularity._parameter_value == "'Stock'" %}
      ${sum_current_stock}
    {% elsif stock_granularity._parameter_value == "'In-Transit Stock'" %}
      ${sum_in_transit_stock}
    {% else %}
     "Not Enable"
    {% endif %} ;;
  }

  measure: param_percent_usage {
    type:  number
    sql:
    {% if stock_granularity._parameter_value == "'Stock'" %}
      ${percent_of_current_usage}
    {% elsif stock_granularity._parameter_value == "'In-Transit Stock'" %}
      ${percent_of_intransit_usage}
    {% else %}
     "Not Enable"
    {% endif %} ;;
  }

  dimension: Month_Posting {
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
}
  }

  set: details {
    fields: [material_desc, material_group_type, ketahanan_stock, in_transit_stock, ketahanan_stock_inc_intransit]
  }
}
