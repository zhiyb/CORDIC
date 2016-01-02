onerror {resume}
radix fpoint 15
radix fpoint 3
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/c0/reset
add wave -noupdate /test/c0/clk
add wave -noupdate /test/c0/start
add wave -noupdate /test/c0/x
add wave -noupdate /test/c0/y
add wave -noupdate /test/c0/theta
add wave -noupdate /test/c0/data_out_rot
add wave -noupdate /test/c0/xprime
add wave -noupdate /test/c0/yprime
add wave -noupdate /test/c0/r_x
add wave -noupdate -expand /test/c0/r_y
add wave -noupdate /test/c0/r_theta
add wave -noupdate /test/c0/r_data_out
add wave -noupdate /test/c0/x_out
add wave -noupdate /test/c0/y_out
add wave -noupdate /test/c0/theta_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30935 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 149
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {52500 ps}
