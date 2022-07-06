include: "plant.view"

view: ketahanan_stock {
  extends: [plant]
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
     drill_fields: [detailPemakaianCurrent*]
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
    {% if material_group_type._value =='ADDITIVE' and value > 3 %}
    <p style="color: #12B5CB; font-size: 100%; text-align:left">{{rendered_value}}</p>
    {% elsif material_group_type._value =="ADDITIVE" and value > 1  and value <= 3 %}
    <p style="color: #E52592; font-size: 100%; text-align:left">{{rendered_value}}</p>
    {% elsif material_group_type._value =="ADDITIVE" and value <1 %}
    <p style="color: #1A73E8; font-size: 100%; text-align:left">{{rendered_value}}</p>
        {% elsif material_group_type._value =="LBO" and value > 20 %}
    <p style="color: #12B5CB; font-size: 100%; text-align:left">{{rendered_value}}</p>
     {% elsif material_group_type._value =="LBO" and value >  7 and value <= 20 %}
    <p style="color: #E52592; font-size: 100%; text-align:left">{{rendered_value}}</p>
    {% elsif material_group_type._value =="LBO" and value <7 %}
    <p style="color: #1A73E8; font-size: 100%; text-align:left">{{rendered_value}}</p>
    {% elsif material_group_type._value =="PACKAGING" and value > 3 %}
    <p style="color: #12B5CB; font-size: 100%; text-align:left">{{rendered_value}}</p>
     {% elsif material_group_type._value =="PACKAGING" and value > 1 and value <= 3 %}
    <p style="color: #E52592; font-size: 100%; text-align:left">{{rendered_value}}</p>
    {% elsif material_group_type._value =="PACKAGING" and value <1 %}
    <p style="color: #1A73E8; font-size: 100%; text-align:left">{{rendered_value}}</p>
    {% else %}
    <p style="color: black; font-size:100%; text-align:left">{{rendered_value}}</p>
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

    action: {
      label: "Create Order"
      url: "https://some_site"

      form_param: {
        name: "Material Number"
        default: "{{ material_number._value }}"
      }

      form_param: {
        name: "Material Name"
        default: "{{ material_desc._value }}"
      }

      form_param: {
        name: "Quantity to Order"
      }

      form_param: {
        name: "Current Ketahanan"
        default: "{{ ketahanan_stock._rendered_value }}"
      }

      form_param: {
        name: "Requester email"
        default: "{{ _user_attributes.email }}"
      }
    }
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
    drill_fields: [detailPemakaianCurrent*]
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
      month_name,
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
        sql: ${material_group_type}="ADDITIVE" and ${ketahanan_stock}>3 ;;
        label:"Safe"
      }
      when:{
        sql: ${material_group_type}="ADDITIVE" and ${ketahanan_stock}<=3 and ${ketahanan_stock}>1 ;;
        label:"Warning"
      }
      when:{
        sql: ${material_group_type}="ADDITIVE" and  ${ketahanan_stock}<1 ;;
        label:"Critical"
      }
      when:{
        sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock}>3 ;;
        label:"Safe"
      }
      when:{
        sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock}<=3 and ${ketahanan_stock}>1 ;;
        label:"Warning"
      }
      when:{
        sql: ${material_group_type}="PACKAGING" and ${ketahanan_stock}<1 ;;
        label:"Critical"
      }
      when:{
        sql: ${material_group_type}="LBO" and ${ketahanan_stock}>20 ;;
        label:"Safe"
      }
      when:{
        sql: ${material_group_type}="LBO" and ${ketahanan_stock}<=20 and ${ketahanan_stock}>7 ;;
        label:"Warning"
      }
      when:{
        sql: ${material_group_type}="LBO" and  ${ketahanan_stock}<7 ;;
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
    drill_fields: [detailPemakaianCurrent*]
  }

  measure: sum_current_stock {
    type: sum
    label: "Current Stock"
    sql: ${current_stock} ;;
    value_format_name: decimal_2
    drill_fields: [detailPemakaianCurrent*]
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
    order_by_field: posting_date
     type: string
     sql:  ${posting_month_name} ;;
  }


  set: details {
    fields: [material_number,material_desc, material_group_type, ketahanan_stock, in_transit_stock, ketahanan_stock_inc_intransit]


  }
  set: detailPemakaianCurrent{
    fields: [material_number,category_group,plant_desc,current_stock,sum_pemakaian_stock]

  }
}
