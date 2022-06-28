view: plant {
  sql_table_name: `test_ptpl.PLANT`
    ;;

  dimension: plant {
    type: string
    hidden: yes
    sql: ${TABLE}.PLANT ;;
  }

  dimension: plant_desc {
    label: "Plant Name"
    type: string
    sql: ${TABLE}.PLANT_DESC ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: region_indo {
    type: string
    case: {
      when: {
        sql: ${TABLE}.PLANT = 'LP01' ;;
        label: "JAKARTA"
      }
      when: {
        sql: ${TABLE}.PLANT = 'LP02' ;;
        label: "KABUPATEN CILACAP"
      }
      when: {
        sql: ${TABLE}.PLANT = 'LP03' ;;
        label: "KABUPATEN GRESIK"
      }
      #else: "unknown"
    }
  }

  dimension: longitude {
    hidden: yes
    type:string
    case: {
      when: {
        sql: ${TABLE}.PLANT = 'LP01' ;;
        label: "106.816666"
      }
      when: {
        sql:${TABLE}.PLANT = 'LP02' ;;
        label: "108.98861"
      }
      when: {
        sql: ${TABLE}.PLANT = 'LP03' ;;
        label: "112.553"
      }
    }
  }

  dimension: latitude {
    hidden: yes
    type:string
    case: {
      when: {
        sql: ${TABLE}.PLANT = 'LP01' ;;
        label: "-6.200000"
      }
      when: {
        sql: ${TABLE}.PLANT = 'LP02' ;;
        label: "-7.57417"
      }
      when: {
        sql: ${TABLE}.PLANT = 'LP03' ;;
        label: "-7.1933"
      }
    }
  }

  dimension: location {
    type:  location
    sql_latitude:${latitude} ;;
    sql_longitude:${longitude} ;;

  }

#   dimension: map_ptpl {
#     type: string
#     map_layer_name: region_indonesia    # this is your map layer
#     sql: ${region_indo};;
#   }


  dimension: testing_map {
    type: string
    map_layer_name: countries    # this is your map layer
    sql: ${region_indo};;
  }
}
