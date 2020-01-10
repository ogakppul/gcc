/*
   Auto-generated file, do not change by hand.

   Generated by:    f7renames.sh.
   Generated using: F7_PREFIX = __f7_ from t-libf7.
                    F7F, F7F_cst, F7F_asm from libf7-common.mk.
   Included by:     libf7.h.
   Used by:         libf7.c, libf7.h, libf7-asm.sx, f7-wraps.h.
*/

#ifndef F7_RENAMES_H
#define F7_RENAMES_H

#define F7_(name)  __f7_##name
#define F7P        __f7_
 
/* Renames for libf7.c, libf7.h.  */
 
#define f7_fabs __f7_fabs
#define f7_neg __f7_neg
#define f7_add __f7_add
#define f7_sub __f7_sub
#define f7_addsub __f7_addsub
#define f7_div __f7_div
#define f7_div1 __f7_div1
#define f7_divx __f7_divx
#define f7_fmod __f7_fmod
#define f7_sqrt __f7_sqrt
#define f7_cbrt __f7_cbrt
#define f7_square __f7_square
#define f7_mul __f7_mul
#define f7_mulx __f7_mulx
#define f7_madd_msub __f7_madd_msub
#define f7_madd __f7_madd
#define f7_msub __f7_msub
#define f7_hypot __f7_hypot
#define f7_Ineg __f7_Ineg
#define f7_Iadd __f7_Iadd
#define f7_Isub __f7_Isub
#define f7_Imul __f7_Imul
#define f7_Idiv __f7_Idiv
#define f7_IRsub __f7_IRsub
#define f7_Isquare __f7_Isquare
#define f7_Ildexp __f7_Ildexp
#define f7_Isqrt __f7_Isqrt
#define f7_le __f7_le
#define f7_lt __f7_lt
#define f7_gt __f7_gt
#define f7_ge __f7_ge
#define f7_ne __f7_ne
#define f7_eq __f7_eq
#define f7_cmp __f7_cmp
#define f7_cmp_abs __f7_cmp_abs
#define f7_ordered __f7_ordered
#define f7_unordered __f7_unordered
#define f7_cmp_unordered __f7_cmp_unordered
#define f7_lt_impl __f7_lt_impl
#define f7_gt_impl __f7_gt_impl
#define f7_le_impl __f7_le_impl
#define f7_ge_impl __f7_ge_impl
#define f7_eq_impl __f7_eq_impl
#define f7_ne_impl __f7_ne_impl
#define f7_unord_impl __f7_unord_impl
#define f7_lrint __f7_lrint
#define f7_ldexp __f7_ldexp
#define f7_frexp __f7_frexp
#define f7_exp __f7_exp
#define f7_logx __f7_logx
#define f7_log __f7_log
#define f7_log10 __f7_log10
#define f7_log2 __f7_log2
#define f7_minmax __f7_minmax
#define f7_fmax __f7_fmax
#define f7_fmin __f7_fmin
#define f7_floor __f7_floor
#define f7_ceil __f7_ceil
#define f7_round __f7_round
#define f7_lround __f7_lround
#define f7_trunc __f7_trunc
#define f7_truncx __f7_truncx
#define f7_horner __f7_horner
#define f7_pow10 __f7_pow10
#define f7_exp10 __f7_exp10
#define f7_pow __f7_pow
#define f7_powi __f7_powi
#define f7_sin __f7_sin
#define f7_cos __f7_cos
#define f7_tan __f7_tan
#define f7_cotan __f7_cotan
#define f7_sincos __f7_sincos
#define f7_sinh __f7_sinh
#define f7_cosh __f7_cosh
#define f7_tanh __f7_tanh
#define f7_sinhcosh __f7_sinhcosh
#define f7_asinacos __f7_asinacos
#define f7_asin __f7_asin
#define f7_acos __f7_acos
#define f7_atan __f7_atan
#define f7_atan2 __f7_atan2
#define f7_mul_noround __f7_mul_noround
#define f7_sqrt16_round __f7_sqrt16_round
#define f7_sqrt16_floor __f7_sqrt16_floor
#define f7_clr_mant_lsbs __f7_clr_mant_lsbs
#define f7_abscmp_msb_ge __f7_abscmp_msb_ge
#define f7_lshrdi3 __f7_lshrdi3
#define f7_ashldi3 __f7_ashldi3
#define f7_assert __f7_assert
#define f7_classify __f7_classify
#define f7_class_inf __f7_class_inf
#define f7_class_nan __f7_class_nan
#define f7_class_number __f7_class_number
#define f7_class_zero __f7_class_zero
#define f7_class_nonzero __f7_class_nonzero
#define f7_class_sign __f7_class_sign
#define f7_signbit __f7_signbit
#define f7_set_sign __f7_set_sign
#define f7_set_nan __f7_set_nan
#define f7_set_inf __f7_set_inf
#define f7_is_inf __f7_is_inf
#define f7_is_nan __f7_is_nan
#define f7_is_number __f7_is_number
#define f7_is_zero __f7_is_zero
#define f7_is_nonzero __f7_is_nonzero
#define f7_clr __f7_clr
#define f7_copy __f7_copy
#define f7_copy_P __f7_copy_P
#define f7_copy_mant __f7_copy_mant
#define f7_msbit __f7_msbit
#define f7_is0 __f7_is0
#define f7_cmp_mant __f7_cmp_mant
#define f7_store_expo __f7_store_expo
#define f7_abs __f7_abs
#define f7_set_s64 __f7_set_s64
#define f7_set_s32 __f7_set_s32
#define f7_set_s16 __f7_set_s16
#define f7_set_s16_impl __f7_set_s16_impl
#define f7_set_u16_worker __f7_set_u16_worker
#define f7_set_u64 __f7_set_u64
#define f7_set_u32 __f7_set_u32
#define f7_set_u16 __f7_set_u16
#define f7_set_u16_impl __f7_set_u16_impl
#define f7_set_float __f7_set_float
#define f7_set_pdouble __f7_set_pdouble
#define f7_set_double_impl __f7_set_double_impl
#define f7_set_double __f7_set_double
#define f7_init_impl __f7_init_impl
#define f7_init __f7_init
#define f7_get_s16 __f7_get_s16
#define f7_get_s32 __f7_get_s32
#define f7_get_s64 __f7_get_s64
#define f7_get_float __f7_get_float
#define f7_get_u16 __f7_get_u16
#define f7_get_u32 __f7_get_u32
#define f7_get_u64 __f7_get_u64
#define f7_get_double __f7_get_double
#define f7_set_eps __f7_set_eps
#define f7_set_1pow2 __f7_set_1pow2
#define f7_min __f7_min
#define f7_max __f7_max
#define f7_exp10 __f7_exp10
#define f7_floatunsidf __f7_floatunsidf
#define f7_floatsidf __f7_floatsidf
#define f7_extendsfdf2 __f7_extendsfdf2
#define f7_fixdfsi __f7_fixdfsi
#define f7_fixdfdi __f7_fixdfdi
#define f7_fixunsdfdi __f7_fixunsdfdi
#define f7_fixunsdfsi __f7_fixunsdfsi
#define f7_truncdfsf2 __f7_truncdfsf2
#define f7_le_impl __f7_le_impl
#define f7_lt_impl __f7_lt_impl
#define f7_gt_impl __f7_gt_impl
#define f7_ge_impl __f7_ge_impl
#define f7_ne_impl __f7_ne_impl
#define f7_eq_impl __f7_eq_impl
#define f7_unord_impl __f7_unord_impl
 
