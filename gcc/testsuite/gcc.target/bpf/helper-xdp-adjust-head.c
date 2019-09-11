/* { dg-do compile } */

#include <stdint.h>

void
foo ()
{
  int ret;
  void *xdp_md;
  int delta;
  
  ret = __builtin_bpf_helper_xdp_adjust_head (xdp_md, delta);
}

/* { dg-final { scan-assembler "call\t44" } } */
