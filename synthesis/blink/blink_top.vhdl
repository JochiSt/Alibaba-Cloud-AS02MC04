LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY blink_top IS
    PORT (
        clk_100mhz_p : IN STD_LOGIC;
        clk_100mhz_n : IN STD_LOGIC;
        led               : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END blink_top;

ARCHITECTURE behaviour OF blink_top IS
    SIGNAL sys_clk_100MHz : STD_LOGIC; -- system clock 100MHz

BEGIN

    -- create differential clock buffer
    IBUFGDS_0 : ENTITY work.IBUFGDS
        PORT MAP(
            I  => clk_100mhz_p, -- normal input
            IB => clk_100mhz_n, -- inverted input
            O  => sys_clk_100MHz     -- output
        );

    blink_0 : ENTITY work.blink
        GENERIC MAP(
            max_count => 100_000_000
        )
        PORT MAP(
            clk       => sys_clk_100MHz,
            blink_out => led(0)
        );
    blink_1 : ENTITY work.blink
        GENERIC MAP(
            max_count => 50_000_000
        )
        PORT MAP(
            clk       => sys_clk_100MHz,
            blink_out => led(1)
        );
    blink_2 : ENTITY work.blink
        GENERIC MAP(
            max_count => 200_000_000
        )
        PORT MAP(
            clk       => sys_clk_100MHz,
            blink_out => led(2)
        );
    blink_3 : ENTITY work.blink
        GENERIC MAP(
            max_count => 75_000_000
        )
        PORT MAP(
            clk       => sys_clk_100MHz,
            blink_out => led(3)
        );

END ARCHITECTURE; -- behaviour