/* Renames for libf7.c, libf7.h.  */
 
#define f7_const_1   __f7_const_1
#define f7_const_1_P __f7_const_1_P
#define f7_const_2   __f7_const_2
#define f7_const_2_P __f7_const_2_P
#define f7_const_1_2   __f7_const_1_2
#define f7_const_1_2_P __f7_const_1_2_P
#define f7_const_1_3   __f7_const_1_3
#define f7_const_1_3_P __f7_const_1_3_P
#define f7_const_m1   __f7_const_m1
#define f7_const_m1_P __f7_const_m1_P
#define f7_const_pi   __f7_const_pi
#define f7_const_pi_P __f7_const_pi_P
#define f7_const_ln2   __f7_const_ln2
#define f7_const_ln2_P __f7_const_ln2_P
#define f7_const_ln10   __f7_const_ln10
#define f7_const_ln10_P __f7_const_ln10_P
#define f7_const_1_ln2   __f7_const_1_ln2
#define f7_const_1_ln2_P __f7_const_1_ln2_P
#define f7_const_1_ln10   __f7_const_1_ln10
#define f7_const_1_ln10_P __f7_const_1_ln10_P
#define f7_const_sqrt2   __f7_const_sqrt2
#define f7_const_sqrt2_P __f7_const_sqrt2_P
 
/* Renames for libf7-asm.sx, f7-wraps.h.  */
 
#define f7_classify_asm __f7_classify_asm
#define f7_store_expo_asm __f7_store_expo_asm
#define f7_clr_asm __f7_clr_asm
#define f7_copy_asm __f7_copy_asm
#define f7_copy_P_asm __f7_copy_P_asm
#define f7_copy_mant_asm __f7_copy_mant_asm
#define f7_cmp_mant_asm __f7_cmp_mant_asm
#define f7_normalize_asm __f7_normalize_asm
#define f7_store_expo_asm __f7_store_expo_asm
#define f7_set_u64_asm __f7_set_u64_asm
#define f7_set_s64_asm __f7_set_s64_asm
#define f7_addsub_mant_scaled_asm __f7_addsub_mant_scaled_asm
#define f7_mul_mant_asm __f7_mul_mant_asm
#define f7_to_integer_asm __f7_to_integer_asm
#define f7_to_unsigned_asm __f7_to_unsigned_asm
#define f7_clr_mant_lsbs_asm __f7_clr_mant_lsbs_asm
#define f7_div_asm __f7_div_asm
#define f7_sqrt_approx_asm __f7_sqrt_approx_asm
#define f7_sqrt16_round_asm __f7_sqrt16_round_asm
#define f7_sqrt16_floor_asm __f7_sqrt16_floor_asm
#define f7_lshrdi3_asm __f7_lshrdi3_asm
#define f7_ashldi3_asm __f7_ashldi3_asm
#define f7_class_D_asm __f7_class_D_asm
#define f7_call_ddd_asm __f7_call_ddd_asm
#define f7_call_xdd_asm __f7_call_xdd_asm
#define f7_call_ddx_asm __f7_call_ddx_asm
#define f7_call_dd_asm __f7_call_dd_asm
#define f7_call_xd_asm __f7_call_xd_asm
#define f7_call_dx_asm __f7_call_dx_asm

#endif /* F7_RENAMES_H */
