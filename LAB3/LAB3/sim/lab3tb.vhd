library IEEE; use IEEE.STD_LOGIC_1164.ALL; 
 
entity lab03_tb is end entity lab03_tb; 
 
architecture sim of lab03_tb is 
 
    constant CLK_PERIOD : time := 20 ns; 
 
    signal clk   : STD_LOGIC := '0';     
    signal i_sw  : STD_LOGIC := '0'; 
    signal o_led : STD_LOGIC; 
 
begin 
 
    DUT : entity work.lab03         
port map ( clk   => clk,   
           i_sw  => i_sw,      
           o_led => o_led 
        ); 
 
    clk_process : process     
    begin         
    clk <= '0'; 
        wait for CLK_PERIOD / 2;  
        clk <= '1'; 
        wait for CLK_PERIOD / 2;     
    end process; 
 
    stimulus : process
     begin    
        assert o_led = '0'             
report "T0 FAILED: Initial LED state expected 0"             severity error;  
        -- T1: Press and hold         
i_sw <= '1';         wait for 220 ns;  
assert o_led = '0'             report "T1 FAILED: LED must not toggle while switch is held"             severity error; 
        -- T2: First release         
i_sw <= '0';         wait for 80 ns; 
assert o_led = '1'             report "T2 FAILED: LED must toggle ON after first release"             severity error;  
        -- T3: Stay released         
wait for 200 ns;  
        assert o_led = '1' 
            report "T3 FAILED: LED changed without a new release event"             severity error;  
        -- T4: Press again and hold         
i_sw <= '1';         wait for 240 ns;  
        assert o_led = '1' 
            report "T4 FAILED: Press must not toggle LED"             severity error; 
        -- T5: Second release         
i_sw <= '0';         wait for 80 ns;  
        assert o_led = '0' 
report "T5 FAILED: LED must toggle OFF after second release"             severity error;  
        -- T6: Fast logical press/release #1         
i_sw <= '1';         wait for 80 ns;         i_sw <= '0';         wait for 80 ns; 
        assert o_led = '1' 
            report "T6 FAILED: Fast release #1 did not toggle LED"             severity error; 
        -- T7: Fast logical press/release #2         
i_sw <= '1';         wait for 80 ns;         i_sw <= '0';         wait for 80 ns;  
        assert o_led = '0'             report "T7 FAILED: Fast release #2 did not toggle LED"             severity error; 
        report "LAB03: ALL SELF-CHECKING TESTS PASSED"             severity note;  
        wait;  
    end process stimulus;  
end architecture sim; 
