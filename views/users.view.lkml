view: users {
  filter: state_filter{
    type: string
    suggest_dimension: state
    default_value: "california"
  }
  sql_table_name: public.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    html:
    {% if value > 20 %}
      <font color="darkgreen">{{ rendered_value }}</font>
    {% elsif value < 20 %}
      <font color="goldenrod">{{ rendered_value }}</font>
    {% else %}
      <font color="darkred">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: date_formatted {
    type: date
    sql: ${created_date} ;;
    html: {{ rendered_value | date: "%m/%d/%y" }} ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count, customers_count_by_state ]
  }

  measure: customers_count_by_state {
    type: count
    filters: [state: "California, Nevada, Washington, Oregon"]
    drill_fields: [id, first_name, last_name, orders.count, customers_count_by_state ]
  }
}
