/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_2(char*, char *);
extern void execute_101(char*, char *);
extern void execute_102(char*, char *);
extern void execute_277(char*, char *);
extern void execute_278(char*, char *);
extern void execute_279(char*, char *);
extern void execute_280(char*, char *);
extern void execute_281(char*, char *);
extern void execute_100(char*, char *);
extern void execute_179(char*, char *);
extern void execute_180(char*, char *);
extern void execute_181(char*, char *);
extern void execute_182(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_185(char*, char *);
extern void execute_186(char*, char *);
extern void execute_189(char*, char *);
extern void execute_190(char*, char *);
extern void execute_193(char*, char *);
extern void execute_194(char*, char *);
extern void execute_197(char*, char *);
extern void execute_198(char*, char *);
extern void execute_201(char*, char *);
extern void execute_202(char*, char *);
extern void execute_205(char*, char *);
extern void execute_206(char*, char *);
extern void execute_209(char*, char *);
extern void execute_210(char*, char *);
extern void execute_213(char*, char *);
extern void execute_214(char*, char *);
extern void execute_217(char*, char *);
extern void execute_218(char*, char *);
extern void execute_221(char*, char *);
extern void execute_222(char*, char *);
extern void execute_225(char*, char *);
extern void execute_226(char*, char *);
extern void execute_229(char*, char *);
extern void execute_230(char*, char *);
extern void execute_233(char*, char *);
extern void execute_234(char*, char *);
extern void execute_237(char*, char *);
extern void execute_238(char*, char *);
extern void execute_241(char*, char *);
extern void execute_242(char*, char *);
extern void execute_245(char*, char *);
extern void execute_246(char*, char *);
extern void execute_249(char*, char *);
extern void execute_250(char*, char *);
extern void execute_253(char*, char *);
extern void execute_254(char*, char *);
extern void execute_257(char*, char *);
extern void execute_258(char*, char *);
extern void execute_261(char*, char *);
extern void execute_262(char*, char *);
extern void execute_265(char*, char *);
extern void execute_266(char*, char *);
extern void execute_269(char*, char *);
extern void execute_270(char*, char *);
extern void execute_273(char*, char *);
extern void execute_274(char*, char *);
extern void execute_5(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void execute_107(char*, char *);
extern void execute_108(char*, char *);
extern void execute_109(char*, char *);
extern void execute_104(char*, char *);
extern void execute_105(char*, char *);
extern void execute_106(char*, char *);
extern void execute_282(char*, char *);
extern void execute_283(char*, char *);
extern void execute_284(char*, char *);
extern void execute_285(char*, char *);
extern void execute_286(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[75] = {(funcp)execute_2, (funcp)execute_101, (funcp)execute_102, (funcp)execute_277, (funcp)execute_278, (funcp)execute_279, (funcp)execute_280, (funcp)execute_281, (funcp)execute_100, (funcp)execute_179, (funcp)execute_180, (funcp)execute_181, (funcp)execute_182, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_185, (funcp)execute_186, (funcp)execute_189, (funcp)execute_190, (funcp)execute_193, (funcp)execute_194, (funcp)execute_197, (funcp)execute_198, (funcp)execute_201, (funcp)execute_202, (funcp)execute_205, (funcp)execute_206, (funcp)execute_209, (funcp)execute_210, (funcp)execute_213, (funcp)execute_214, (funcp)execute_217, (funcp)execute_218, (funcp)execute_221, (funcp)execute_222, (funcp)execute_225, (funcp)execute_226, (funcp)execute_229, (funcp)execute_230, (funcp)execute_233, (funcp)execute_234, (funcp)execute_237, (funcp)execute_238, (funcp)execute_241, (funcp)execute_242, (funcp)execute_245, (funcp)execute_246, (funcp)execute_249, (funcp)execute_250, (funcp)execute_253, (funcp)execute_254, (funcp)execute_257, (funcp)execute_258, (funcp)execute_261, (funcp)execute_262, (funcp)execute_265, (funcp)execute_266, (funcp)execute_269, (funcp)execute_270, (funcp)execute_273, (funcp)execute_274, (funcp)execute_5, (funcp)execute_6, (funcp)execute_7, (funcp)execute_107, (funcp)execute_108, (funcp)execute_109, (funcp)execute_104, (funcp)execute_105, (funcp)execute_106, (funcp)execute_282, (funcp)execute_283, (funcp)execute_284, (funcp)execute_285, (funcp)execute_286, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 75;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/local_coincidence_tb_behav/xsim.reloc",  (void **)funcTab, 75);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/local_coincidence_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/local_coincidence_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/local_coincidence_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/local_coincidence_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/local_coincidence_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
