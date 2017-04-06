######################################################################
#
# Create work library
#
#
#
cd ../temp



exec vlib work
exec vlib xilinxcorelib_ver
exec vlib unisims_ver
exec vlib unimacro_ver
exec vlib secureip

set prj_dir "e:/Projects/project_20151030/VPX6_SFPGA_TOP/Projects/"
set src_dir e:/projects/spi_master/src
set tb_dir e:/projects/spi_master/tb
set ise_dir "d:/Xilinx/14.7/ISE_DS/ISE/verilog/src"
# Compile the library
#exec vlog -work xilinxcorelib_ver    $ise_dir/XilinxCoreLib/*.v   
#exec vlog -work unimacro_ver         $ise_dir/unimacro/*.v   
#exec vlog -work unisims_ver          $ise_dir/unisims/*.v   
#vlog -work secureip             d:/Xilinx/14.7/ISE_DS/ISE/secureip/mti/mti_secureip.list.f   

#
#
# Compile sources
#
exec vlog  $src_dir/spi_sim_master.v
exec vlog  $tb_dir/testbench.v

#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/pselect_f.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/counter_f.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/address_decoder.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/slave_attachment.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/sync_block.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/axi_lite_ipif.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/vector_decode.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/tx_client_fifo.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/rx_client_fifo.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/reset_sync.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/axi4_lite_ipif_wrapper.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/tri_mode_eth_mac_v5_2_block.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/ten_100_1g_eth_fifo.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/tri_mode_eth_mac_v5_2_fifo_block.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/basic_pat_gen.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/mac_src/axi_lite_sm.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/tri_mode_eth_mac_v5_2.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/reset_sync.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/gig_eth_pcs_pma_v11_2_block.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/transceiver/gtwizard_gt.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/transceiver/rx_elastic_buffer.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/transceiver/gtwizard.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/transceiver/transceiver.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/sgmii_adapt/johnson_cntr.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/sgmii_adapt/tx_rate_adapt.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/sgmii_adapt/rx_rate_adapt.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/sgmii_adapt/clk_gen.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/source/temac_connected_to_sgmii/coregen_files/gig_eth_pcs_pma_v11_2/example_design/sgmii_adapt/sgmii_adapt.v"
#vlog  "$prj_dir/HDLFiles/UdpIpCore_V3/ipcore/debug/ila_core.v"
#vlog  "d:/Xilinx/14.7/ISE_DS/ISE/verilog/src/glbl.v"
#
# Call vsim to invoke simulator
#
#vsim -voptargs="+acc" -t 1ps  -L xilinxcorelib_ver -L unisims_ver -L unimacro_ver -L secureip -lib work work.udpip_stack_top_tb glbl
#vsim -voptargs="+acc" -t 1ps  -L xilinxcorelib_ver  -L secureip -L unimacro_ver -lib work work.udpip_stack_top_tb glbl
set vsim_args \
{
    run 20us
}
exec vsim -c -voptargs="+acc" -t 1ps -lib work work.testbench -do "$vsim_args"


#
# Source the wave do file
#
exec vcd2wlf wave.vcd wave.wlf

set vsim_args \
{
    add_wave -position insertpoint -divide top;
    add_wave -position insertpoint -bin -internal -group internal wave:/testbench/*;
    add_wave -position insertpoint -bin -port -group port wave:/testbench/*;
    add_wave -position insertpoint -divide dut;
}
#
#Vsim can not invoke the modelsim,so use the 'modelsim' to replace it.
#
#exec vsim -do "$vsim_args" -view wave.wlf
exec modelsim -do "$vsim_args" -view wave.wlf

#
# Set the window types
#
#view wave
#view structure
#view signals
#
# Source the user do file
#
#do {udpip_stack_top_tb.udo}
#
# Run simulation for this time
#
#run 1000ns
#
# End
#


