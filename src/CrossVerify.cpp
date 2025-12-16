#include <iostream>
#include <cassert>
#include <cstdio>
#include <svdpi.h>

#define GREEN "\x1b[;32;1m"
#define YELLOW "\x1b[;33;1m"
#define NC "\x1b[0;m"
#define LOG_INFO(format, ...) printf(GREEN format NC "\n", ##__VA_ARGS__)
#define LOG_ERROR(format, ...) printf(YELLOW format NC "\n", ##__VA_ARGS__)

#define Assert(cond, format, ...)                                  \
    if (!(cond)) {                                                 \
        do {                                                       \
            fprintf(stderr, YELLOW format NC "\n", ##__VA_ARGS__); \
            assert(cond);                                          \
        } while (0);                                               \
    }

#ifdef __cplusplus
extern "C" {
#endif

#include <arch.h>
#include <iss.h>

// global static variables
static ISS *ref_iss                = NULL;
static arch_state_t iss_arch_state = {}, dut_state = {};
static bool get_flag = false;

void CrossVerify_init(const char *elf_path) {
    LOG_INFO("CrossVerify initialization...");
    ISS_ctor(&ref_iss, elf_path);
}

void CrossVerify_get_arch_state(const svLogicVecVal *dut_pc, const svLogicVecVal *dut_gpr) {
    // check logic vals
    assert(dut_pc[0].bval == 0);
    for (int i = 0; i < 32; i++) {
        assert(dut_gpr[0].bval == 0);
    }

    // get ISS architectural states
    iss_arch_state = ISS_get_arch_state(ref_iss);
    // get dut architectural states
    dut_state.current_pc = dut_pc[0].aval;
    for (int i = 0; i < 32; i++) {
        dut_state.gpr[i] = dut_gpr[i].aval;
    }
    // set get flag
    get_flag = true;
}

svBit CrossVerify_check(void) {
    assert(get_flag);
    // check for PC
    if (iss_arch_state.current_pc != dut_state.current_pc) {
        LOG_ERROR("CrossVerify check fail...");
        LOG_ERROR("Program Counter (PC) is different");
        LOG_ERROR("PC of Reference ISS: %x, PC of RTL DUT: %x",
                  iss_arch_state.current_pc, dut_state.current_pc);
        return false;
    }
    // check for GPR
    for (int i = 0; i < 32; i++) {
        if (iss_arch_state.gpr[i] != dut_state.gpr[i]) {
            LOG_ERROR("CrossVerify check fail...");
            LOG_ERROR("General Purpose Register %d is different", i);
            LOG_ERROR("Register %d of Reference ISS: %x, Register %d of RTL "
                      "DUT: %x",
                      i, iss_arch_state.gpr[i], i, dut_state.gpr[i]);
            return false;
        }
    }
    return true;
}

void CrossVerify_step(void) {
    ISS_step(ref_iss, 1);
}

void CrossVerify_fini(void) {
    LOG_INFO("CrossVerify finalization...");
    ISS_dtor(ref_iss);
}

#ifdef __cplusplus
}
#endif
