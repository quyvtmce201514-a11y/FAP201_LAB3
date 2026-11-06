library IEEE; use IEEE.STD_LOGIC_1164.ALL; 
 
entity lab03 is     
port (         
clk   : in  STD_LOGIC;         
i_sw  : in  STD_LOGIC;
o_led : out STD_LOGIC 
    ); 
end entity lab03; 
 
architecture rtl of lab03 is 
 

    signal current_sample  : STD_LOGIC := '0';
    signal previous_sample : STD_LOGIC := '0';     
    signal led_state       : STD_LOGIC := '0'; 
 
    signal release_event   : STD_LOGIC; 
 
begin  
    release_event <= previous_sample and (not current_sample);  
    process(clk)     begin 
        if rising_edge(clk) then 
 
            previous_sample <= current_sample; 
            current_sample  <= i_sw;  
            if release_event = '1' then                 
            led_state <= not led_state;             
            end if; 
        end if; 
    end process;  
    o_led <= led_state;  
end architecture rtl; 
