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
    sql: ${TABLE}.CURRENT_STOCK ;;
    value_format_name: decimal_2
  }

  dimension: in_transit_stock {
    type: number
    sql: ${TABLE}.IN_TRANSIT_STOCK ;;
    value_format_name: decimal_2
  }

  dimension: ketahanan_stock {
    type: number
    sql: ${TABLE}.KETAHANAN_STOCK ;;
    value_format_name: decimal_2
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
    type: count
    drill_fields: []
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

  measure: count_material {
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

### parameter yg bisa digunakan
  parameter: choose_stock{
    type: unquoted
    allowed_value: {
      label: "Stock"
      value: "KETAHANAN_STOCK"
    }
    allowed_value: {
      label: "In Transit Stock"
      value: "KETAHANAN_STOCK_INC_INTRANSIT"
    }
  }

  measure: dynamic_sum {
    type: sum
    sql: ${TABLE}.{% parameter choose_stock %} ;;
    value_format: "#,###.00"
    drill_fields: [details*]
  }

  # dimension: title {
  #   type: string
  #   sql: ${plant};;
  #     html: <h1>Ketahanan on {{rendered_value}}</h1> ;;
  # }

  set: details {
    fields: [material_desc, material_group_type, ketahanan_stock, in_transit_stock, ketahanan_stock_inc_intransit]
  }
}
