// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Tue Aug 11 23:42:21 2026
// Host        : DennisE16 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file {C:/Users/Dennis
//               Wong/Documents/FPGA_Projects/I2C_Controller/I2C_Controller/I2C_Controller.sim/sim_1/impl/func/xsim/my_sim_func_impl.v}
// Design      : Top_Module
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module I2C_Controller
   (sda_OBUF,
    sclk_OBUF,
    sda_TRI,
    CLK,
    cmd_IBUF,
    reset_n_IBUF,
    lopt);
  output sda_OBUF;
  output sclk_OBUF;
  output sda_TRI;
  input CLK;
  input [3:0]cmd_IBUF;
  input reset_n_IBUF;
  output lopt;

  wire CLK;
  wire \FSM_sequential_stateNow[0]_i_2_n_0 ;
  wire \FSM_sequential_stateNow[2]_i_2_n_0 ;
  wire \FSM_sequential_stateNow[2]_i_3_n_0 ;
  wire \FSM_sequential_stateNow[3]_i_1_n_0 ;
  wire [3:0]cmd_IBUF;
  wire [4:0]dataBit_next;
  wire [4:0]dataBit_now;
  wire \dataBit_now[2]_i_2_n_0 ;
  wire \dataBit_now[4]_i_1_n_0 ;
  wire \dataBit_now[4]_i_3_n_0 ;
  wire [4:0]dataByte_next1_in;
  wire \dataByte_now[4]_i_1_n_0 ;
  wire [4:0]dataByte_now_reg;
  wire i2c_sclk_reg_next;
  wire i2c_sda_out_en_i_1_n_0;
  wire i2c_sda_out_en_i_2_n_0;
  wire i2c_sda_out_en_i_3_n_0;
  wire i2c_sda_reg_next;
  wire i2c_sda_reg_next0;
  wire i2c_sda_reg_next__0;
  wire i2c_sda_reg_now_i_10_n_0;
  wire i2c_sda_reg_now_i_11_n_0;
  wire i2c_sda_reg_now_i_12_n_0;
  wire i2c_sda_reg_now_i_4_n_0;
  wire i2c_sda_reg_now_i_5_n_0;
  wire i2c_sda_reg_now_i_6_n_0;
  wire i2c_sda_reg_now_i_7_n_0;
  wire i2c_sda_reg_now_i_8_n_0;
  wire i2c_sda_reg_now_i_9_n_0;
  wire i2c_sda_reg_now_reg_lopt_replica_1;
  wire read_write_reg;
  wire read_write_reg_i_1_n_0;
  wire read_write_reg_i_2_n_0;
  wire reset_n_IBUF;
  wire sclk_OBUF;
  wire sda_OBUF;
  wire sda_TRI;
  wire [3:0]stateNext;
  wire [3:0]stateNow;

  assign lopt = i2c_sda_reg_now_reg_lopt_replica_1;
  LUT6 #(
    .INIT(64'h000000000AFFFFF3)) 
    \FSM_sequential_stateNow[0]_i_1 
       (.I0(\FSM_sequential_stateNow[2]_i_2_n_0 ),
        .I1(\FSM_sequential_stateNow[0]_i_2_n_0 ),
        .I2(stateNow[1]),
        .I3(stateNow[2]),
        .I4(stateNow[3]),
        .I5(stateNow[0]),
        .O(stateNext[0]));
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_sequential_stateNow[0]_i_2 
       (.I0(cmd_IBUF[1]),
        .I1(cmd_IBUF[2]),
        .I2(cmd_IBUF[3]),
        .O(\FSM_sequential_stateNow[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0F70)) 
    \FSM_sequential_stateNow[1]_i_1 
       (.I0(stateNow[3]),
        .I1(stateNow[2]),
        .I2(stateNow[1]),
        .I3(stateNow[0]),
        .O(stateNext[1]));
  LUT6 #(
    .INIT(64'h32C032003FC033C0)) 
    \FSM_sequential_stateNow[2]_i_1 
       (.I0(\FSM_sequential_stateNow[2]_i_2_n_0 ),
        .I1(stateNow[1]),
        .I2(stateNow[0]),
        .I3(stateNow[2]),
        .I4(\FSM_sequential_stateNow[2]_i_3_n_0 ),
        .I5(stateNow[3]),
        .O(stateNext[2]));
  LUT6 #(
    .INIT(64'h00000100FFFFFFFF)) 
    \FSM_sequential_stateNow[2]_i_2 
       (.I0(dataByte_now_reg[3]),
        .I1(dataByte_now_reg[4]),
        .I2(dataByte_now_reg[2]),
        .I3(dataByte_now_reg[0]),
        .I4(dataByte_now_reg[1]),
        .I5(read_write_reg),
        .O(\FSM_sequential_stateNow[2]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_stateNow[2]_i_3 
       (.I0(dataBit_now[3]),
        .I1(dataBit_now[4]),
        .O(\FSM_sequential_stateNow[2]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_sequential_stateNow[3]_i_1 
       (.I0(reset_n_IBUF),
        .O(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h62AA)) 
    \FSM_sequential_stateNow[3]_i_2 
       (.I0(stateNow[3]),
        .I1(stateNow[2]),
        .I2(stateNow[0]),
        .I3(stateNow[1]),
        .O(stateNext[3]));
  (* FSM_ENCODED_STATES = "data1:1000,hold:00000000000000000000000000000011,start2:0010,data_end:1100,start1:0001,idle:0000,addr_end:0111,addr4:0110,addr1:0011,stop2:1110,addr3:0101,addr2:0100,stop1:1101,iSTATE:00000000000000000000000000000100,data4:1011,data3:1010,data2:1001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_stateNow_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(stateNext[0]),
        .Q(stateNow[0]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "data1:1000,hold:00000000000000000000000000000011,start2:0010,data_end:1100,start1:0001,idle:0000,addr_end:0111,addr4:0110,addr1:0011,stop2:1110,addr3:0101,addr2:0100,stop1:1101,iSTATE:00000000000000000000000000000100,data4:1011,data3:1010,data2:1001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_stateNow_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(stateNext[1]),
        .Q(stateNow[1]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "data1:1000,hold:00000000000000000000000000000011,start2:0010,data_end:1100,start1:0001,idle:0000,addr_end:0111,addr4:0110,addr1:0011,stop2:1110,addr3:0101,addr2:0100,stop1:1101,iSTATE:00000000000000000000000000000100,data4:1011,data3:1010,data2:1001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_stateNow_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(stateNext[2]),
        .Q(stateNow[2]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "data1:1000,hold:00000000000000000000000000000011,start2:0010,data_end:1100,start1:0001,idle:0000,addr_end:0111,addr4:0110,addr1:0011,stop2:1110,addr3:0101,addr2:0100,stop1:1101,iSTATE:00000000000000000000000000000100,data4:1011,data3:1010,data2:1001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_stateNow_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(stateNext[3]),
        .Q(stateNow[3]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000000010CCDC)) 
    \dataBit_now[0]_i_1 
       (.I0(stateNow[3]),
        .I1(stateNow[0]),
        .I2(\dataBit_now[4]_i_3_n_0 ),
        .I3(\FSM_sequential_stateNow[2]_i_3_n_0 ),
        .I4(stateNow[2]),
        .I5(dataBit_now[0]),
        .O(dataBit_next[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \dataBit_now[1]_i_1 
       (.I0(\dataBit_now[2]_i_2_n_0 ),
        .I1(dataBit_now[0]),
        .I2(dataBit_now[1]),
        .O(dataBit_next[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h2A80)) 
    \dataBit_now[2]_i_1 
       (.I0(\dataBit_now[2]_i_2_n_0 ),
        .I1(dataBit_now[1]),
        .I2(dataBit_now[0]),
        .I3(dataBit_now[2]),
        .O(dataBit_next[2]));
  LUT6 #(
    .INIT(64'h5555000055550300)) 
    \dataBit_now[2]_i_2 
       (.I0(stateNow[2]),
        .I1(dataBit_now[4]),
        .I2(dataBit_now[3]),
        .I3(\dataBit_now[4]_i_3_n_0 ),
        .I4(stateNow[0]),
        .I5(stateNow[3]),
        .O(\dataBit_now[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h4004400473377307)) 
    \dataBit_now[3]_i_1 
       (.I0(stateNow[2]),
        .I1(stateNow[0]),
        .I2(\dataBit_now[4]_i_3_n_0 ),
        .I3(dataBit_now[3]),
        .I4(dataBit_now[4]),
        .I5(stateNow[3]),
        .O(dataBit_next[3]));
  LUT6 #(
    .INIT(64'h00550200AB000000)) 
    \dataBit_now[4]_i_1 
       (.I0(stateNow[0]),
        .I1(dataBit_now[3]),
        .I2(dataBit_now[4]),
        .I3(stateNow[1]),
        .I4(stateNow[2]),
        .I5(stateNow[3]),
        .O(\dataBit_now[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00008288)) 
    \dataBit_now[4]_i_2 
       (.I0(stateNow[0]),
        .I1(dataBit_now[4]),
        .I2(\dataBit_now[4]_i_3_n_0 ),
        .I3(dataBit_now[3]),
        .I4(stateNow[2]),
        .O(dataBit_next[4]));
  LUT3 #(
    .INIT(8'h7F)) 
    \dataBit_now[4]_i_3 
       (.I0(dataBit_now[2]),
        .I1(dataBit_now[1]),
        .I2(dataBit_now[0]),
        .O(\dataBit_now[4]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataBit_now_reg[0] 
       (.C(CLK),
        .CE(\dataBit_now[4]_i_1_n_0 ),
        .D(dataBit_next[0]),
        .Q(dataBit_now[0]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataBit_now_reg[1] 
       (.C(CLK),
        .CE(\dataBit_now[4]_i_1_n_0 ),
        .D(dataBit_next[1]),
        .Q(dataBit_now[1]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataBit_now_reg[2] 
       (.C(CLK),
        .CE(\dataBit_now[4]_i_1_n_0 ),
        .D(dataBit_next[2]),
        .Q(dataBit_now[2]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataBit_now_reg[3] 
       (.C(CLK),
        .CE(\dataBit_now[4]_i_1_n_0 ),
        .D(dataBit_next[3]),
        .Q(dataBit_now[3]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataBit_now_reg[4] 
       (.C(CLK),
        .CE(\dataBit_now[4]_i_1_n_0 ),
        .D(dataBit_next[4]),
        .Q(dataBit_now[4]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \dataByte_now[0]_i_1 
       (.I0(dataByte_now_reg[0]),
        .O(dataByte_next1_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \dataByte_now[1]_i_1 
       (.I0(dataByte_now_reg[0]),
        .I1(dataByte_now_reg[1]),
        .O(dataByte_next1_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \dataByte_now[2]_i_1 
       (.I0(dataByte_now_reg[2]),
        .I1(dataByte_now_reg[0]),
        .I2(dataByte_now_reg[1]),
        .O(dataByte_next1_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \dataByte_now[3]_i_1 
       (.I0(dataByte_now_reg[1]),
        .I1(dataByte_now_reg[0]),
        .I2(dataByte_now_reg[2]),
        .I3(dataByte_now_reg[3]),
        .O(dataByte_next1_in[3]));
  LUT5 #(
    .INIT(32'h00001000)) 
    \dataByte_now[4]_i_1 
       (.I0(stateNow[0]),
        .I1(stateNow[1]),
        .I2(stateNow[2]),
        .I3(stateNow[3]),
        .I4(\FSM_sequential_stateNow[2]_i_2_n_0 ),
        .O(\dataByte_now[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \dataByte_now[4]_i_2 
       (.I0(dataByte_now_reg[4]),
        .I1(dataByte_now_reg[1]),
        .I2(dataByte_now_reg[0]),
        .I3(dataByte_now_reg[2]),
        .I4(dataByte_now_reg[3]),
        .O(dataByte_next1_in[4]));
  FDRE #(
    .INIT(1'b0)) 
    \dataByte_now_reg[0] 
       (.C(CLK),
        .CE(\dataByte_now[4]_i_1_n_0 ),
        .D(dataByte_next1_in[0]),
        .Q(dataByte_now_reg[0]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataByte_now_reg[1] 
       (.C(CLK),
        .CE(\dataByte_now[4]_i_1_n_0 ),
        .D(dataByte_next1_in[1]),
        .Q(dataByte_now_reg[1]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataByte_now_reg[2] 
       (.C(CLK),
        .CE(\dataByte_now[4]_i_1_n_0 ),
        .D(dataByte_next1_in[2]),
        .Q(dataByte_now_reg[2]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataByte_now_reg[3] 
       (.C(CLK),
        .CE(\dataByte_now[4]_i_1_n_0 ),
        .D(dataByte_next1_in[3]),
        .Q(dataByte_now_reg[3]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dataByte_now_reg[4] 
       (.C(CLK),
        .CE(\dataByte_now[4]_i_1_n_0 ),
        .D(dataByte_next1_in[4]),
        .Q(dataByte_now_reg[4]),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h4B)) 
    i2c_sclk_reg_now_i_1
       (.I0(stateNow[0]),
        .I1(stateNow[3]),
        .I2(stateNow[1]),
        .O(i2c_sclk_reg_next));
  FDSE #(
    .INIT(1'b1)) 
    i2c_sclk_reg_now_reg
       (.C(CLK),
        .CE(1'b1),
        .D(i2c_sclk_reg_next),
        .Q(sclk_OBUF),
        .S(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF3FFFAAAAAAAA)) 
    i2c_sda_out_en_i_1
       (.I0(sda_TRI),
        .I1(stateNow[1]),
        .I2(stateNow[0]),
        .I3(stateNow[2]),
        .I4(stateNow[3]),
        .I5(i2c_sda_out_en_i_2_n_0),
        .O(i2c_sda_out_en_i_1_n_0));
  LUT6 #(
    .INIT(64'h3220302032200020)) 
    i2c_sda_out_en_i_2
       (.I0(i2c_sda_out_en_i_3_n_0),
        .I1(stateNow[3]),
        .I2(stateNow[2]),
        .I3(stateNow[1]),
        .I4(stateNow[0]),
        .I5(\FSM_sequential_stateNow[2]_i_3_n_0 ),
        .O(i2c_sda_out_en_i_2_n_0));
  LUT5 #(
    .INIT(32'h00000004)) 
    i2c_sda_out_en_i_3
       (.I0(dataBit_now[2]),
        .I1(dataBit_now[3]),
        .I2(dataBit_now[4]),
        .I3(dataBit_now[0]),
        .I4(dataBit_now[1]),
        .O(i2c_sda_out_en_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i2c_sda_out_en_reg
       (.C(CLK),
        .CE(1'b1),
        .D(i2c_sda_out_en_i_1_n_0),
        .Q(sda_TRI),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    i2c_sda_reg_now_i_1
       (.I0(i2c_sda_reg_next__0),
        .I1(i2c_sda_reg_next0),
        .O(i2c_sda_reg_next));
  LUT5 #(
    .INIT(32'h00000004)) 
    i2c_sda_reg_now_i_10
       (.I0(dataByte_now_reg[1]),
        .I1(dataByte_now_reg[0]),
        .I2(dataByte_now_reg[2]),
        .I3(dataByte_now_reg[4]),
        .I4(dataByte_now_reg[3]),
        .O(i2c_sda_reg_now_i_10_n_0));
  LUT4 #(
    .INIT(16'h5515)) 
    i2c_sda_reg_now_i_11
       (.I0(stateNow[2]),
        .I1(dataBit_now[1]),
        .I2(dataBit_now[2]),
        .I3(dataBit_now[0]),
        .O(i2c_sda_reg_now_i_11_n_0));
  LUT5 #(
    .INIT(32'h01000000)) 
    i2c_sda_reg_now_i_12
       (.I0(sda_OBUF),
        .I1(dataBit_now[3]),
        .I2(dataBit_now[4]),
        .I3(stateNow[1]),
        .I4(stateNow[0]),
        .O(i2c_sda_reg_now_i_12_n_0));
  LUT6 #(
    .INIT(64'h03B3B88B00808888)) 
    i2c_sda_reg_now_i_2
       (.I0(i2c_sda_reg_now_i_4_n_0),
        .I1(stateNow[3]),
        .I2(stateNow[1]),
        .I3(stateNow[0]),
        .I4(stateNow[2]),
        .I5(i2c_sda_reg_now_i_5_n_0),
        .O(i2c_sda_reg_next__0));
  LUT6 #(
    .INIT(64'hFFFF00FFBBFF3FFF)) 
    i2c_sda_reg_now_i_3
       (.I0(i2c_sda_reg_now_i_6_n_0),
        .I1(i2c_sda_reg_now_i_7_n_0),
        .I2(\FSM_sequential_stateNow[2]_i_3_n_0 ),
        .I3(stateNow[3]),
        .I4(i2c_sda_reg_now_i_8_n_0),
        .I5(stateNow[2]),
        .O(i2c_sda_reg_next0));
  LUT6 #(
    .INIT(64'h000000EAEAEA00EA)) 
    i2c_sda_reg_now_i_4
       (.I0(i2c_sda_reg_now_i_9_n_0),
        .I1(i2c_sda_out_en_i_3_n_0),
        .I2(i2c_sda_reg_now_i_10_n_0),
        .I3(i2c_sda_reg_now_i_11_n_0),
        .I4(read_write_reg),
        .I5(i2c_sda_reg_now_i_12_n_0),
        .O(i2c_sda_reg_now_i_4_n_0));
  LUT6 #(
    .INIT(64'hFF08FFFFFFFFFF00)) 
    i2c_sda_reg_now_i_5
       (.I0(dataBit_now[0]),
        .I1(read_write_reg),
        .I2(\FSM_sequential_stateNow[2]_i_3_n_0 ),
        .I3(read_write_reg_i_2_n_0),
        .I4(dataBit_now[1]),
        .I5(dataBit_now[2]),
        .O(i2c_sda_reg_now_i_5_n_0));
  LUT6 #(
    .INIT(64'h5555555555545555)) 
    i2c_sda_reg_now_i_6
       (.I0(read_write_reg),
        .I1(dataBit_now[1]),
        .I2(dataBit_now[0]),
        .I3(dataBit_now[4]),
        .I4(dataBit_now[3]),
        .I5(dataBit_now[2]),
        .O(i2c_sda_reg_now_i_6_n_0));
  LUT3 #(
    .INIT(8'h7F)) 
    i2c_sda_reg_now_i_7
       (.I0(read_write_reg),
        .I1(i2c_sda_reg_now_i_10_n_0),
        .I2(i2c_sda_out_en_i_3_n_0),
        .O(i2c_sda_reg_now_i_7_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    i2c_sda_reg_now_i_8
       (.I0(stateNow[1]),
        .I1(stateNow[0]),
        .O(i2c_sda_reg_now_i_8_n_0));
  LUT6 #(
    .INIT(64'hFF001000FFFFFFFF)) 
    i2c_sda_reg_now_i_9
       (.I0(dataBit_now[3]),
        .I1(dataBit_now[4]),
        .I2(stateNow[0]),
        .I3(stateNow[1]),
        .I4(stateNow[2]),
        .I5(read_write_reg),
        .O(i2c_sda_reg_now_i_9_n_0));
  FDSE #(
    .INIT(1'b1)) 
    i2c_sda_reg_now_reg
       (.C(CLK),
        .CE(1'b1),
        .D(i2c_sda_reg_next),
        .Q(sda_OBUF),
        .S(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDSE #(
    .INIT(1'b1)) 
    i2c_sda_reg_now_reg_lopt_replica
       (.C(CLK),
        .CE(1'b1),
        .D(i2c_sda_reg_next),
        .Q(i2c_sda_reg_now_reg_lopt_replica_1),
        .S(\FSM_sequential_stateNow[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFF2F00000020)) 
    read_write_reg_i_1
       (.I0(cmd_IBUF[0]),
        .I1(\FSM_sequential_stateNow[0]_i_2_n_0 ),
        .I2(read_write_reg_i_2_n_0),
        .I3(stateNow[3]),
        .I4(stateNow[0]),
        .I5(read_write_reg),
        .O(read_write_reg_i_1_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    read_write_reg_i_2
       (.I0(stateNow[1]),
        .I1(stateNow[2]),
        .O(read_write_reg_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    read_write_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(read_write_reg_i_1_n_0),
        .Q(read_write_reg),
        .R(\FSM_sequential_stateNow[3]_i_1_n_0 ));
endmodule

(* ECO_CHECKSUM = "619250ec" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module Top_Module
   (sys_clk,
    reset_n,
    cmd,
    sclk,
    sda);
  input sys_clk;
  input reset_n;
  input [3:0]cmd;
  output sclk;
  inout sda;

  wire [3:0]cmd;
  wire [3:0]cmd_IBUF;
  wire lopt;
  wire pll_output_clk;
  wire reset_n;
  wire reset_n_IBUF;
  wire sclk;
  wire sclk_OBUF;
  wire sda;
  wire sda_TRI;
  (* IBUF_LOW_PWR *) wire sys_clk;
  wire sys_tick;
  wire NLW_my_I2C_Controller_sda_OBUF_UNCONNECTED;
PULLUP pullup_sclk
       (.O(sclk));
PULLUP pullup_sda
       (.O(sda));

  (* IMPORTED_FROM = "c:/Users/Dennis Wong/Documents/FPGA_Projects/I2C_Controller/I2C_Controller/I2C_Controller.gen/sources_1/ip/sys_pll/sys_pll.dcp" *) 
  (* IMPORTED_TYPE = "CHECKPOINT" *) 
  (* IS_IMPORTED *) 
  sys_pll clock_40mhz
       (.clk_in1(sys_clk),
        .clk_out1(pll_output_clk),
        .resetn(reset_n_IBUF));
  IBUF \cmd_IBUF[0]_inst 
       (.I(cmd[0]),
        .O(cmd_IBUF[0]));
  IBUF \cmd_IBUF[1]_inst 
       (.I(cmd[1]),
        .O(cmd_IBUF[1]));
  IBUF \cmd_IBUF[2]_inst 
       (.I(cmd[2]),
        .O(cmd_IBUF[2]));
  IBUF \cmd_IBUF[3]_inst 
       (.I(cmd[3]),
        .O(cmd_IBUF[3]));
  I2C_Controller my_I2C_Controller
       (.CLK(sys_tick),
        .cmd_IBUF(cmd_IBUF),
        .lopt(lopt),
        .reset_n_IBUF(reset_n_IBUF),
        .sclk_OBUF(sclk_OBUF),
        .sda_OBUF(NLW_my_I2C_Controller_sda_OBUF_UNCONNECTED),
        .sda_TRI(sda_TRI));
  baud_rate_generator my_baud_rate_generator
       (.CLK(sys_tick),
        .clk_out1(pll_output_clk),
        .reset_n_IBUF(reset_n_IBUF));
  IBUF reset_n_IBUF_inst
       (.I(reset_n),
        .O(reset_n_IBUF));
  OBUF sclk_OBUF_inst
       (.I(sclk_OBUF),
        .O(sclk));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUFT sda_OBUFT_inst
       (.I(lopt),
        .O(sda),
        .T(sda_TRI));
endmodule

module baud_rate_generator
   (CLK,
    clk_out1,
    reset_n_IBUF);
  output CLK;
  input clk_out1;
  input reset_n_IBUF;

  wire CLK;
  wire clk_out1;
  wire \counterTick[0]_i_1_n_0 ;
  wire \counterTick[0]_i_3_n_0 ;
  wire [4:0]counterTick_reg;
  wire \counterTick_reg[0]_i_2_n_0 ;
  wire \counterTick_reg[0]_i_2_n_4 ;
  wire \counterTick_reg[0]_i_2_n_5 ;
  wire \counterTick_reg[0]_i_2_n_6 ;
  wire \counterTick_reg[0]_i_2_n_7 ;
  wire \counterTick_reg[4]_i_1_n_7 ;
  wire reset_n_IBUF;
  wire sys_tick_reg_i_1_n_0;
  wire sys_tick_reg_i_2_n_0;
  wire [2:0]\NLW_counterTick_reg[0]_i_2_CO_UNCONNECTED ;
  wire [3:0]\NLW_counterTick_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:1]\NLW_counterTick_reg[4]_i_1_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h00040000FFFFFFFF)) 
    \counterTick[0]_i_1 
       (.I0(counterTick_reg[1]),
        .I1(counterTick_reg[3]),
        .I2(counterTick_reg[0]),
        .I3(counterTick_reg[2]),
        .I4(counterTick_reg[4]),
        .I5(reset_n_IBUF),
        .O(\counterTick[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \counterTick[0]_i_3 
       (.I0(counterTick_reg[0]),
        .O(\counterTick[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counterTick_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\counterTick_reg[0]_i_2_n_7 ),
        .Q(counterTick_reg[0]),
        .R(\counterTick[0]_i_1_n_0 ));
  CARRY4 \counterTick_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\counterTick_reg[0]_i_2_n_0 ,\NLW_counterTick_reg[0]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\counterTick_reg[0]_i_2_n_4 ,\counterTick_reg[0]_i_2_n_5 ,\counterTick_reg[0]_i_2_n_6 ,\counterTick_reg[0]_i_2_n_7 }),
        .S({counterTick_reg[3:1],\counterTick[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \counterTick_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\counterTick_reg[0]_i_2_n_6 ),
        .Q(counterTick_reg[1]),
        .R(\counterTick[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counterTick_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\counterTick_reg[0]_i_2_n_5 ),
        .Q(counterTick_reg[2]),
        .R(\counterTick[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counterTick_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\counterTick_reg[0]_i_2_n_4 ),
        .Q(counterTick_reg[3]),
        .R(\counterTick[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counterTick_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\counterTick_reg[4]_i_1_n_7 ),
        .Q(counterTick_reg[4]),
        .R(\counterTick[0]_i_1_n_0 ));
  CARRY4 \counterTick_reg[4]_i_1 
       (.CI(\counterTick_reg[0]_i_2_n_0 ),
        .CO(\NLW_counterTick_reg[4]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_counterTick_reg[4]_i_1_O_UNCONNECTED [3:1],\counterTick_reg[4]_i_1_n_7 }),
        .S({1'b0,1'b0,1'b0,counterTick_reg[4]}));
  LUT3 #(
    .INIT(8'hE2)) 
    sys_tick_reg_i_1
       (.I0(CLK),
        .I1(reset_n_IBUF),
        .I2(sys_tick_reg_i_2_n_0),
        .O(sys_tick_reg_i_1_n_0));
  LUT5 #(
    .INIT(32'h00000200)) 
    sys_tick_reg_i_2
       (.I0(counterTick_reg[4]),
        .I1(counterTick_reg[2]),
        .I2(counterTick_reg[0]),
        .I3(counterTick_reg[3]),
        .I4(counterTick_reg[1]),
        .O(sys_tick_reg_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    sys_tick_reg_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(sys_tick_reg_i_1_n_0),
        .Q(CLK),
        .R(1'b0));
endmodule

module sys_pll
   (clk_out1,
    resetn,
    clk_in1);
  output clk_out1;
  input resetn;
  input clk_in1;

  wire clk_in1;
  wire clk_out1;
  wire resetn;

  sys_pll_clk_wiz inst
       (.clk_in1(clk_in1),
        .clk_out1(clk_out1),
        .resetn(resetn));
endmodule

module sys_pll_clk_wiz
   (clk_out1,
    resetn,
    clk_in1);
  output clk_out1;
  input resetn;
  input clk_in1;

  wire clk_in1;
  wire clk_in1_sys_pll;
  wire clk_out1;
  wire clk_out1_sys_pll;
  wire clkfbout_buf_sys_pll;
  wire clkfbout_sys_pll;
  wire resetn;
  wire NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT1_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED;
  wire NLW_mmcm_adv_inst_DRDY_UNCONNECTED;
  wire NLW_mmcm_adv_inst_LOCKED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_PSDONE_UNCONNECTED;
  wire [15:0]NLW_mmcm_adv_inst_DO_UNCONNECTED;

  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkf_buf
       (.I(clkfbout_sys_pll),
        .O(clkfbout_buf_sys_pll));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUF #(
    .IOSTANDARD("DEFAULT")) 
    clkin1_ibufg
       (.I(clk_in1),
        .O(clk_in1_sys_pll));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout1_buf
       (.I(clk_out1_sys_pll),
        .O(clk_out1));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* OPT_MODIFIED = "RETARGET" *) 
  MMCME2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT_F(10.000000),
    .CLKFBOUT_PHASE(0.000000),
    .CLKFBOUT_USE_FINE_PS("FALSE"),
    .CLKIN1_PERIOD(10.000000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE_F(25.000000),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT0_USE_FINE_PS("FALSE"),
    .CLKOUT1_DIVIDE(1),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT1_USE_FINE_PS("FALSE"),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT2_USE_FINE_PS("FALSE"),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT3_USE_FINE_PS("FALSE"),
    .CLKOUT4_CASCADE("FALSE"),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT4_USE_FINE_PS("FALSE"),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .CLKOUT5_USE_FINE_PS("FALSE"),
    .CLKOUT6_DIVIDE(1),
    .CLKOUT6_DUTY_CYCLE(0.500000),
    .CLKOUT6_PHASE(0.000000),
    .CLKOUT6_USE_FINE_PS("FALSE"),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(1),
    .IS_CLKINSEL_INVERTED(1'b0),
    .IS_PSEN_INVERTED(1'b0),
    .IS_PSINCDEC_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b1),
    .REF_JITTER1(0.010000),
    .REF_JITTER2(0.010000),
    .SS_EN("FALSE"),
    .SS_MODE("CENTER_HIGH"),
    .SS_MOD_PERIOD(10000),
    .STARTUP_WAIT("FALSE")) 
    mmcm_adv_inst
       (.CLKFBIN(clkfbout_buf_sys_pll),
        .CLKFBOUT(clkfbout_sys_pll),
        .CLKFBOUTB(NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED),
        .CLKFBSTOPPED(NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED),
        .CLKIN1(clk_in1_sys_pll),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKINSTOPPED(NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED),
        .CLKOUT0(clk_out1_sys_pll),
        .CLKOUT0B(NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED),
        .CLKOUT1(NLW_mmcm_adv_inst_CLKOUT1_UNCONNECTED),
        .CLKOUT1B(NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED),
        .CLKOUT2(NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED),
        .CLKOUT2B(NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED),
        .CLKOUT3(NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED),
        .CLKOUT3B(NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED),
        .CLKOUT4(NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED),
        .CLKOUT6(NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_mmcm_adv_inst_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_mmcm_adv_inst_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(NLW_mmcm_adv_inst_LOCKED_UNCONNECTED),
        .PSCLK(1'b0),
        .PSDONE(NLW_mmcm_adv_inst_PSDONE_UNCONNECTED),
        .PSEN(1'b0),
        .PSINCDEC(1'b0),
        .PWRDWN(1'b0),
        .RST(resetn));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
