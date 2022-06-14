view: mard {
  sql_table_name: `test_ptpl.MARD`
    ;;

  dimension: _key_mard_lgort_mandt_matnr_werks {
    type: string
    sql: ${TABLE}._KEY_MARD_LGORT_MANDT_MATNR_WERKS ;;
  }

  dimension: _mdjin_mard {
    type: string
    sql: ${TABLE}._MDJIN_MARD ;;
  }

  dimension: _mdrue_mard {
    type: string
    sql: ${TABLE}._MDRUE_MARD ;;
  }

  dimension: blocked_consgt_kspem_mard {
    type: string
    sql: ${TABLE}.Blocked_Consgt_KSPEM_MARD ;;
  }

  dimension: blocked_speme_mard {
    type: string
    sql: ${TABLE}.Blocked_SPEME_MARD ;;
  }

  dimension: blocked_stock_kzils_mard {
    type: string
    sql: ${TABLE}.Blocked_stock_KZILS_MARD ;;
  }

  dimension: blocked_stock_kzvls_mard {
    type: string
    sql: ${TABLE}.Blocked_stock_KZVLS_MARD ;;
  }

  dimension: blocked_vmspe_mard {
    type: string
    sql: ${TABLE}.Blocked_VMSPE_MARD ;;
  }

  dimension: client_mandt_mard {
    type: string
    sql: ${TABLE}.Client_MANDT_MARD ;;
  }

  dimension: cnsgt_in_qinsp__kinsm_mard {
    type: string
    sql: ${TABLE}.Cnsgt_in_QInsp__KINSM_MARD ;;
  }

  dimension: created_on_ersda_mard {
    type: string
    sql: ${TABLE}.Created_On_ERSDA_MARD ;;
  }

  dimension: ctry_of_origin_herkl_mard {
    type: string
    sql: ${TABLE}.Ctry_of_origin_HERKL_MARD ;;
  }

  dimension: current_period_lfmon_mard {
    type: string
    sql: ${TABLE}.Current_period_LFMON_MARD ;;
  }

  dimension: df_stor_loc_lvl_lvorm_mard {
    type: string
    sql: ${TABLE}.DF_stor_loc_lvl_LVORM_MARD ;;
  }

  dimension: export_ind__exver_mard {
    type: string
    sql: ${TABLE}.Export_ind__EXVER_MARD ;;
  }

  dimension: in_qual__insp__insme_mard {
    type: string
    sql: ${TABLE}.In_Qual__Insp__INSME_MARD ;;
  }

  dimension: in_qual__insp__vmins_mard {
    type: string
    sql: ${TABLE}.In_qual__insp__VMINS_MARD ;;
  }

  dimension: in_transfer_vmuml_mard {
    type: string
    sql: ${TABLE}.In_transfer_VMUML_MARD ;;
  }

  dimension: inven_cor_fact__bskrf_mard {
    type: string
    sql: ${TABLE}.Inven_cor_fact__BSKRF_MARD ;;
  }

  dimension: last_count_date_dlinl_mard {
    type: string
    sql: ${TABLE}.Last_Count_Date_DLINL_MARD ;;
  }

  dimension: maint__status_pstat_mard {
    type: string
    sql: ${TABLE}.Maint__status_PSTAT_MARD ;;
  }

  dimension: material_matnr_mard {
    type: string
    sql: ${TABLE}.Material_MATNR_MARD ;;
  }

  dimension: mrp_ind__diskz_mard {
    type: string
    sql: ${TABLE}.MRP_ind__DISKZ_MARD ;;
  }

  dimension: phys__inv__blk_sperr_mard {
    type: string
    sql: ${TABLE}.Phys__Inv__Blk_SPERR_MARD ;;
  }

  dimension: picking_area_lwmkb_mard {
    type: string
    sql: ${TABLE}.Picking_area_LWMKB_MARD ;;
  }

  dimension: plant_werks_mard {
    type: string
    sql: ${TABLE}.Plant_WERKS_MARD ;;
  }

  dimension: preference_ind__exppg_mard {
    type: string
    sql: ${TABLE}.Preference_ind__EXPPG_MARD ;;
  }

  dimension: profit_center_prctl_mard {
    type: string
    sql: ${TABLE}.Profit_Center_PRCTL_MARD ;;
  }

  dimension: qual_insp_stock_kzilq_mard {
    type: string
    sql: ${TABLE}.QualInspStock_KZILQ_MARD ;;
  }

  dimension: qual_insp_stock_kzvlq_mard {
    type: string
    sql: ${TABLE}.QualInspStock_KZVLQ_MARD ;;
  }

  dimension: reorder_point_lminb_mard {
    type: string
    sql: ${TABLE}.Reorder_point_LMINB_MARD ;;
  }

  dimension: replenishmt_qty_lbstf_mard {
    type: string
    sql: ${TABLE}.Replenishmt_qty_LBSTF_MARD ;;
  }

  dimension: restr__consgt_keinm_mard {
    type: string
    sql: ${TABLE}.Restr__Consgt_KEINM_MARD ;;
  }

  dimension: restr__use_pp_vmein_mard {
    type: string
    sql: ${TABLE}.Restr__use_PP_VMEIN_MARD ;;
  }

  dimension: restricted_use_einme_mard {
    type: string
    sql: ${TABLE}.Restricted_Use_EINME_MARD ;;
  }

  dimension: restricted_use_kzile_mard {
    type: string
    sql: ${TABLE}.Restricted_use_KZILE_MARD ;;
  }

  dimension: restricted_use_kzvle_mard {
    type: string
    sql: ${TABLE}.Restricted_use_KZVLE_MARD ;;
  }

  dimension: returns_retme_mard {
    type: string
    sql: ${TABLE}.Returns_RETME_MARD ;;
  }

  dimension: returns_vmret_mard {
    type: string
    sql: ${TABLE}.Returns_VMRET_MARD ;;
  }

  dimension: sp_stock_value_vklab_mard {
    type: string
    sql: ${TABLE}.SP_stock_value_VKLAB_MARD ;;
  }

  dimension: spec_proc__sloc_lsobs_mard {
    type: string
    sql: ${TABLE}.Spec_proc__SLoc_LSOBS_MARD ;;
  }

  dimension: stk_transfer_sv_vkuml_mard {
    type: string
    sql: ${TABLE}.Stk_transfer_SV_VKUML_MARD ;;
  }

  dimension: stock_in_tfr_umlme_mard {
    type: string
    sql: ${TABLE}.Stock_in_tfr_UMLME_MARD ;;
  }

  dimension: stor__location_lgort_mard {
    type: string
    sql: ${TABLE}.Stor__Location_LGORT_MARD ;;
  }

  dimension: storage_bin_lgpbe_mard {
    type: string
    sql: ${TABLE}.Storage_Bin_LGPBE_MARD ;;
  }

  dimension: unrestr__consgt_klabs_mard {
    type: string
    sql: ${TABLE}.Unrestr__Consgt_KLABS_MARD ;;
  }

  dimension: unrestr__use_vmlab_mard {
    type: string
    sql: ${TABLE}.Unrestr__use_VMLAB_MARD ;;
  }

  dimension: unrestricted_labst_mard {
    type: string
    sql: ${TABLE}.Unrestricted_LABST_MARD ;;
  }

  dimension: warehouse_stock_kzill_mard {
    type: string
    sql: ${TABLE}.Warehouse_stock_KZILL_MARD ;;
  }

  dimension: warehouse_stock_kzvll_mard {
    type: string
    sql: ${TABLE}.Warehouse_stock_KZVLL_MARD ;;
  }

  dimension: year_cur_period_lfgja_mard {
    type: string
    sql: ${TABLE}.Year_cur_period_LFGJA_MARD ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
